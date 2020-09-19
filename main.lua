require("libs/addon")
require("system")
require("examples/object")
font_size_big = math.floor((love.graphics.getHeight()/10)+1)
font_big = love.graphics.newFont("libs/umeboshi.ttf", font_size_big)

font_size_main = math.floor((love.graphics.getHeight()/15)+1)
font_main = love.graphics.newFont("libs/umeboshi.ttf", font_size_main)
love.graphics.setFont(font_main)
--
Timer = require("libs/hump")
--moonshine = require("libs/moonshine")
--
addon.drawgroup.create(1)
addon.updategroup.create(1)
--
addon.drawgroup.create(2)
addon.updategroup.create(2)
--
addon.drawgroup.create(3)
addon.updategroup.create(3)
--
addon.drawgroup.create(4)
addon.updategroup.create(4)
--
require("menu/bg")
require("menu/langmenu")
require("menu/menu")
require("menu/optionsmenu")
require("menu/startmenu")
require("menu/records")

require("game/grid")
require("game/stone")
require("game/algorithms")
require("game/bonus")
require("game/ui")

if(loadSettings()==false)then
    defaultSettings()
    settings.language = "_en"
    saveSettings()
end
checkSettings()

if(loadRecords()==false)then
    defaultRecords()
    saveRecords()
end
 
POP = love.audio.newSource("sounds/pop.flac","static")
POP:setLooping(false)
POP:setVolume(0.5)

BGM = love.audio.newSource("sounds/bgm.flac","stream")
BGM:play()
BGM:setLooping(true)
BGM:setVolume(settings.musicvolume)

MainMenu = menu_main.create(1)
OptionsMenu = menu_options.create(1)
StartMenu = menu_startgame.create(1)
Grid = grid.create(1)
Grid.perform(false)
UI = ui.create(4)
if(settings.firstLaunch==1)then
    LangMenu = menu_lang.create(1)
    LangMenu.perform(true)
else
    swapLanguage()
    MainMenu.perform(true)
end