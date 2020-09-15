package windows;

import rm.core.Rectangle;
import rm.core.Sprite;
import rm.windows.Window_Base;
import rm.managers.ImageManager;
import rm.Globals.GameSystem;
import types.Chapter;

/**
 * @TODO - Load image data using the new MZ codebase
 */
class Window_ChapterThumbnail extends Window_Base {
 private var _chapter: Chapter;
 private var _thumbnail: Sprite;

 public function new(rect: Rectangle) {
  super(rect);
  super.initialize(rect);
  _chapter = null;
  createThumbnail();
 }

 public function createThumbnail() {
  var padding = GameSystem.windowPadding();
  _thumbnail = new Sprite();
  _thumbnail.x = 0 + padding;
  _thumbnail.y = 0 + padding;
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
    var path = 'img/${_chapter.thumbnail}.png';
   _thumbnail.bitmap = ImageManager.loadBitmapFromUrl(path);
   _thumbnail.bitmap.addLoadListener((bitmap) -> {
    var padding = GameSystem.windowPadding();
    _thumbnail.width = (width - padding * 2);
   });
  }
 }
}
