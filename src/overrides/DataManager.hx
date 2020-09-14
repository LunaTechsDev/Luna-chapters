package overrides;

import utils.Comment;
import core.Types.JsFn;
import utils.Fn;
import rm.managers.DataManager as RmDataManager;

class DataManager {
 public static inline function patch() {
   Comment.title('DataManager');
   saveGame();
 }

 public static inline function saveGame() {
  var oldSaveGame: JsFn = Fn.getField(RmDataManager, 'saveGame');
  Fn.setField(RmDataManager, 'saveGame', (savefileId) -> {
    var saveName = RmDataManager.makeSavename(savefileId);
    Chapters.Emitter.emit('game-saved', saveName);
   oldSaveGame.call(Fn.self);
  });
 }
}
