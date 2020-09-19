grid = {}

function grid.create(groupID)
    local obj = object.create(groupID)
    
    function obj.ondraw()

        local size = love.graphics.getHeight()/settings.cellsY

        local setColor = love.graphics.setColor
        local rectangle = love.graphics.rectangle

        --mask
        setColor(0,0,0,0.6)
        rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())

    end

    function obj.onupdate(dt)

        if(UI.PAUSE==true)then return end
        local points = touches.get()
        
        local cellsize = love.graphics.getHeight()/settings.cellsY

        local x, y
        local cx, cy
        local a,b,c,d,e = nil

        for _, t in ipairs(points) do
            x, y = unpack(t)
            cx, cy = math.floor(x/cellsize),math.floor(y/cellsize)
            if(cx<settings.cellsX and cy<settings.cellsY)then

                a,b,c,d,e = getSameColorNearby(obj.cells[cx][cy])

            end
            if(a)then
                UI.calc(a,b,c,d,e)
                break
            end
        end

        touches.clear()
    end

    function obj.oncreate()
        
    end

    function obj.show()
        for x = 0, settings.cellsX-1 do
            for y = 0, settings.cellsY-1 do
                Grid.cells[x][y].show()
            end
        end
    end

    function obj.hide()
        for x = 0, settings.cellsX-1 do
            for y = 0, settings.cellsY-1 do
                Grid.cells[x][y].hide()
            end
        end
    end

    function obj.ondestroy()

    end
    
    obj.cells = {}
    for x = 0, 50 do
        obj.cells[x] = {}
        for y = 0, 30  do
            obj.cells[x][y] = stone.create(groupID+1,x,y)
            obj.cells[x][y].hide()
        end
        
    end

    return obj
end