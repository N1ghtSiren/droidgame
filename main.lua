require("libs/addon")
require("system")
require("examples/object")

font_size_big = math.floor((love.graphics.getHeight()/10)+1)
font_big = love.graphics.newFont("libs/comicsans.ttf", font_size_big)

font_size_main = math.floor((love.graphics.getHeight()/15)+1)
font_main = love.graphics.newFont("libs/comicsans.ttf", font_size_main)
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
require("menu/menu")
require("menu/optionsmenu")
require("menu/startmenu")

require("game/grid")
require("game/stone")
require("game/algorithms")
require("game/bonus")
require("game/ui")

MainMenu = menu_main.create(1)
OptionsMenu = menu_options.create(1)
StartMenu = menu_startgame.create(1)
Grid = grid.create(1)
UI = ui.create(4)

MainMenu.perform(true)