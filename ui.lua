ui = {}

function ui.create(cellsize)
    obj = {}
    obj.tapsleft = 500

    table.insert(grid,obj)
    local count = {}

    local lasttype = 0
    local lastcount = 0
    local lastscore = 0

    local maxcombo = 0
    local combo = 0
    local score = 0

    local stones = {}

    function obj.perform(self,flag)
        obj.performdraw=flag
        obj.performupdate=flag
    end
    
    function obj.ondraw()
        if(not obj.performdraw)then return end
        local center = cellsize/2
        local radius = cellsize*0.4
        --
        love.graphics.setColor(1, 1, 1, 0.82)
        love.graphics.circle("fill", 15*cellsize+center, center, radius)
        love.graphics.printf("x"..count[1], 15*cellsize+center*1.8, font_size/5, 999)
        --
        love.graphics.setColor(1, 0.28, 0.10, 0.7)
        love.graphics.circle("fill", 15*cellsize+center, 1*cellsize+center, radius)
        love.graphics.printf("x"..count[2], 15*cellsize+center*1.8, cellsize+font_size/5, 999)
        --
        love.graphics.setColor(0, 0.6, 0, 0.7)
        love.graphics.circle("fill", 15*cellsize+center, 2*cellsize+center, radius)
        love.graphics.printf("x"..count[3], 15*cellsize+center*1.8, 2*cellsize+font_size/5, 999)
        --
        love.graphics.setColor(0, 0.36, 90, 0.7)
        love.graphics.circle("fill", 15*cellsize+center, 3*cellsize+center, radius)
        love.graphics.printf("x"..count[4], 15*cellsize+center*1.8, 3*cellsize+font_size/5, 999)

        --screen info
        if(lasttype~=0)then
            love.graphics.setColor(0.5,0.5,0.5)
            love.graphics.printf("COMBO", 15*cellsize, 4*cellsize+font_size/5, 999)
            --combo
            love.graphics.setColor(unpack(rgba[lasttype]))
            love.graphics.circle("fill", 15*cellsize+center, 5*cellsize+center, radius)
            love.graphics.printf("x"..combo, 15*cellsize+center*1.8, 5*cellsize+font_size/5, 999)
            --score
            love.graphics.setColor(0.5,0.5,0.5)
            love.graphics.printf("SCORE", 15*cellsize, 6*cellsize+font_size/5, 999)
            love.graphics.printf(score, 15*cellsize, 7*cellsize+font_size/5, 999)
            love.graphics.setColor(unpack(rgba[lasttype]))
            love.graphics.printf("+"..lastscore.." ; "..lastcount, 15*cellsize, 8*cellsize+font_size/5, 999)
            --taps left
            love.graphics.setColor(0.5,0.5,0.5)
            love.graphics.printf("taps: "..obj.tapsleft, 15*cellsize, 9*cellsize+font_size/5, 999)
        end

    end

    function obj.onupdate()
        if(not obj.performupdate)then return end

        if(not GameOver)then
            local t = Grid.cells
            local n = 0

            count[1],count[2],count[3],count[4] = 0,0,0,0

            for x = 0,14 do

                for y = 0,9 do
                    n = t[x][y].type
                    count[n] = count[n] + 1
                end
            end
        end
    end

    function obj.calc(type,amount,cellx,celly)
        if(amount==0)then return end

        if(obj.tapsleft>0)then
            obj.tapsleft = obj.tapsleft - 1
        else
            GameOver = true
            Game.over(maxcombo,score,stones)
            return
        end

        if(lasttype==type)then
            combo = combo + 1
        else
            lasttype=type
            combo = 1
        end

        if(maxcombo<combo)then
            maxcombo = combo
        end

        stones[type]=(stones[type]or 0)+amount

        lastcount = amount
        lastscore = amount*(combo*0.2)*10
        score = score + lastscore
    end

    function obj.setup(groups)
        addon.update.add(obj.onupdate,groups)
        addon.draw.add(obj.ondraw,groups)
    end

    --do not update and draw until turned on
    obj.performdraw = false
    obj.performupdate = false

    return obj
end

--rgba[1] = {1, 1, 1, 0.82} 
--rgba[2] = {1, 0.28, 0.10, 0.7}
--rgba[3] = {0, 0.6, 0, 0.7}
--rgba[4] = {0, 0.36, 90, 0.7}