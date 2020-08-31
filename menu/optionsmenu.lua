menu_options = {}

function menu_options.create(groupID)
    local obj = object.create(groupID)
    
    function obj.ondraw()
        local height = love.graphics.getHeight()
        local width = love.graphics.getWidth()
        local printf = love.graphics.printf
        
        love.graphics.setColor(1,1,1,1)
        love.graphics.setFont(font_main)
        printf("Vertical Cells", width/20, height*0.05, 999)
        --
        printf("Horisontal Cells", width/20, height*0.2, 999)
        --
        printf("Music Volume", width/20, height*0.35, 999)
        --
        printf("Pop sound", width/20, height*0.5, 999)
        --
        printf("Back", width/20, height*0.8, 999)

        --
        printf("<", width*0.7, height*0.05, 999)
        printf(settings.cellsY, width*0.8, height*0.05, 999)
        printf(">", width*0.9, height*0.05, 999)
        --
        printf("<", width*0.7, height*0.2, 999)
        printf(settings.cellsX, width*0.8, height*0.2, 999)
        printf(">", width*0.9, height*0.2, 999)
        --
        printf("<", width*0.7, height*0.35, 999)
        printf((settings.musicvolume*100).."%", width*0.77, height*0.35, 999)
        printf(">", width*0.9, height*0.35, 999)
        --
        local str = ""
        if(settings.playpops==1)then
            str = "yes"
        else
            str = "no"
        end
        printf("<", width*0.7, height*0.5, 999)
        printf(str, width*0.77, height*0.5, 999)
        printf(">", width*0.9, height*0.5, 999)
    end

    function obj.onupdate(dt)

        local textheight = font_main:getHeight()

        local width = love.graphics.getWidth()
        local height = love.graphics.getHeight()
        --vcells
        local textwidth = font_main:getWidth("<")*2
        local minx = width*0.7
        if(touches.isInArea(minx-textwidth/2, height*0.05, minx+textwidth, height*0.05+textheight))then
            settings.cellsY = mathfix(settings.cellsY - 1, 1, 100)
            touches.pause(0.5)
        end
        --
        textwidth = font_main:getWidth(">")*2
        minx = width*0.9
        if(touches.isInArea(minx-textwidth/2, height*0.05, minx+textwidth, height*0.05+textheight))then
            settings.cellsY = mathfix(settings.cellsY + 1, 1, 100)
            touches.pause(0.5)
        end
        --hcells
        textwidth = font_main:getWidth("<")*2
        minx = width*0.7
        if(touches.isInArea(minx-textwidth/2, height*0.2, minx+textwidth, height*0.2+textheight))then
            settings.cellsX = mathfix(settings.cellsX - 1, 1, 100)
            touches.pause(0.5)
            
        end
        --
        textwidth = font_main:getWidth(">")*2
        minx = width*0.9
        if(touches.isInArea(minx-textwidth/2, height*0.2, minx+textwidth, height*0.2+textheight))then
            settings.cellsX = mathfix(settings.cellsX + 1, 1, 100)
            touches.pause(0.5)
        end
        --music volume
        textwidth = font_main:getWidth(">")*2
        minx = width*0.7
        if(touches.isInArea(minx-textwidth/2, height*0.35, minx+textwidth, height*0.35+textheight))then
            settings.musicvolume = mathfix(settings.musicvolume-0.05, 0, 1) 
            BGM:setVolume(settings.musicvolume)
            touches.pause(0.5)
        end
        --
        textwidth = font_main:getWidth("<")*2
        minx = width*0.9
        if(touches.isInArea(minx-textwidth/2, height*0.35, minx+textwidth, height*0.35+textheight))then
            settings.musicvolume = mathfix(settings.musicvolume+0.05, 0, 1) 
            BGM:setVolume(settings.musicvolume)
            touches.pause(0.5)
        end
        --pop sounds
        textwidth = font_main:getWidth(">")*2
        minx = width*0.7
        if(touches.isInArea(minx-textwidth/2, height*0.5, minx+textwidth, height*0.5+textheight))then
            if(settings.playpops==1)then
                settings.playpops = 0
            else
                settings.playpops = 1
            end
            touches.pause(0.5)
        end
        --
        textwidth = font_main:getWidth("<")*2
        minx = width*0.9
        if(touches.isInArea(minx-textwidth/2, height*0.5, minx+textwidth, height*0.5+textheight))then
            if(settings.playpops==0)then
                settings.playpops = 1
            else
                settings.playpops = 0
            end
            touches.pause(0.5)
        end
        --
        textwidth = font_main:getWidth("Back")
        minx = width/20
        if(touches.isInArea(minx, height*0.8, minx+textwidth, height*0.8+textheight))then
            saveSettings()
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

function defaultSettings()
    settings = {}
    settings.musicvolume = 0.5
    settings.playpops = 1
    --calculations
    local h = love.graphics.getHeight()
    local w = love.graphics.getWidth()
    local minsize = 70
    --
    settings.cellsY = divisor(h,minsize)
    settings.cellsX = divisor(w,minsize)-1
end

function saveSettings()
    local data = ""
    data = "settings={}\n"
    data = data.."settings.playpops = "..(settings.playpops or 1).."\n"
    data = data.."settings.musicvolume = "..settings.musicvolume.."\n"
    data = data.."settings.cellsY = "..settings.cellsY.."\n"
    data = data.."settings.cellsX = "..settings.cellsX.."\n"

    love.filesystem.write(settingsfilename, data)
end

function loadSettings()
    local file = love.filesystem.load(settingsfilename)

    if(file==nil)then
        return false
    end
    
    return xpcall(file,debug.traceback)
end

settingsfilename = "settings.lua"