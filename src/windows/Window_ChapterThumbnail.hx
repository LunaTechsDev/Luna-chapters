package windows;

import rm.core.Sprite;
import rm.windows.Window_Base;
// import rm.managers.ImageManager;
import types.Chapter;

/**
 * @TODO - Load image data using the new MZ codebase
 */
class Window_ChapterThumbnail extends Window_Base {
 private var _chapter: Chapter = null;
 private var _thumbnail: Sprite = null;

 public function new(x: Int, y: Int, width: Int, height: Int) {
  super(x, y, width, height);
  super.initialize(x, y, width, height);
  _chapter = null;
  createThumbnail();
 }

 public function createThumbnail() {
  _thumbnail = new Sprite();
  _thumbnail.x = 0 + standardPadding();
  _thumbnail.y = 0 + standardPadding();
  _thumbnail.width = width / 2;
  _thumbnail.height = height / 2;
  addChild(_thumbnail);
 }

 public function setChapter(chapter) {
  _chapter = chapter;
  refresh();
 }

 public override function update() {
  super.update();
 }

 public function drawTextRect(text, rect) {
  var y = rect.y + contents.fontSize;
  var width = textWidth(text);
  contents.fillRect(rect.x, y, width + 25, 5, '#fcefb3');
 }

 public function refresh() {
  if (_chapter != null && _chapter.thumbnail != null) {
  /**
   * @TODO Use loadBitmapFromUrl when LunaTea is ready
   * 
    * _thumbnail.bitmap = ImageManager.loadBitmapFromUrl(_chapter.thumbnail);
   */
   _thumbnail.bitmap.addLoadListener((bitmap) -> {
    _thumbnail.width = (width - standardPadding() * 2);
   });
  }
 }
}
