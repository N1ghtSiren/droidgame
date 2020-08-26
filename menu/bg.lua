bg = {}

function bg.create(groupID)
    local obj = object.create(groupID)
    
    function obj.ondraw()
        local circle = love.graphics.circle
        local setColor = love.graphics.setColor
        local star = nil

        for i = 1, #obj.background do
            star = obj.background[i]
            setColor(star.color)
            
            circle("fill",star.posx, star.posy, star.size)
        end
        
    end

    function obj.onupdate(dt)
        local star = nil

        for i = 1,  #obj.background do
            star = obj.background[i]

            if(star.sizeflag)then
                star.size = star.size-star.sizedelta
            else
                star.size = star.size+star.sizedelta
            end

            if(star.size<star.sizemin)then
                star.sizeflag = false
            elseif(star.size>star.sizemax)then
                star.sizeflag = true
            end
        end
    end

    function obj.oncreate()
        local random = love.math.random

        local height = love.graphics.getHeight()
        local width = love.graphics.getWidth()

        obj.background = {}

        local t = nil
        for i = 1, 50 do
            obj.background[i] = {}
            t = obj.background[i]
            t.size = random(2,30)
            t.sizeflag = true
            t.sizemin = random(2,10)
            t.sizemax = random(20,40)
            t.sizedelta = random(1,7)/16
            t.posx = random(width)
            t.posy = random(height)
            t.color = {random(1,255)/255,random(1,255)/255,random(1,255)/255,0.82}
        end
    end
    
    return obj
end