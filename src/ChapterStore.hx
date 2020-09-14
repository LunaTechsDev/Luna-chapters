package;

import types.Chapter;
import Chapters.Params;

class ChapterStore {
 public var chapters(default, null): Array<Chapter> = [];

 public function new() {
  chapters = Params.chapters;
 }

 public function get_chapters() {
  return chapters;
 }

 public function getChapterById(chapterId: Int): Chapter {
  return chapters[chapterId - 1];
 }

 public function getChapterDescription(chapterId: Int): String {
  return chapters[chapterId - 1].description;
 }

 public function isChapterLocked(chapterId: Int): Bool {
  return chapters[chapterId - 1].lockState;
 }

 public function lockChapter(chapterId: Int): Bool {
  return chapters[chapterId - 1].lockState = true;
 }

 public function unlockChapter(chapterId: Int): Bool {
  return chapters[chapterId - 1].lockState = false;
 }
}
