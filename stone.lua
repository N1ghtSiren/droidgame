--[[types:
nil - empty
1 - white
2 - red
3 - green
4 - blue
]]--

rgba = {}
rgba[1] = {1, 1, 1, 0.82} 
rgba[2] = {1, 0.28, 0.10, 0.7}
rgba[3] = {0, 0.6, 0, 0.7}
rgba[4] = {0, 0.36, 90, 0.7}

--[[state
"alive"
"fading"
"removed"
]]

stone = {}

function stone.create(posx, posy, cellsize)
    local obj = {}

    table.insert(stone,obj)
    
    obj.respawn = true
    obj.posx = posx
    obj.posy = posy
    obj.cellsize = cellsize
    obj.size = cellsize*0.4
    obj.state = "alive"

    local fade = {}
    
    --called on draw
    function obj.ondraw()
        if(obj==nil or not obj.performdraw)then return end

        local center = cellsize/2

        love.graphics.setColor(unpack(rgba[obj.type]))
        love.graphics.circle("fill", obj.posx*obj.cellsize+center, obj.posy*obj.cellsize+center, obj.size)

        if(obj.state=="fading")then
            love.graphics.setColor(0,0,0)
            love.graphics.circle("fill", obj.posx*obj.cellsize+center, obj.posy*obj.cellsize+center, fade.size)
        end

    end

    function obj.onFade()
        obj.state = "fading"
        fade.size = 0
    end

    --called on update
    function obj.onupdate(dt)
        if(obj==nil or not obj.performupdate)then return end

        local delta = obj.size

        if(obj.state=="fading")then
            fade.size = fade.size+obj.size*dt*56

            if(fade.size>=obj.size*1.2)then
                obj.onDeath()
            end

        end
    end

    function obj.onclick(self)
        if(obj.state=="fading")then return end
        --get all nearby cells with same color, within 1 cell up/down/left/rigt
        local unpack = unpack
        local insert = table.insert
        local remove = table.remove
        local grid = Grid

        local sx,sy = obj.posx, obj.posy

        local basetype = obj.type
        local count = 0
        local match = {}

        local stack = {}
        insert(stack,{sx,sy})

        local blacklist = {}
        local x,y = nil

        while(#stack>0)do
            x,y = unpack(stack[1])
            remove(stack,1)

            if(x>14 or x<0 or y>9 or y<0)then
                insert(blacklist,{x,y})
                goto next2
            end

            for _,t in pairs(blacklist)do
                if(x==t[1] and y==t[2])then
                    goto next2
                end
            end

            if(grid.cells[x][y].type==basetype)then
                count = count + 1
                insert(match,{x,y})
                insert(blacklist,{x,y})
            end
            
            if(grid.cells[x][y].type==basetype)then
                insert(stack,{x+1,y})
                insert(stack,{x-1,y})
                insert(stack,{x,y+1})
                insert(stack,{x,y-1})
            end

            ::next2::
        end

        local x,y = nil
        for i = #match, 1, -1 do
            x,y = match[i][1],match[i][2]
            if(grid.cells[x][y].state~="alive")then
                table.remove(match,k)
            end
        end

        for k,pos in pairs(match)do
            x,y = pos[1],pos[2]
            grid.cells[x][y].onFade()
        end

        UI.calc(basetype,#match,match[1][1],match[1][2])
    end

    --turn on or off draw and update
    function obj.perform(self, flag)

        obj.performdraw=flag
        obj.performupdate=flag
    end

    --setup after creating
    function obj.setup(self,groups)
        obj.group = groups
        addon.update.add(obj.onupdate, groups)
        addon.draw.add(obj.ondraw, groups)

        obj.type = love.math.random(1, 4)
    end

    --on death
    function obj.onDeath()
        obj:perform(false)
        fade=nil
        local g = obj.group
        addon.update.remove(obj.onupdate, g)
        addon.draw.remove(obj.ondraw, g)
        
        if(obj.respawn)then
            Grid.cells[posx][posy] = stone.create(posx,posy,cellsize)
            Grid.cells[posx][posy]:setup(g)
            Grid.cells[posx][posy]:perform(true)
        end
    end

    --do not update and draw until turned on
    obj.performdraw = false
    obj.performupdate = false
    
    return obj
end