package;

import types.LockCommand;
import scenes.Scene_Chapters;
import rm.managers.SceneManager;
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
  registerCommands();
  DataManager.patch();
  SceneTitle.patch();
  TitleCommand.patch();
 }
 
 public static function registerCommands() {
  var pluginName: String = 'Luna_Chapters';

  PluginManager.registerCommand(pluginName, 'lock', (args) -> {
   var userInput: LockCommand = utils.Parse.parseParameters(args);
   Chapters.Store.lockChapter(userInput.chapterId);
  });

  PluginManager.registerCommand(pluginName, 'unlock', (args) -> {
   var userInput: LockCommand = utils.Parse.parseParameters(args);
   Chapters.Store.unlockChapter(userInput.chapterId);
  });

  PluginManager.registerCommand(pluginName, 'openScene', (_) -> {
   SceneManager.push(Scene_Chapters);
  });
 }
}
