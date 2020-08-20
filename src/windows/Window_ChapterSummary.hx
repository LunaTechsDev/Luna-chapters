package windows;

import rm.windows.Window_Base;
import types.Chapter;
import Chapters.Params;

class Window_ChapterSummary extends Window_Base {
 private var _chapter: Chapter = null;

 public function new(x: Int, y: Int, width: Int, height: Int) {
  super(x, y, width, height);
  super.initialize(x, y, width, height);
 }

 public function setChapter(chapter) {
  _chapter = chapter;
  refresh();
 }

 public override function update() {
  super.update();
 }

 public function refresh() {
  this.contents.clear();
  drawTitle();
  if (_chapter != null) {
   drawChapterSummary();
  }
 }

 public override function makeFontSmaller() {
  if (this.contents.fontSize >= 24) {
   contents.fontSize -= 8;
  }
 }

 public function drawTitle() {
  var width: Int = Std.int(width);
  var textWidth = Std.int(width - standardPadding());

  this.drawText(Params.summaryTitle, 0, 0, textWidth, 'center');
  this.contents.fillRect(0, 35, width, 5, Params.horizontalLineColor);
 }

 public function drawChapterSummary() {
  drawTextEx(_chapter.summary, 0, 45);
  this.resetFontSettings();
 }
}
