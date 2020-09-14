package;

import rm.managers.StorageManager;
import overrides.DataManager;
import pixi.interaction.EventEmitter;
import windows.TitleCommand;
import rm.managers.PluginManager;
import scenes.SceneTitle;

class Chapters {
 public static var Params: Dynamic;
 public static var Emitter: EventEmitter;
 public static var Store: ChapterStore;

 public static function main() {
  var rawParams = PluginManager.parameters('Luna_Chapters');
  Params = utils.Parse.parseParameters(rawParams);
  Emitter = new EventEmitter();
  Store = new ChapterStore();

  Emitter.on('game-saved', (savename: String) -> {
   StorageManager.saveObject(savename, Store);
  });
  DataManager.patch();
  SceneTitle.patch();
  TitleCommand.patch();
 }
}
