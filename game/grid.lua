grid = {}

function grid.create(groupID)
    local obj = object.create(groupID)
    
    function obj.ondraw()

        local size = love.graphics.getHeight()/settings.cellsY

        local setColor = love.graphics.setColor
        local rectangle = love.graphics.rectangle

        --mask
        setColor(0,0,0,0.7)
        rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())

        setColor(0.35,0.35,0.35,1)
        for x = 0, #obj.cells do

		    for y = 0, #obj.cells[x] do
                rectangle("line", x*size, y*size, size, size)
            end

        end
    end

    function obj.onupdate(dt)
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
        obj.cells = {}
        for x = 0, settings.cellsX-1 do
            obj.cells[x] = {}
            for y = 0, settings.cellsX-1 do
                obj.cells[x][y] = stone.create(groupID,x,y)
                obj.cells[x][y].perform(true)
            end
        end
    end

    function obj.ondestroy()

    end
    
    return obj
end