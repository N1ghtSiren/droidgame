grid = {}

function grid.create(cellsize)
    local obj = {}
    table.insert(grid,obj)

    obj.cellsize = cellsize

    --do not update and draw until turned on
    obj.performdraw = false
    obj.performupdate = false
    
    --add cells
    obj.cells = {}
    for w = 0,14 do
        obj.cells[w] = {}

        for h = 0,9 do
            obj.cells[w][h] = {}
        end

    end

    --set borders
    obj.minx = 0
    obj.miny = 0
    obj.maxx = cellsize*15
    obj.maxy = cellsize*10
    
    --called on draw
    function obj.ondraw()
        if(not obj.performdraw)then return end

        local size = obj.cellsize
        local setColor = love.graphics.setColor
        local rectangle = love.graphics.rectangle

        for w = 0, 14 do

		    for h = 0, 9 do
                setColor(0.35,0.35,0.35,1)
                rectangle("line", w*size, h*size, size, size)
            end

        end
    end


    --called on update
    function obj.onupdate(dt)
        if(not obj.performupdate)then return end

        --get what clicked on
        local points = touches.get()
        local minx,maxx,miny,maxy = obj.minx, obj.maxx, obj.miny, obj.maxy
        
        local cellsize,floor = cellsize,math.floor

        for _, t in ipairs(points) do
            x, y = unpack(t)

            if(x<maxx and x>minx and y>miny and y<maxy)then
                cx, cy = floor(x/cellsize),floor(y/cellsize)
                
                --do smth with this cell
                obj.cells[cx][cy]:onclick()
            end

        end
        touches.clear()
    end


    --turn on or off draw and update
    function obj.perform(self,flag)
        obj.performdraw=flag
        obj.performupdate=flag
    end


    --setup after creating
    function obj.setup(self,groups)
        obj.group = groups

        addon.update.add(obj.onupdate,groups)
        addon.draw.add(obj.ondraw,groups)
    end


    --fill with stones
    function obj.fill(self)

        for w = 0,14 do
        obj.cells[w] = {}

            for h = 0,9 do
                obj.cells[w][h] = stone.create(w,h,cellsize)
                obj.cells[w][h]:setup(obj.group)
                obj.cells[w][h]:perform(true)
            end

        end
    end

    return obj
end