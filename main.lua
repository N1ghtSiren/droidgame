require("addon")
require("system")

font_size = math.floor((love.graphics.getHeight()/15)+1)
font_main = love.graphics.newFont("comicsans.ttf", font_size)
love.graphics.setFont(font_main)

Timer = require("hump")
require("grid")
require("stone")
require("ui")

require("game")

Game = game.create()

Game.start()