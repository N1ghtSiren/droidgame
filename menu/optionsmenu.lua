menu_options = {}

function menu_options.create(groupID)
    local obj = object.create(groupID)
    
    function obj.ondraw()
        local height = love.graphics.getHeight()
        local width = love.graphics.getWidth()
        local printf = love.graphics.printf
        
        love.graphics.setColor(1,1,1,1)
        love.graphics.setFont(font_main)
        printf("Vertical Cells", width/20, height*0.1, 999)
        --
        printf("Horisontal Cells", width/20, height*0.3, 999)
        --
        printf("Improved Graphics", width/20, height*0.5, 999)
        --
        printf("Back", width/20, height*0.8, 999)

        --
        printf("<", width*0.7, height*0.1, 999)
        printf(settings.cellsY, width*0.8, height*0.1, 999)
        printf(">", width*0.9, height*0.1, 999)
        --
        printf("<", width*0.7, height*0.3, 999)
        printf(settings.cellsX, width*0.8, height*0.3, 999)
        printf(">", width*0.9, height*0.3, 999)
        --
        printf("<", width*0.7, height*0.5, 999)
        printf(tostring(settings.postprocessing), width*0.76, height*0.5, 999)
        printf(">", width*0.9, height*0.5, 999)
    end

    function obj.onupdate(dt)

        local textheight = font_main:getHeight()

        local width = love.graphics.getWidth()
        local height = love.graphics.getHeight()
        --vcells
        local textwidth = font_main:getWidth("<")*2
        local minx = width*0.7
        if(touches.isInArea(minx-textwidth/2, height*0.1, minx+textwidth, height*0.1+textheight))then
            settings.cellsY = settings.cellsY - 1
            touches.pause(0.5)
        end
        --
        textwidth = font_main:getWidth(">")*2
        minx = width*0.9
        if(touches.isInArea(minx-textwidth/2, height*0.1, minx+textwidth, height*0.1+textheight))then
            settings.cellsY = settings.cellsY + 1
            touches.pause(0.5)
        end
        --hcells
        textwidth = font_main:getWidth("<")*2
        minx = width*0.7
        if(touches.isInArea(minx-textwidth/2, height*0.3, minx+textwidth, height*0.3+textheight))then
            touches.pause(0.5)
            settings.cellsX = settings.cellsX - 1
        end
        --
        textwidth = font_main:getWidth(">")*2
        minx = width*0.9
        if(touches.isInArea(minx-textwidth/2, height*0.3, minx+textwidth, height*0.3+textheight))then
            settings.cellsX = settings.cellsX + 1
            touches.pause(0.5)
        end
        --graphics
        textwidth = font_main:getWidth(">")*2
        minx = width*0.7
        if(touches.isInArea(minx-textwidth/2, height*0.5, minx+textwidth, height*0.5+textheight))then
            settings.postprocessing = not settings.postprocessing
            touches.pause(0.5)
        end
        --
        textwidth = font_main:getWidth("<")*2
        minx = width*0.9
        if(touches.isInArea(minx-textwidth/2, height*0.5, minx+textwidth, height*0.5+textheight))then
            settings.postprocessing = not settings.postprocessing
            touches.pause(0.5)
        end
        --
        textwidth = font_main:getWidth("Back")
        minx = width/20
        if(touches.isInArea(minx, height*0.8, minx+textwidth, height*0.8+textheight))then
            obj.perform(false)
            MainMenu.perform(true)
        end

        touches.clear()
    end

    function obj.oncreate()
        
    end

    function obj.ondestroy()

    end
    
    return obj
end