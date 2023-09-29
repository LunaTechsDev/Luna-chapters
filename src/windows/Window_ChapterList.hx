package windows;

import rm.core.Rectangle;
import rm.core.Bitmap;
import rm.windows.Window_Selectable;
import types.Chapter;
import Chapters.Params;

/**
 * @TODO - I used to use $gameSystem to store and load chapters.
 * I think its best to use the new StoragManager in MZ to store and load
 */
class Window_ChapterList extends Window_Selectable {
 private var _page: Int;
 private var _data: Array<Dynamic>;
 private var _thumbnails: Array<Bitmap>;

 public function new(rect: Rectangle) {
  super(rect);
  contents.fontSize = Params.chapterWindow.fontSize;
  refresh();
 }

 public override function refresh() {
  makeItemList();
  super.refresh();
  contents.clear();
  drawAllItems();
 }

 public override function itemHeight(): Float {
  return Params.chapterWindow.itemHeight;
 }

 public function item(): Dynamic {
  return _data != null && index() >= 0 ? _data[index()] : null;
 }

 public override function isCurrentItemEnabled() {
  return isOkEnabled();
 }

 public override function isOkEnabled(): Bool {
  return item() && item().lockState;
 }

 public function makeItemList() {
  this._data = Chapters.Store.chapters;
 }

 public override function maxItems() {
  return Params.chapterWindow.maxItems;
 }

 public function drawTextRect(text, rect: Rectangle) {
  var y = Math.round(rect.y + this.contents.fontSize);
  var width = this.textWidth(text);
  contents.fillRect(Math.round(rect.x), y, width + 25, 5, Params.horizontalLineColor);
 }

 public override function drawItem(index) {
  var chapter: Chapter = this._data[index];
  if (chapter != null) {
   var rect: Rectangle = this.itemRect(index);
  //  rect.width -= 8;
   rect.y += 5;
   rect.x += 5;
   changePaintOpacity(this.isOkEnabled());
   makeFontBigger();
   drawText(chapter.name, Math.round(rect.x), Math.round(rect.y), Math.round(rect.width), 'left');
   drawTextRect(chapter.name, rect);
   makeFontSmaller();
   var width = drawTextEx(chapter.description, Math.round(rect.x), Math.round(rect.y + 50), rect.width);
   trace(width);
  }
 }
}
