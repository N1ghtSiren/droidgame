menu_options = {}

function menu_options.create(groupID)
    local obj = object.create(groupID)
    
    function obj.ondraw()
        local height = love.graphics.getHeight()
        local width = love.graphics.getWidth()
        local printf = love.graphics.printf
        
        love.graphics.setColor(1,1,1,1)
        love.graphics.setFont(font_main)
        printf(getLocalizedString("Circle Max Size"), width/20, height*0.05, 999)
        --
        printf(getLocalizedString("Field Size: "), width/20, height*0.2, 999)
        --
        printf(getLocalizedString("Music Volume"), width/20, height*0.35, 999)
        --
        printf(getLocalizedString("Pop sound"), width/20, height*0.5, 999)
        --
        printf(getLocalizedString("Language"), width/20, height*0.65, 999)
        printf("<", width*0.7, height*0.65, 999)
        if(settings.language=="_en")then
            printf("English", width*0.75, height*0.65, 999)
        elseif(settings.language=="_jp")then
            printf("日本語", width*0.75, height*0.65, 999)
        end
        printf(">", width*0.9, height*0.65, 999)
        --
        printf(getLocalizedString("Back"), width/20, height*0.85, 999)
        --
        printf(getLocalizedString("Reset to Default"), width*0.6, height*0.85, 999)
        --
        printf("<", width*0.7, height*0.05, 999)
        printf(settings.cellsize, width*0.8, height*0.05, 999)
        printf(">", width*0.9, height*0.05, 999)
        --
        printf(settings.cellsX.."x"..settings.cellsY, width*0.75, height*0.2, 999)
        --
        printf("<", width*0.7, height*0.35, 999)
        printf((settings.musicvolume*100).."%", width*0.77, height*0.35, 999)
        printf(">", width*0.9, height*0.35, 999)
        --
        local str = ""
        if(settings.playpops==1)then
            str = getLocalizedString("yes")
        else
            str = getLocalizedString("no")
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
            settings.cellsize = mathfix(settings.cellsize - 5, 5, 70)
            settings.cellsX = mathfix(divisor(width,settings.cellsize),1,50)-1
            settings.cellsY = mathfix(divisor(height,settings.cellsize),1,30)

            touches.pause(0.5)
        end
        --
        textwidth = font_main:getWidth(">")*2
        minx = width*0.9
        if(touches.isInArea(minx-textwidth/2, height*0.05, minx+textwidth, height*0.05+textheight))then
            settings.cellsize = mathfix(settings.cellsize + 5, 5, 70)
            settings.cellsX = mathfix(divisor(width,settings.cellsize),1,50)-1
            settings.cellsY = mathfix(divisor(height,settings.cellsize),1,30)

            touches.pause(0.5)
        end
        --size
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
        --lang
        textwidth = font_main:getWidth(">")*2
        minx = width*0.7
        if(touches.isInArea(minx-textwidth/2, height*0.65, minx+textwidth, height*0.65+textheight))then
            if(settings.language=="_en")then
                settings.language = "_jp"
            elseif(settings.language=="_jp")then
                settings.language = "_en"
            end
            swapLanguage()
            touches.pause(0.5)
        end
        --
        textwidth = font_main:getWidth("<")*2
        minx = width*0.9
        if(touches.isInArea(minx-textwidth/2, height*0.65, minx+textwidth, height*0.65+textheight))then
            if(settings.language=="_en")then
                settings.language = "_jp"
            elseif(settings.language=="_jp")then
                settings.language = "_en"
            end
            swapLanguage()
            touches.pause(0.5)
        end
        --
        textwidth = font_main:getWidth(getLocalizedString("Back"))
        minx = width/20
        if(touches.isInArea(minx, height*0.85, minx+textwidth, height*0.85+textheight))then
            saveSettings()
            obj.perform(false)
            MainMenu.perform(true)
        end
        --
        textwidth = font_main:getWidth(getLocalizedString("Reset to Default"))
        minx = width*0.6
        if(touches.isInArea(minx, height*0.85, minx+textwidth, height*0.85+textheight))then
            defaultSettings()
            BGM:setVolume(settings.musicvolume)
        end

        touches.clear()

        if(love.keyboard.isScancodeDown("acback"))then
            saveSettings()
            obj.perform(false)
            MainMenu.perform(true)
        end
    end

    function obj.oncreate()
        
    end

    function obj.ondestroy()

    end
    
    return obj
end

function checkSettings()
    local h = love.graphics.getHeight()
    local w = love.graphics.getWidth()

    settings.cellsize = settings.cellsize or 70
    settings.musicvolume = settings.musicvolume or 0.5
    settings.playpops = settings.playpops or 1

    settings.cellsY = settings.cellsY or divisor(h,settings.cellsize)
    settings.cellsX = settings.cellsX or divisor(w,settings.cellsize)-1

    settings.firstLaunch = settings.firstLaunch or 1
    settings.language = settings.language or "_en"
end

function defaultSettings()
    settings = settings or {}
    settings.musicvolume = 0.5
    settings.playpops = 1
    --calculations
    local h = love.graphics.getHeight()
    local w = love.graphics.getWidth()
    settings.cellsize = 70
    --
    settings.cellsY = divisor(h,settings.cellsize)
    settings.cellsX = divisor(w,settings.cellsize)-1
    
end

function saveSettings()
    local data = ""
    data = "settings={}\n"
    data = data.."settings.playpops = "..(settings.playpops or 1).."\n"
    data = data.."settings.musicvolume = "..settings.musicvolume.."\n"
    data = data.."settings.cellsize = "..settings.cellsize.."\n"
    data = data.."settings.cellsX = "..settings.cellsX.."\n"
    data = data.."settings.cellsY = "..settings.cellsY.."\n"
    data = data.."settings.language = \""..settings.language.."\"".."\n"
    data = data.."settings.firstLaunch = "..settings.firstLaunch.."\n"

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