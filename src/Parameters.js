/*:
 * @plugindesc A chapter selection system for your games
 * <Luna_Chapters>
 *
 * @target MZ MV
 * @author LunaTechs | inc0der
 * @url https://lunatechs.dev/plugins/luna-chapters/
 *
 * @param chapters
 * @text Chapters
 * @type struct<Chapter>[]
 * @desc A list of all your chapters
 * @default ["{\"name\":\"01 That Dream\",\"description\":\"\\\"One day it all made sense, the next, well, the next day,\\\\nlets just say everything started \\\\nto change.\\\"\",\"summary\":\"\\\"\\\\\\\\C[3]Harold\\\\\\\\C[0] fell ill and \\\\\\\\C[3]Thersea\\\\\\\\C[0] set out\\\\non an adventure for a rare herb.\\\"\",\"thumbnail\":\"pictures/snowy_winter\",\"lockState\":\"true\",\"startMapId\":\"1\",\"playerX\":\"18\",\"playerY\":\"9\",\"requiredVariables\":\"[\\\"{\\\\\\\"id\\\\\\\":\\\\\\\"2\\\\\\\",\\\\\\\"value\\\\\\\":\\\\\\\"1\\\\\\\"}\\\"]\",\"requiredSwitches\":\"[\\\"{\\\\\\\"id\\\\\\\":\\\\\\\"2\\\\\\\",\\\\\\\"value\\\\\\\":\\\\\\\"true\\\\\\\"}\\\",\\\"{\\\\\\\"id\\\\\\\":\\\\\\\"3\\\\\\\",\\\\\\\"value\\\\\\\":\\\\\\\"true\\\\\\\"}\\\"]\"}","{\"name\":\"02 Once Upon A Star\",\"description\":\"\\\"There it was, I gazed upon the starry\\\\nnight's sky and then it all made\\\\nsense. \\\\\\\\i[10]\\\"\",\"summary\":\"\\\"Travel the \\\\\\\\C[1] Dark Woods \\\\\\\\C[0] and\\\\nfind the \\\\\\\\C[4]Golden Stone.\\\"\",\"thumbnail\":\"pictures/starry_night\",\"lockState\":\"false\",\"startMapId\":\"2\",\"playerX\":\"14\",\"playerY\":\"7\",\"requiredVariables\":\"[\\\"{\\\\\\\"id\\\\\\\":\\\\\\\"11\\\\\\\",\\\\\\\"value\\\\\\\":\\\\\\\"1\\\\\\\"}\\\"]\",\"requiredSwitches\":\"[\\\"{\\\\\\\"id\\\\\\\":\\\\\\\"10\\\\\\\",\\\\\\\"value\\\\\\\":\\\\\\\"true\\\\\\\"}\\\",\\\"{\\\\\\\"id\\\\\\\":\\\\\\\"11\\\\\\\",\\\\\\\"value\\\\\\\":\\\\\\\"true\\\\\\\"}\\\"]\"}","{\"name\":\"03 The Supernatural\",\"description\":\"\\\"This is when it all starts to get\\\\nreally weird. Are you ready for it\\\\nall?\\\"\",\"summary\":\"\\\"\\\"\",\"thumbnail\":\"\",\"lockState\":\"false\",\"startMapId\":\"3\",\"playerX\":\"5\",\"playerY\":\"2\",\"requiredVariables\":\"[]\",\"requiredSwitches\":\"[]\"}"]
 *
 * @param chapterWindow
 * @text Chapter Window Options
 * @type struct<ItemWindow>
 * @desc The customizations for the chapter selection window
 * @default {"x":"0","y":"this._helpWindow.height","width":"Graphics.width / 2","height":"Graphics.height - this._helpWindow.height","itemHeight":"160","maxItems":"4","fontSize":"18"}
 *
 * @param thumbnailWindow
 * @text Thumbnail Window Options
 * @type struct<BasicWindow>
 * @desc The customizations for the thumbnail window
 * @default {"x":"this._chapterSelectWindow.width","y":"this._helpWindow.height","width":"Graphics.width / 2","height":"Graphics.height / 2"}
 *
 * @param summaryWindow
 * @text Summary Window Options
 * @type struct<BasicWindow>
 * @desc The customizations for the summary window
 * @default {"x":"this._thumbnailWindow.x","y":"this._thumbnailWindow.y + this._thumbnailWindow.height","width":"Graphics.width / 2","height":"Graphics.height - (this._thumbnailWindow.height + this._helpWindow.height)"}
 *
 * 
 * @param horizontalLineColor
 * @text Horizontal Line Color
 * @type string
 * @desc The horizontal line color. This line is drawn under chapter titles
 * @default #fcefb3
 *
 * @param helpWindowTerm
 * @text Help Window Term
 * @type string
 * @desc The term used in the help window when selecting a chapter
 * @default Select a chapter to continue
 *
 * @param summaryTitle
 * @text Summary Title
 * @type string
 * @desc The term used as the title to th summary window
 * @default Summary
 *
 * @param isChapterCommandEnabled
 * @text Chapter Command Enabled
 * @type boolean
 * @desc Should the chapter command be included in the title scene's command window
 * @default true
 *
 * @param chapterCommandText
 * @text Chapter Command Text
 * @type string
 * @desc The text to use as the command's name on the title scene's command window
 * @default Chapter Select
 *
 * -- Plugin Commands --
 *
 * @command openScene
 * @text Open Scene
 * @desc Opens the chapter selection scene.
 * 
 * @command lock
 * @text Lock
 * @desc Locks a chapter from being accessed.
 * @arg chapterId
 * @text Chapter ID
 * @desc The chapter by its ID you would like to lock.
 * @type number
 * @default true
 * 
 * @command unlock
 * @text Unlock
 * @desc Unlocks a chapter so it can be accessed.
 * @arg chapterId
 * @text Chapter ID
 * @desc The chapter by its ID you would like to unlock.
 * @type number
 * @default true
 *
 * @help
--------------------------------------------------------------------------------
 # TERMS OF USE

 MIT License -

 * Free for use in any RPG Maker MV game project, commercial or otherwise

 * Credit may go to FeniXEngine Contributors or FeniXEngine

 * Though not required, you may provide a link back to the original source code,
   repository or website.
 -------------------------------------------------------------------------------
  # INSTALLATION

  Place the plugin file directly in your game project's `/js/plugins/`
  directory

 -------------------------------------------------------------------------------
 # INFORMATION

 This plugin provides the user the option of creating chapters for their game.
 Each chapter will allow you to reset and setup switches and variables which
 will be required for the player to play through the chapter again.

 -------------------------------------------------------------------------------
 # Parameters
 The plugin's parameters provide many options for you to customize the way the
 chapter is presented in the chapter selection scene.

 What is Required switches and variables?

 These are the switches and variables that you know are required to be setup
 in a way that the chapter can correctly proceed. For example if you did a
 full play-through of your game, then some switches and variables will be
 incorrectly set. Starting a chapter without resetting the switch and variable
 values would probably cause unexpected behavior and the chapter would be
 unplayable.

 -------------------------------------------------------------------------------
 # Script Calls

 $gameSystem.chapters()
 This script call return an array of all chapters

 $gameSystem.getChapterById(chapterId)
 Returns the chapter object by its ID

 $gameSystem.getChapterDescription()
 Returns the chapters description

 $gameSystem.isChapterLocked()
 Returns true is the chapter is locked

 $gameSystem.lockChapter()
 Locks the chapter

 $gameSystem.unlockChapter()
 Unlocks the chapter

 -------------------------------------------------------------------------------
 # Plugin Commands

 The Plugin command keyword is: Chapter

 ## Open Chapter Select Scene
 Chapter Open

 ## Lock a chapter
 Chapter Lock chapterId

 ## Unlock a chapter
 Chapter Unlock chapterId

*/

/*~struct~Chapter:
 * @param name
 * @text Name
 * @type string
 * @desc The name of this chapter
 * @default
 *
 * @param description
 * @text Description
 * @type note
 * @desc A description or small summary of this chapter
 * @default
 *
 * @param summary
 * @text Summary
 * @type note
 * @desc A small summary of the events which occurred during this chapter
 * @default
 *
 * @param thumbnail
 * @text Thumbnail
 * @type file
 * @dir /img/
 * @desc A picture or screenshot to represent this chapter
 * @default
 *
 * @param lockState
 * @text Lock State
 * @type boolean
 * @on Unlock
 * @off Lock
 * @desc The default state of this chapter's lock. Enable to allow access on a new game
 * @default false
 *
 * @param startMapId
 * @text Start Map ID
 * @type number
 * @desc The map this chapter should load and set the player location to.
 * @default
 *
 * @param playerX
 * @text Player X
 * @type number
 * @desc The player's x axis starting position
 * @default
 *
 * @param playerY
 * @text Player Y
 * @type number
 * @desc The player's y axis starting position
 * @default
 *
 * @param requiredVariables
 * @text Required Variables
 * @type struct<VariableChange>[]
 * @desc This will be a list of variables that you need to set up for the chapter to proceed correctly
 * @default
 *
 * @param requiredSwitches
 * @text Required Switches
 * @type struct<SwitchChange>[]
 * @desc This will be a list of switches that you need to set up for the chapter to proceed correctly
 * @default
 *
 */

/*~struct~VariableChange:
 * @param id
 * @text Variable ID
 * @type variable
 * @desc The variable you want to set/change value of
 * @default
 *
 * @param value
 * @text Value
 * @type string
 * @desc The value you want to change the variable to
 * @default
 *
 */

/*~struct~SwitchChange:
 * @param id
 * @text Switch ID
 * @type switch
 * @desc The switch you want to set/change value of
 * @default
 *
 * @param value
 * @text Value
 * @type boolean
 * @desc The value you want to change the switch to
 * @default
 *
 */

/*~struct~ItemWindow:
 * @param x
 * @text X Position
 * @type note
 * @desc The position of the window on the x axis (Eval allowed)
 * @default 0
 *
 * @param y
 * @text Y Position
 * @type note
 * @desc The position of the window on the y axis (Eval allowed)
 * @default 0
 *
 * @param width
 * @text Width
 * @type note
 * @desc The width of the window (Eval allowed)
 * @default 400
 *
 * @param height
 * @text Height
 * @type note
 * @desc The height of the window (Eval allowed)
 * @default 400
 *
 * @param itemHeight
 * @text Item Height
 * @type number
 * @desc The height of each chapter rectangle in the window
 * @default 145
 *
 * @param maxItems
 * @text Max Items
 * @type number
 * @desc The max amount of items to display in the window.
 * @default 4
 *
 * @param fontSize
 * @text Font Size
 * @type number
 * @desc The default font size for the content in the window
 * @default 18
 *
 */

/*~struct~BasicWindow:
 * @param x
 * @text X Position
 * @type note
 * @desc The position of the window on the x axis (Eval allowed)
 * @default 0
 *
 * @param y
 * @text Y Position
 * @type note
 * @desc The position of the window on the y axis (Eval allowed)
 * @default 0
 *
 * @param width
 * @text Width
 * @type note
 * @desc The width of the window (Eval allowed)
 * @default 400
 *
 * @param height
 * @text Height
 * @type note
 * @desc The height of the window (Eval allowed)
 * @default 400
 *
 */
