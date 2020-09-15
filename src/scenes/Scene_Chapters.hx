package scenes;

import rm.core.Rectangle;
import js.html.Console;
import utils.Fn;
import rm.core.Sprite;
import types.Chapter;
import rm.Globals.GameSystem;
import rm.Globals.GameSwitches;
import rm.Globals.GameVariables;
import rm.Globals.GamePlayer;
import rm.Globals.DataSystem;
import rm.windows.Window_SavefileList;
import rm.scenes.Scene_MenuBase;
import rm.scenes.Scene_Map;
import rm.managers.DataManager;
import rm.managers.SoundManager;
import rm.managers.SceneManager;
import Chapters.Params;
import windows.Window_ChapterList;
import windows.Window_ChapterSummary;
import windows.Window_ChapterThumbnail;

@:keep()
class Scene_Chapters extends Scene_MenuBase {
 private var _scelectedChapter: Int;
 private var _loadSuccess: Bool;
 private var _saveFileList: Window_SavefileList;
 private var _thumbnailWindow: Window_ChapterThumbnail;
 private var _chapterSelectWindow: Window_ChapterList;
 private var _summaryWindow: Window_ChapterSummary;
 private var _selectedChapterIndex: Int;
 private var _chapterBackground: Sprite;

 public function new() {
  super();
  _scelectedChapter = 0;
  _loadSuccess = false;
  super.initialize();
 }

 public override function create() {
  DataManager.loadAllSavefileImages();
  createChapterBackground();
  createWindowLayer();
  createHelpWindow();
  createChapterSelect();
  createChapterThumbnail();
  createChapterSummary();
  createSaveFileList();
 }

 public override function start() {
  super.start();
  _saveFileList.refresh();
 }

 public override function update() {
  super.update();
  if (!_saveFileList.isClosing() && _saveFileList.isClosed() && !_chapterSelectWindow.isOpen()) {
   _thumbnailWindow.open();
   _summaryWindow.open();
   _chapterSelectWindow.open();
   _chapterSelectWindow.activate();
  }
  if (_selectedChapterIndex != _chapterSelectWindow.index()) {
   _selectedChapterIndex = _chapterSelectWindow.index();
   _thumbnailWindow.setChapter(selectedChapter());
   _summaryWindow.setChapter(selectedChapter());
  }
 }

 public override function isBottomHelpMode() {
  return false;
 };

 public override function isBottomButtonMode() {
  return true;
 };

 public function createChapterBackground() {
  _chapterBackground = new Sprite();
  addChild(_chapterBackground);
 }

 public function createChapterSelect() {
  var width = _tryEval(Params.chapterWindow.width);
  var height = _tryEval(Params.chapterWindow.height);
  var y = _tryEval(Params.chapterWindow.y);
  var rect = new Rectangle(0, y, width, height);

  _chapterSelectWindow = new Window_ChapterList(rect);
  _chapterSelectWindow.setHandler('ok', onChapterSelect);
  _chapterSelectWindow.setHandler('cancel', popScene);
  _chapterSelectWindow.close();
  addWindow(_chapterSelectWindow);
 }

 public function createChapterThumbnail() {
  var options = Params.thumbnailWindow;
  var width = _tryEval(options.width);
  var height = _tryEval(options.height);
  var y = _tryEval(options.y);
  var x = _tryEval(options.x);

  var rect = new Rectangle(x, y, width, height);

  _thumbnailWindow = new Window_ChapterThumbnail(rect);
  _thumbnailWindow.close();
  addWindow(_thumbnailWindow);
 }

 public function createChapterSummary() {
  var options = Params.summaryWindow;
  var width = _tryEval(options.width);
  var height = _tryEval(options.height);
  var y = _tryEval(options.y);
  var x = _tryEval(options.x);

  var rect = new Rectangle(x, y, width, height);

  _summaryWindow = new Window_ChapterSummary(rect);
  _summaryWindow.close();
  addWindow(_summaryWindow);
 }

 public function createSaveFileList() {
  var uiAreaWidth = DataSystem.advanced.uiAreaWidth;
  var uiAreaHeight = DataSystem.advanced.uiAreaHeight;
  var height = uiAreaHeight - _helpWindow.height;
  // var y = mainAreaTop();
  var rect = new Rectangle(0, 0, uiAreaWidth, height);

  _saveFileList = new Window_SavefileList(rect);
  _saveFileList.setHandler('ok', onSaveFileLoad);
  _saveFileList.setHandler('cancel', popScene);
  _saveFileList.setMode('load', GameSystem.isAutosaveEnabled());
  _saveFileList.selectSavefile(DataManager.latestSavefileId());
  _saveFileList.setTopRow(0 - 2);
  _helpWindow.setText('Load a save file');
  addWindow(_saveFileList);
 }

 public function selectedChapter(): Chapter {
  return _chapterSelectWindow.item();
 }

 public function setupSwitches(switchData: Array<Dynamic>) {
  if (switchData != null && switchData.length > 0) {
   for (data in switchData) {
    GameSwitches.setValue(data.id, data.value);
   }
  }
 }

 public function setupVariables(variableData: Array<Dynamic>) {
  if (variableData != null && variableData.length > 0) {
   for (data in variableData) {
    GameVariables.setValue(data.id, data.value);
   }
  }
 }

 public function onSaveFileLoad() {
  var savefileId = _saveFileList.index();

  DataManager.loadGame(savefileId).then(d -> {
   SoundManager.playLoad();
   _loadSuccess = true;
   _saveFileList.deactivate();
   _saveFileList.close();
   _helpWindow.setText(Params.helpWindowTerm);
   _chapterSelectWindow.refresh();
  }).catchError(err -> {
   _saveFileList.activate();
   SoundManager.playBuzzer();
  });
 }

 public function onChapterSelect() {
  var chapter: Chapter = selectedChapter();
  _chapterSelectWindow.close();
  fadeOutAll();
  if (chapter.requiredVariables != null) {
   setupVariables(chapter.requiredVariables);
  }
  if (chapter.requiredSwitches != null) {
   setupSwitches(chapter.requiredSwitches);
  }
  GamePlayer.reserveTransfer(chapter.startMapId, chapter.playerX, chapter.playerY);
  GamePlayer.requestMapReload();
  SceneManager.goto(Scene_Map);
 }

 private function _tryEval(expression): Dynamic {
  try {
   return Fn.eval(expression);
  } catch (error) {
   Console.error('Unable to evaluate the following expression ${expression}');
   return null;
  }
 }
}
