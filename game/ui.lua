ui = {}

function ui.create(groupID)
    local obj = object.create(groupID)

    function obj.ongameover()
        if(obj.GAMEOVER==false)then return end

        local printf = love.graphics.printf
        --
        local h = love.graphics.getHeight()
        local w = love.graphics.getWidth()

        local setColor = love.graphics.setColor
        local rectangle = love.graphics.rectangle

        --mask
        setColor(0,0,0,0.7)
        rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())
        --text
        setColor(1,1,1,1)
        printf("GAME OVER", w*0.1, h*0.05, 999)
        printf("Score: "..obj.score, w*0.1, h*0.15, 999)
        printf("Best : "..recordsGet(settings.cellsX,settings.cellsY,obj.taps), w*0.6, h*0.15, 999)
        printf("Max Combo: "..obj.maxcombo, w*0.1, h*0.25, 999)
        printf("Field Size: "..settings.cellsX.."x"..settings.cellsY, w*0.1, h*0.35, 999)
        printf("Tap Limit: "..obj.taps, w*0.1, h*0.45, 999)
        --stones
        setColor(rgba[1])
        printf("x"..obj.stones[1], w*0.1, h*0.55, 999)
        setColor(rgba[2])
        printf("x"..obj.stones[2], w*0.25, h*0.55, 999)
        setColor(rgba[3])
        printf("x"..obj.stones[3], w*0.40, h*0.55, 999)
        setColor(rgba[4])
        printf("x"..obj.stones[4], w*0.55, h*0.55, 999)
        --buttons
        setColor(1,1,1,1)
        printf("To Main Menu",w*0.1,h*0.75,999)
        printf("Play Again",w*0.6,h*0.75,999)
    end
    
    function obj.ondraw()
        local printf = love.graphics.printf

        for _,t in ipairs(obj.texts)do
            love.graphics.setColor(t.color)
            printf(t.text, t.x, t.y, 999)
        end
    end

    function obj.onupdate(dt)
        for k,t in ipairs(obj.texts)do
            t.color[4] = t.color[4] - dt*16
            if(t.color[4]<=0)then
                table.remove(obj.texts,k)
            end
        end

        --taps to main menu/tryagain
        if(obj.GAMEOVER==true)then
            local h = love.graphics.getHeight()
            local w = love.graphics.getWidth()

            local textheight = font_main:getHeight()
            local textwidth = font_main:getWidth("To Main Menu")
            local minx = w*0.1
            local miny = h*0.75

            if(touches.isInArea(minx, miny, minx+textwidth, miny+textheight))then
                recordsUpdate(settings.cellsX,settings.cellsY,obj.taps,obj.score)
                saveRecords()
                touches.pause(0.5)
                obj.onend()
            end

            textwidth = font_main:getWidth("Play Again")
            minx = w*0.6
            miny = h*0.75

            if(touches.isInArea(minx, miny, minx+textwidth, miny+textheight))then
                print("play again")
                touches.pause(1)
                recordsUpdate(settings.cellsX,settings.cellsY,obj.taps,obj.score)
                saveRecords()
                Grid.hide()
                obj.restart(obj.taps)
            end

            touches.clear()
        end
    end

    function obj.calc(result,lastcolor,matchcount,basex,basey)
        local cellsize = love.graphics.getHeight()/settings.cellsY

        if(matchcount==0)then return end

        --gameover
        if(obj.tapsleft<=0)then
            if(obj.GAMEOVER==false)then
                Grid.perform(false)
                obj.GAMEOVER=true
                addon.draw.add(obj.ongameover,4)
                touches.pause(2)
            end
            return
        end

        if(obj.lastcolor==lastcolor)then
            obj.combo = obj.combo + 1
        else
            obj.lastcolor=lastcolor
            obj.combo = 1
        end

        if(obj.maxcombo<obj.combo)then
            obj.maxcombo = obj.combo
        end

        obj.stones[lastcolor]=(obj.stones[lastcolor]or 0)+matchcount

        obj.lastscore = matchcount*20*(obj.combo*0.05)
        obj.score = obj.score + obj.lastscore

        --remove things
        for _,cell in pairs(result)do
            cell.ontap()
        end

        --create text
        local r,g,b,a = unpack(rgba[Grid.cells[basex][basey].color])
        a = 1.6
        obj.textadd("+"..obj.lastscore,{r,g,b,a},cellsize*basex,cellsize*(basey-0.5))

        --create bonus from # at once
        local bonustoadd = {}
        local count = 0

        --per 5
        count = divisor(matchcount,5)
        for i = count, 1, -1 do
            bonustoadd[#bonustoadd+1] = 1
        end
        --per 10
        count = divisor(matchcount,10)
        for i = count, 1, -1 do
            bonustoadd[#bonustoadd+1] = 2
        end
        --per 15
        count = divisor(matchcount,15)
        for i = count, 1, -1 do
            bonustoadd[#bonustoadd+1] = 3
        end
        
        --create bonus from combos
        if(obj.combo%5==0)then
            --per 5
            count = divisor(obj.combo,5)
            for i = count, 1, -1 do
                bonustoadd[#bonustoadd+1] = 1
            end
            --per 10
            count = divisor(obj.combo,10)
            for i = count, 1, -1 do
                bonustoadd[#bonustoadd+1] = 2
            end
            --per 15
            count = divisor(obj.combo,15)
            for i = count, 1, -1 do
                bonustoadd[#bonustoadd+1] = 3
            end
        end

        --give bonuses to cells
        for i = #bonustoadd, 1, -1 do
            if(Grid.cells[basex][basey].nextbonus==0)then
                Grid.cells[basex][basey].addbonus(bonustoadd[i])
            else
                for k,t in ipairs(result) do
                    k = love.math.random(1,#result)
                    if(result[k].nextbonus==0)then
                        result[k].addbonus(bonustoadd[i])
                        goto next1
                    end
                end
                ::next1::
            end
        end

        --create combo text every 5
        if(obj.combo%5==0)then
            local r,g,b,a = unpack(rgba[Grid.cells[basex][basey].color])
            a = 1.6
            obj.textadd("combo: "..obj.combo,{r,g,b,a},cellsize*basex,cellsize*(basey+0.5))
        end

        --handle taps
        obj.tapsleft = obj.tapsleft - 1

        --create tap text every 50
        if(obj.tapsleft%50==0 and obj.tapsleft~=0 or obj.tapsleft==10)then
            local r,g,b,a = 0.9,0.9,0.9,4
            obj.textadd("Taps Left: "..obj.tapsleft.."; Score: "..obj.score,{r,g,b,a},cellsize*1,cellsize*0)
        end
    end

    function obj.bonuscalc(result,x,y)
        for k,v in pairs(result) do
            obj.stones[v.color]=(obj.stones[v.color]or 0)+1
            v.ontap()
        end

        obj.lastscore = #result*5
        obj.score = obj.score + obj.lastscore

        --text
        local cellsize = love.graphics.getHeight()/settings.cellsY
        local r,g,b,a = 1,1,1,1
        a = 1.6
        obj.textadd("+"..obj.lastscore,{r,g,b,a},cellsize*x,cellsize*(y-0.5))
    end

    function obj.textadd(text,color,posx,posy)
        table.insert(obj.texts,{text = text, color = color, x = posx, y = posy})
    end

    function obj.restart(tapsleft)
        obj.GAMEOVER=false
        obj.taps = tapsleft
        obj.tapsleft = tapsleft
        obj.combo = 0
        obj.maxcombo = 0
        obj.lastcolor = 0
        obj.lastscore = 0
        obj.score = 0
        addon.draw.remove(obj.ongameover,4)

        Grid.perform(true)
        Grid.show()
    end

    function obj.onend()
        addon.draw.remove(obj.ongameover,4)

        Grid.hide()
        Grid.perform(false)
        MainMenu.perform(true)
    end

    function obj.oncreate()
        obj.GAMEOVER=false
        --
        obj.texts = {}
        obj.combo = 0
        obj.maxcombo = 0
        obj.lastcolor = 0
        obj.lastscore = 0
        obj.score = 0
        obj.stones = {}
        --
        obj.texts = {}
    end

    function obj.ondestroy()
        
    end

    obj.perform(true)
    return obj
end