menu_startgame = {}

function menu_startgame.create(groupID)
    local obj = object.create(groupID)
    
    function obj.ondraw()
        local height = love.graphics.getHeight()
        local width = love.graphics.getWidth()
        local printf = love.graphics.printf
        
        love.graphics.setColor(1,1,1,1)
        love.graphics.setFont(font_main)
        printf("Short game - 200 taps", width/20, height*0.1, 999)
        --
        printf("Medium game - 500 taps", width/20, height*0.3, 999)
        --
        printf("Long game - 1000 taps", width/20, height*0.5, 999)
        --
        printf("Back", width/20, height*0.8, 999)
        --
    end

    function obj.onupdate(dt)
        local textheight = font_main:getHeight()

        local width = love.graphics.getWidth()
        local height = love.graphics.getHeight()
        --
        local textwidth = font_main:getWidth("Short game - 200 taps")
        local minx = width/20
        if(touches.isInArea(minx, height*0.1, minx+textwidth, height*0.1+textheight))then
            UI.restart(200)
            Grid.perform(true)
            obj.perform(false)
            touches.pause(0.5)
        end

        --
        textwidth = font_main:getWidth("Medium game - 500 taps")
        minx = width/20
        if(touches.isInArea(minx, height*0.3, minx+textwidth, height*0.3+textheight))then
            UI.restart(500)
            Grid.perform(true)
            obj.perform(false)
            touches.pause(0.5)
        end

        --
        textwidth = font_main:getWidth("Long game - 1000 taps")
        minx = width/20
        if(touches.isInArea(minx, height*0.5, minx+textwidth, height*0.5+textheight))then
            UI.restart(1000)
            Grid.perform(true)
            obj.perform(false)
            touches.pause(0.5)
        end
        
        --
        textwidth = font_main:getWidth("Back")
        minx = width/20
        if(touches.isInArea(minx, height*0.5, minx+textwidth, height*0.8+textheight))then
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