package scenes;

import core.Types.JsFn;
import utils.Comment;
import rm.managers.SceneManager;
// import core.Types.JsFn;
import rm.scenes.Scene_Title;
import utils.Fn;
import Chapters.Params;

class SceneTitle {
 public static inline function patch() {
  var oldCreateCommandWindow: JsFn = Fn.getPrProp(Scene_Title, 'createCommandWindow');
   Fn.setPrProp(Scene_Title, 'createCommandWindow', () -> {
     Comment.title('Scene_Title');
     var self: Scene_Title = Fn.self;
     oldCreateCommandWindow.call(self);
      if (Params.isChapterCommandEnabled) {
       self.__commandWindow.setHandler('chapterSelect', untyped self.commandChapter.bind(self));
      }
   });

  commandChapter();
 }

 public static inline function commandChapter() {
  Fn.setPrProp(Scene_Title, 'commandChapter', () -> {
   var self: Scene_Title = Fn.self;
   self.__commandWindow.close();
   SceneManager.push(Scene_Chapters);
  });
 }
}
