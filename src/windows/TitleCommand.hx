package windows;

import utils.Comment;
import rm.managers.TextManager;
import rm.windows.Window_TitleCommand;
import utils.Fn;
import Chapters.Params;

class TitleCommand {
 public static inline function patch() {
   Comment.title('Window_TitleCommand');
  makeCommandList();
 }

 public static inline function makeCommandList() {
  Fn.setPrProp(Window_TitleCommand, 'makeCommandList', () -> {
   var self: Window_TitleCommand = Fn.self;
   self.addCommand(TextManager.newGame, 'newGame', true);
   self.addCommand(TextManager.continue_, 'continue', self.isContinueEnabled());
   self.addCommand(Params.chapterCommandText, 'chapterSelect', self.isContinueEnabled());
   self.addCommand(TextManager.options, 'options', true);
  });
 }
}
