package overrides;

import rm.managers.SceneManager;
import rm.scenes.Scene_Title;
import Chapters.Params;
import scenes.Scene_Chapters;

class SceneTitle extends Scene_Title {
 public function new() {
  super();
 }

 public override function createCommandWindow() {
  super.createCommandWindow();
  if (Params.isChapterCommandEnabled) {
   _commandWindow.setHandler('chapterSelect', commandChapterSelect);
  }
 }

 public function commandChapterSelect() {
  _commandWindow.close();
  SceneManager.push(Scene_Chapters);
 }
}
