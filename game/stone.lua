stone = {}

function stone.create(groupID,x,y)
    local obj = object.create(groupID)
    obj.curx = x
    obj.cury = y
    obj.bonus = 0

    function obj.ondraw2()
        if(obj.bonus==0)then return end
        local cellsize = love.graphics.getHeight()/settings.cellsY
        local radius = cellsize*0.4
        local center = cellsize*0.5

        --parusa parusa
        --stroim korabl rabotyagi
        --poka vmeshaetsya v ekran znachit norm(c)
        if(obj.bonus==1)then
            if(obj.state=="birth")then
                local r,g,b,a = unpack(rgba[obj.color])
                love.graphics.setColor(r,g,b,obj.statealpha)
                love.graphics.circle("fill", cellsize*obj.curx+center, cellsize*obj.cury+center, obj.statesize)
                --bonus
                love.graphics.setColor(brgba[obj.bonus])
                love.graphics.circle("fill", cellsize*obj.curx+center, cellsize*obj.cury+center, obj.statesize*0.4)
            elseif(obj.state=="alive")then
                --original
                love.graphics.setColor(rgba[obj.color])
                love.graphics.circle("fill", cellsize*obj.curx+center, cellsize*obj.cury+center, radius)
                --bonus
                love.graphics.setColor(brgba[obj.bonus])
                love.graphics.circle("fill", cellsize*obj.curx+center, cellsize*obj.cury+center, obj.statesize)
            elseif(obj.state=="fading")then
                --original
                love.graphics.setColor(rgba[obj.color])
                love.graphics.circle("fill", cellsize*obj.curx+center, cellsize*obj.cury+center, radius)
                --mask
                love.graphics.setColor(0,0,0)
                love.graphics.circle("fill", cellsize*obj.curx+center, cellsize*obj.cury+center, obj.statesize)
            elseif(obj.state=="fading2")then
                --mask disappearing
                love.graphics.setColor(0,0,0,obj.statealpha)
                love.graphics.circle("fill", cellsize*obj.curx+center, cellsize*obj.cury+center, obj.statesize)
            end
        elseif(obj.bonus==2)then
            if(obj.state=="birth")then
                local r,g,b,a = unpack(rgba[obj.color])
                love.graphics.setColor(r,g,b,obj.statealpha)
                love.graphics.circle("fill", cellsize*obj.curx+center, cellsize*obj.cury+center, obj.statesize)
                --bonus
                love.graphics.setColor(brgba[obj.bonus])
                love.graphics.circle("fill", cellsize*obj.curx+center, cellsize*obj.cury+center, obj.statesize*0.5)
            elseif(obj.state=="alive")then
                --original
                love.graphics.setColor(rgba[obj.color])
                love.graphics.circle("fill", cellsize*obj.curx+center, cellsize*obj.cury+center, radius)
                --bonus
                love.graphics.setColor(brgba[obj.bonus])
                love.graphics.circle("fill", cellsize*obj.curx+center, cellsize*obj.cury+center, obj.statesize)
            elseif(obj.state=="fading")then
                --original
                love.graphics.setColor(rgba[obj.color])
                love.graphics.circle("fill", cellsize*obj.curx+center, cellsize*obj.cury+center, radius)
                --mask
                love.graphics.setColor(0,0,0)
                love.graphics.circle("fill", cellsize*obj.curx+center, cellsize*obj.cury+center, obj.statesize)
            elseif(obj.state=="fading2")then
                --mask disappearing
                love.graphics.setColor(0,0,0,obj.statealpha)
                love.graphics.circle("fill", cellsize*obj.curx+center, cellsize*obj.cury+center, obj.statesize)
            end
        elseif(obj.bonus==3)then
            if(obj.state=="birth")then
                --original
                local r,g,b,a = unpack(rgba[obj.color])
                love.graphics.setColor(r,g,b,a)
                love.graphics.circle("line", cellsize*obj.curx+center, cellsize*obj.cury+center, obj.statesize)
            elseif(obj.state=="alive")then
                --original
                love.graphics.setColor(rgba[obj.color])
                love.graphics.circle("line", cellsize*obj.curx+center, cellsize*obj.cury+center, obj.statesize+5)
            elseif(obj.state=="fading")then
                --original
                love.graphics.setColor(rgba[obj.color])
                love.graphics.circle("fill", cellsize*obj.curx+center, cellsize*obj.cury+center, radius)
                --mask
                love.graphics.setColor(0,0,0)
                love.graphics.circle("fill", cellsize*obj.curx+center, cellsize*obj.cury+center, obj.statesize)
            elseif(obj.state=="fading2")then
                love.graphics.setColor(0,0,0,obj.statealpha)
                love.graphics.circle("fill", cellsize*obj.curx+center, cellsize*obj.cury+center, obj.statesize)
            end
        elseif(obj.bonus==4)then
            if(obj.state=="birth")then
                local r,g,b,a = unpack(rgba[obj.color])
                local rw, rh = radius*1.2, radius*0.5
                local rx, ry = (cellsize*obj.curx+center-rw/2) ,(cellsize*obj.cury+center-rh/2)
                love.graphics.setColor(r,g,b,obj.statealpha)
                love.graphics.circle("fill", cellsize*obj.curx+center, cellsize*obj.cury+center, obj.statesize)
                --bonus
                love.graphics.setColor(brgba[obj.bonus])
                love.graphics.rectangle("fill", rx, ry, rw*obj.statesize, rh)
            elseif(obj.state=="alive")then
                --original
                local rw, rh = radius*1.2, radius*0.5
                local rx, ry = (cellsize*obj.curx+center-rw/2) ,(cellsize*obj.cury+center-rh/2)
                love.graphics.setColor(rgba[obj.color])
                love.graphics.circle("fill", cellsize*obj.curx+center, cellsize*obj.cury+center, radius)
                --bonus
                love.graphics.setColor(brgba[obj.bonus])
                love.graphics.rectangle("fill", rx+(rw*obj.statesize)/2, ry, rw*obj.statesize, rh)
            elseif(obj.state=="fading")then
                --original
                love.graphics.setColor(rgba[obj.color])
                love.graphics.circle("fill", cellsize*obj.curx+center, cellsize*obj.cury+center, radius)
                --mask
                love.graphics.setColor(0,0,0)
                love.graphics.rectangle("fill", cellsize*obj.curx+center, cellsize*obj.cury+center, obj.statesize)
            elseif(obj.state=="fading2")then
                --mask disappearing
                love.graphics.setColor(0,0,0,obj.statealpha)
                love.graphics.rectangle("fill", cellsize*obj.curx+center, cellsize*obj.cury+center, obj.statesize)
            end
        end
    end
    
    function obj.ondraw()
        if(obj.bonus~=0)then return end
        local cellsize = love.graphics.getHeight()/settings.cellsY
        local radius = cellsize*0.4
        local center = cellsize*0.5

        

        if(obj.state=="birth")then
            local r,g,b,a = unpack(rgba[obj.color])
            love.graphics.setColor(r,g,b,obj.statealpha)
            love.graphics.circle("fill", cellsize*obj.curx+center, cellsize*obj.cury+center, obj.statesize)
        elseif(obj.state=="alive")then
            love.graphics.setColor(rgba[obj.color])
            love.graphics.circle("fill", cellsize*obj.curx+center, cellsize*obj.cury+center, radius)
        elseif(obj.state=="fading")then
            --original
            love.graphics.setColor(rgba[obj.color])
            love.graphics.circle("fill", cellsize*obj.curx+center, cellsize*obj.cury+center, radius)
            --mask
            love.graphics.setColor(0,0,0)
            love.graphics.circle("fill", cellsize*obj.curx+center, cellsize*obj.cury+center, obj.statesize)
        elseif(obj.state=="fading2")then
            --mask disappearing
            love.graphics.setColor(0,0,0,obj.statealpha)
            love.graphics.circle("fill", cellsize*obj.curx+center, cellsize*obj.cury+center, obj.statesize)
        end

    end

    function obj.ontap()
        if(obj.bonus==0)then
            obj.state = "fading"
            addon.draw.remove(obj.ondraw2,3)
            addon.draw.remove(obj.ondraw2,2)
            
            addon.draw.add(obj.ondraw2,3)

        elseif(obj.bonus==1)then
            obj.state = "fading"
            addon.draw.remove(obj.ondraw2,3)
            addon.draw.remove(obj.ondraw2,2)
            
            addon.draw.add(obj.ondraw2,3)

        elseif(obj.bonus==2)then
            obj.state = "fading"
            addon.draw.remove(obj.ondraw2,3)
            addon.draw.remove(obj.ondraw2,2)
            
            addon.draw.add(obj.ondraw2,3)

        elseif(obj.bonus==3)then
            obj.state = "fading"
            addon.draw.remove(obj.ondraw2,3)
            addon.draw.remove(obj.ondraw2,2)

            addon.draw.add(obj.ondraw2,3)
        end
    end

    function obj.addbonus(type)
        obj.nextbonus = type
    end

    function obj.onupdate(dt)
        --parusa parusa
        --stroim korabl rabotyagi
        --poka vmeshaetsya v ekran znachit norm(c)
        if(obj.bonus==0)then
            if(obj.state=="birth")then
                local size = (love.graphics.getHeight()/settings.cellsY)*0.4

                if(obj.statealpha<rgba[obj.color][4])then
                    obj.statealpha = obj.statealpha+dt*40
                end
                if(obj.statealpha>rgba[obj.color][4])then
                    obj.statealpha = rgba[obj.color][4]
                end

                obj.statesize = obj.statesize+size*dt*56

                if(obj.statesize>=size)then
                    obj.state="alive"
                    obj.statesize = 0
                    obj.statealpha = 1
                end

            elseif(obj.state=="fading")then
                local size = (love.graphics.getHeight()/settings.cellsY)*0.4
                obj.statesize = obj.statesize+size*dt*56

                if(obj.statesize>=size)then
                    obj.state="fading2"
                end
                
            elseif(obj.state=="fading2")then
                obj.statealpha = obj.statealpha - dt*56

                if(obj.statealpha<=0)then
                    obj.perform(false)
                    obj.respawn()
                end
            end

        elseif(obj.bonus==1)then
            if(obj.state=="birth")then
                local size = (love.graphics.getHeight()/settings.cellsY)*0.4

                if(obj.statealpha<brgba[obj.bonus][4])then
                    obj.statealpha = obj.statealpha+dt*40
                end

                if(obj.statealpha>brgba[obj.bonus][4])then
                    obj.statealpha = brgba[obj.bonus][4]
                end

                obj.statesize = obj.statesize+size*dt*56

                if(obj.statesize>=size)then
                    obj.state="alive"
                    obj.statesize = size*0.4
                    obj.statealpha = 1
                end
            elseif(obj.state=="alive")then
                local size = (love.graphics.getHeight()/settings.cellsY)*0.4

                if(obj.statesize<size*0.2)then
                    obj.stateflag=true
                elseif(obj.statesize>size*0.4)then
                    obj.stateflag=false
                end

                if(obj.stateflag)then
                    obj.statesize=obj.statesize+dt*64
                else
                    obj.statesize=obj.statesize-dt*64
                end

            elseif(obj.state=="fading")then
                local size = (love.graphics.getHeight()/settings.cellsY)*0.4
                obj.statesize = obj.statesize+size*dt*56*3

                if(obj.statesize>=size*4)then
                    obj.state="fading2"
                end

            elseif(obj.state=="fading2")then
                obj.statealpha = obj.statealpha - dt*56

                if(obj.statealpha<=0)then
                    UI.bonuscalc(onBonus(obj))
                    obj.perform(false)
                    obj.bonus = 0
                    obj.respawn()
                end
            end
        elseif(obj.bonus==2)then
            if(obj.state=="birth")then
                local size = (love.graphics.getHeight()/settings.cellsY)*0.4

                if(obj.statealpha<brgba[obj.bonus][4])then
                    obj.statealpha = obj.statealpha+dt*40
                end

                if(obj.statealpha>brgba[obj.bonus][4])then
                    obj.statealpha = brgba[obj.bonus][4]
                end

                obj.statesize = obj.statesize+size*dt*56

                if(obj.statesize>=size)then
                    obj.state="alive"
                    obj.statesize = size*0.5
                    obj.statealpha = 1
                end
            elseif(obj.state=="alive")then
                local size = (love.graphics.getHeight()/settings.cellsY)*0.4

                if(obj.statesize<size*0.5)then
                    obj.stateflag=true
                elseif(obj.statesize>size*0.7)then
                    obj.stateflag=false
                end

                if(obj.stateflag)then
                    obj.statesize=obj.statesize+dt*64
                else
                    obj.statesize=obj.statesize-dt*64
                end

            elseif(obj.state=="fading")then
                local size = (love.graphics.getHeight()/settings.cellsY)*0.4
                obj.statesize = obj.statesize+size*dt*56*3

                if(obj.statesize>=size*6)then
                    obj.state="fading2"
                end

            elseif(obj.state=="fading2")then
                obj.statealpha = obj.statealpha - dt*56

                if(obj.statealpha<=0)then
                    UI.bonuscalc(onBonus(obj))
                    obj.perform(false)
                    obj.bonus = 0
                    obj.respawn()
                end
            end
        elseif(obj.bonus==3)then
            if(obj.state=="birth")then
                local size = (love.graphics.getHeight()/settings.cellsY)*0.4

                if(obj.statealpha<brgba[obj.bonus][4])then
                    obj.statealpha = obj.statealpha+dt*40
                end

                if(obj.statealpha>brgba[obj.bonus][4])then
                    obj.statealpha = brgba[obj.bonus][4]
                end

                obj.statesize = obj.statesize+size*dt*56

                if(obj.statesize>=size)then
                    obj.state="alive"
                    obj.statesize = size*0.9
                    obj.statealpha = 1
                end
            elseif(obj.state=="alive")then
                local size = (love.graphics.getHeight()/settings.cellsY)*0.4

                if(obj.statesize<size*0.9)then
                    obj.stateflag=true
                elseif(obj.statesize>size)then
                    obj.stateflag=false
                end

                if(obj.stateflag)then
                    obj.statesize=obj.statesize+dt*64
                else
                    obj.statesize=obj.statesize-dt*64
                end

            elseif(obj.state=="fading")then
                local size = (love.graphics.getHeight()/settings.cellsY)*0.4
                obj.statesize = obj.statesize+size*dt*56*2

                if(obj.statesize>=size*8)then
                    obj.state="fading2"
                end

            elseif(obj.state=="fading2")then
                obj.statealpha = obj.statealpha - dt*56

                if(obj.statealpha<=0)then
                    UI.bonuscalc(onBonus(obj))
                    obj.perform(false)
                    obj.bonus = 0
                    obj.respawn()
                end
            end
        elseif(obj.bonus==4)then
            if(obj.state=="birth")then
                local size = (love.graphics.getHeight()/settings.cellsY)*0.4

                if(obj.statealpha<brgba[obj.bonus][4])then
                    obj.statealpha = obj.statealpha+dt*40
                end

                if(obj.statealpha>brgba[obj.bonus][4])then
                    obj.statealpha = brgba[obj.bonus][4]
                end

                obj.statesize = obj.statesize+size*dt*56

                if(obj.statesize>=size)then
                    obj.state="alive"
                    obj.statesize = size*0.9
                    obj.statealpha = 1
                end
            elseif(obj.state=="alive")then
                local size = (love.graphics.getHeight()/settings.cellsY)*0.4

                if(obj.statesize<size*0.1)then
                    obj.stateflag=true
                elseif(obj.statesize>size*0.2)then
                    obj.stateflag=false
                end

                if(obj.stateflag)then
                    obj.statesize=obj.statesize+dt*8
                else
                    obj.statesize=obj.statesize-dt*8
                end

            elseif(obj.state=="fading")then
                local size = (love.graphics.getHeight()/settings.cellsY)*0.4
                obj.statesize = obj.statesize+size*dt*56*2

                if(obj.statesize>=size*8)then
                    obj.state="fading2"
                end

            elseif(obj.state=="fading2")then
                obj.statealpha = obj.statealpha - dt*56

                if(obj.statealpha<=0)then
                    UI.bonuscalc(onBonus(obj))
                    obj.perform(false)
                    obj.bonus = 0
                    obj.respawn()
                end
            end
        end
    end

    function obj.oncreate()
        obj.color = love.math.random(1,4)
        obj.state = "birth"
        obj.statesize = 0
        obj.statealpha = 0
        obj.stateflag = false
        obj.nextbonus = 0
        addon.draw.add(obj.ondraw2,2)
    end

    function obj.respawn()
        obj.color = math.random(1,4)
        obj.state = "birth"
        obj.statesize = 0
        obj.statealpha = 0
        if(obj.nextbonus~=0)then
            obj.bonus = obj.nextbonus
            obj.nextbonus = 0
        end

        addon.draw.remove(obj.ondraw2,2)
        addon.draw.remove(obj.ondraw2,3)
        addon.draw.add(obj.ondraw2,2)

        obj.perform(true)
    end

    function obj.ondestroy()

    end
    
    return obj
end

rgba = {}
rgba[1] = {1, 1, 1, 0.7} 
rgba[2] = {1, 0.28, 0.10, 0.7}
rgba[3] = {0, 0.6, 0, 0.7}
rgba[4] = {0, 0.36, 90, 0.7}

brgba = {}
brgba[1] = {0, 0, 0, 1}
brgba[2] = {0, 0, 0, 1}
brgba[3] = {0, 0, 0, 1}
brgba[4] = {0, 0, 0, 1}