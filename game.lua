--setup
game = {}

function game.create()
    local obj = {}
    table.insert(game,obj)

    GameOver = false
    local stones = 0
    local score = 0
    local maxcombo = 0
    Grid = grid.create(love.graphics.getHeight()/10)
    local timerhandle = nil

    function obj.startReal()
        layer = 1

        addon.drawgroup.delete(layer)
        addon.updategroup.delete(layer)

        addon.drawgroup.create(layer)
        addon.updategroup.create(layer)

        
        Grid:setup(layer)
        Grid:fill()
        Grid:perform(true)

        UI = ui.create(love.graphics.getHeight()/10)
        UI.setup(layer)
        UI:perform(true)
        GameOver = false
        timerhandle = nil
    end

    function obj.start()
        if(timerhandle==nil)then
            timerhandle = Timer.after(2,obj.startReal)
        end
    end

    function obj.ondraw()
        if(GameOver==false)then return end
        local cellsize = (love.graphics.getHeight()/10)
        local center = cellsize/2
        local radius = cellsize*0.4
        --
        love.graphics.setColor(1, 1, 1, 0.82)
        love.graphics.circle("fill", 10*cellsize+center, center, radius)
        love.graphics.printf("x"..(stones[1]or 0), 10*cellsize+center*1.8, font_size/5, 999)
        --
        love.graphics.setColor(1, 0.28, 0.10, 0.7)
        love.graphics.circle("fill", 10*cellsize+center, 1*cellsize+center, radius)
        love.graphics.printf("x"..(stones[2]or 0), 10*cellsize+center*1.8, cellsize+font_size/5, 999)
        --
        love.graphics.setColor(0, 0.6, 0, 0.7)
        love.graphics.circle("fill", 10*cellsize+center, 2*cellsize+center, radius)
        love.graphics.printf("x"..(stones[3]or 0), 10*cellsize+center*1.8, 2*cellsize+font_size/5, 999)
        --
        love.graphics.setColor(0, 0.36, 90, 0.7)
        love.graphics.circle("fill", 10*cellsize+center, 3*cellsize+center, radius)
        love.graphics.printf("x"..(stones[4]or 0), 10*cellsize+center*1.8, 3*cellsize+font_size/5, 999)

        --Game over
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf("Game Over", cellsize, 0, 999)
        love.graphics.printf("Score: "..score, cellsize, cellsize, 999)
        love.graphics.printf("Max Combo: "..maxcombo, cellsize, cellsize*2, 999)
        love.graphics.printf("Click Here To Try Again", cellsize, cellsize*3, 999)
    end

    function obj.onupdate()
        if(GameOver==false)then return end
        --get what clicked on
        local points = touches.get()

        local tap_width = font_main:getWidth("Click Here To Try Again")
        local cellsize = (love.graphics.getHeight()/10)

        local minx,maxx,miny,maxy = cellsize, cellsize+tap_width, cellsize*3, cellsize*3+font_size

        for _, t in ipairs(points) do
            x, y = unpack(t)

            if(x<maxx and x>minx and y>miny and y<maxy)then
                Game.start()
            end

        end
        touches.clear()
    end

    function obj.over(Xmaxcombo,Xscore,stonesTable)
        stones = stonesTable
        score = Xscore
        maxcombo = Xmaxcombo

        GameOver = true
        Grid:perform(false)

        local t = Grid.cells
        for x = 0,14 do

            for y = 0,9 do
                t[x][y]:perform(false)
            end
        end
        UI:perform(false)
    end

    addon.update.add(obj.onupdate, groups)
    addon.draw.add(obj.ondraw, groups)

    return obj
end
