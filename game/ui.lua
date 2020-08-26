ui = {}

function ui.create(groupID)
    local obj = object.create(groupID)
    
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
    end

    function obj.calc(result,lastcolor,matchcount,basex,basey)
        local cellsize = love.graphics.getHeight()/settings.cellsY

        if(matchcount==0)then return end

        --gameover
        if(obj.tapsleft<=0)then return end

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

        obj.lastscore = matchcount*(obj.combo*0.3)*10
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
            local r,g,b,a = 1,1,0,4
            obj.textadd("Taps Left: "..obj.tapsleft,{r,g,b,a},cellsize*1,cellsize*0)
        end
    end

    function obj.bonuscalc(result,x,y)
        for k,v in pairs(result) do
            obj.stones[v.color]=(obj.stones[v.color]or 0)+1
            v.ontap()
        end

        obj.lastscore = #result*(obj.combo*0.3)*10
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
        obj.taps = tapsleft
        obj.tapsleft = tapsleft
        obj.combo = 0
        obj.maxcombo = 0
        obj.lastcolor = 0
        obj.lastscore = 0
        obj.score = 0
    end

    function obj.oncreate()
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