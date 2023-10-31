import haxe.macro.Expr;
import haxe.macro.Context;
import haxe.macro.TypeTools;
import haxe.macro.Type.ClassType;

// import haxe.macro;
using Lambda;

typedef FieldData = {
  name: String,
  fields: Array<Field>,
  types: Array<haxe.macro.Type>
}

typedef ClassData = {
  externs: ClassType,
  local: FieldData
}

class Macros {
  public static var rmClasses: Map<String, ClassData> = new Map();

  private static function allInheritedFields(cType: ClassType): Array<Field> {
    var fields: Array<Field> = cast cType.fields.get();
    var superClass = cType.superClass;
    if (superClass != null) {
      return allInheritedFields(superClass.t.get()).concat(fields);
    } else {
      return fields;
    }
    return fields;
  }

  private static function isInherhitedBy(cType: ClassType, className: String): Bool {
    var superClass = cType.superClass;

    if (cType.name == className) {
      return true;
    }

    if (superClass != null) {
      return isInherhitedBy(superClass.t.get(), className);
    }
    return false;
  }

  #if macro
  @:nullSafety
  private static function _getClassFromConstExpr(e: Expr): ClassType {
    return switch (e.expr) {
      case EConst(CIdent(identifier)):
        return TypeTools.getClass(Context.getType(identifier));
      case _:
        return null;
    }
  }
  #end
  macro public static function rmClass(): Array<Field> {
    var localFields = Context.getBuildFields();
    var localClass = Context.getLocalClass().get();
    var localSuperClass = localClass.superClass.t.get();
    var localImports = Context.getLocalImports();

    for (index => key in rmClasses) {
      if (key.local.name != localClass.name && isInherhitedBy(localSuperClass, key.externs.name)) {
        for (field in key.local.fields) {
          var allSuperFields = allInheritedFields(localSuperClass);
          if (!localFields.exists(f -> f.name == field.name) && !allSuperFields.exists(f -> f.name == field.name)) {
            var newType = TAnonymous([
              {
                name: field.name,
                pos: Context.currentPos(),
                kind: FVar(macro : String)
              }
            ]);
            var newField: Field = {
              name: '__${key.local.name}_${field.name}',
              pos: Context.currentPos(),
              kind: FVar(newType)
            };
            localFields.push(newField);
          }
        }
      }

      for (localImport in localImports) {
        if (localImport.path.exists(i -> i.name == key.local.name)) {
          trace('found import to assign fields for');
        }
      }
    }

    if (!rmClasses.exists(localSuperClass.name)) {
      rmClasses.set(localSuperClass.name, {
        externs: localSuperClass,
        local: { name: localClass.name, fields: localFields, types: Context.getModule(localClass.module) }
      });
    }

    return localFields;
  }
}
