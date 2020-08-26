menu_main = {}

function menu_main.create(groupID)
    local obj = object.create(groupID)
    
    function obj.ondraw()
        local height = love.graphics.getHeight()
        local width = love.graphics.getWidth()
        local printf = love.graphics.printf
        
        --title
        love.graphics.setColor(1,1,1,1)
        love.graphics.setFont(font_big)
        local textwidth = font_main:getWidth("The Game")
        printf("The Game", width/2-textwidth/1.4, height*0.05, 999)

        --
        love.graphics.setFont(font_main)
        textwidth = font_main:getWidth("Start Game")
        printf("Start Game", width/2-textwidth/2, height*0.3, 999)

        --
        textwidth = font_main:getWidth("Options")
        printf("Options", width/2-textwidth/2, height*0.5, 999)

        --
        textwidth = font_main:getWidth("Exit")
        printf("Exit", width/2-textwidth/2, height*0.7, 999)
    end

    function obj.onupdate(dt)
        local textheight = font_main:getHeight()

        local width = love.graphics.getWidth()
        local height = love.graphics.getHeight()
        
        local textwidth = font_main:getWidth("Start Game")
        local minx = width/2-textwidth/2
        --
        if(touches.isInArea(minx, height*0.3, minx+textwidth, height*0.3+textheight))then
            StartMenu.perform(true)
            obj.perform(false)

            touches.pause(1)
        end

        textwidth = font_main:getWidth("Options")
        minx = width/2-textwidth/2
        
        if(touches.isInArea(minx, height*0.5, minx+textwidth, height*0.5+textheight))then
            OptionsMenu.perform(true)
            obj.perform(false)

            touches.pause(0.5)
        end

        textwidth = font_main:getWidth("Exit")
        minx = width/2-textwidth/2
        
        if(touches.isInArea(minx, height*0.7, minx+textwidth, height*0.7+textheight))then
            love.event.quit()
        end

        touches.clear()
    end

    function obj.oncreate()
        BG = bg.create(groupID-1)
        BG.perform(true)
    end

    function obj.ondestroy()
        
    end
    
    return obj
end