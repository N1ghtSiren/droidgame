touches = {}
local t = {}

local w,h = love.graphics.getWidth(),love.graphics.getHeight()

function touches.add(x,y)
    if(touches.isPaused)then return end

    if(x<w and x>0 and y>0 and y<h)then
        table.insert(t,{x,y})
    end
    
end

function touches.clear(time)
    for k,_ in pairs(t)do
        t[k] = nil
    end

end

function touches.get()
	return t
end

function touches.isInArea(minx,miny,maxx,maxy)
    local points = touches.get()
    local x, y = nil

    for _, t in ipairs(points) do
        x, y = unpack(t)
        if(x<maxx and x>minx and y>miny and y<maxy)then
            return true
        end
    end
    return false
end

function touches.pause(time)
    touches.isPaused=true
    Timer.after(time,function()
        touches.isPaused=false
    end)
end

--main function
function love.run()
	if love.load then love.load(love.arg.parseGameArguments(arg), arg) end
 
	-- We don't want the first frame's dt to include time taken by love.load.
	if love.timer then love.timer.step() end
 
    local ddt = 0
	local dt = 0
 
	-- Main loop time.
	return function()
		-- Process events.
		if love.event then
			love.event.pump()
			for name, a,b,c,d,e,f in love.event.poll() do
				if name == "quit" then
					if not love.quit or not love.quit() then
						return a or 0
					end
				end
				love.handlers[name](a,b,c,d,e,f)
			end
		end
        
        --get touches
        local t = love.touch.getTouches()

        for i, id in ipairs(t) do
            local x,y = love.touch.getPosition(id)
            touches.add(x,y)
        end

		--debug - get mouse
		if(love.mouse.isDown(1))then
        	x,y = love.mouse.getPosition()
			touches.add(x,y)
		end
 
		-- Update dt, as we'll be passing it to update
		if love.timer then dt = love.timer.step() end

        --skip update and draw to save energy
        --limit to 32 per second
        --if app not focused, dt goes very high and needs to be lmited
        ddt = ddt + dt
        if(ddt>0.03125)then
            ddt = 0
            if(dt>0.03125)then
                dt = 0.03125
            end
        else
            goto next
        end
        
		-- Call update and draw
		if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled
 
		if love.graphics and love.graphics.isActive() then
			love.graphics.origin()
			love.graphics.clear(love.graphics.getBackgroundColor())
 
			if love.draw then love.draw(dt) end
 
			love.graphics.present()
		end

        ::next::
		if love.timer then love.timer.sleep(0.001) end
	end
end

--debug
local function f(dt)
    if(love.keyboard.isScancodeDown("escape"))then
        --love.event.quit()
    end

    if(Timer)then Timer.update(dt) end
end
addon.update.add(f,0)


function fuko(t,msg)
    if(msg~=nil)then 
        print(msg)
    end

    for k,v in pairs(t)do
        print("t["..tostring(k).."]:"..tostring(v))
    end
    print("")
end

function mathfix(n,min,max)
    if(n<min)then
        return min
    end
    if(n>max)then 
        return max
    end
    return n
end

function round(n)
    return math.floor(n+0.5)
end

function isTouchInArea(minx,miny,maxx,maxy)
    local points = touches.get()
    local x, y = nil

    for _, t in ipairs(points) do
        x, y = unpack(t)
        if(x<maxx and x>minx and y>miny and y<maxy)then
            return true
        end
    end
    return false

end

--divisor(9,2) -> 4
function divisor(n,n2)
    local f = math.fmod(n,n2)
    local r = (n-f)/n2
    return r
end
--lazy ifs
local case_var = 0
function setupCase(var)
    case_var = var
end

function case(equalTo,varToReturn)
    if(case_var==equalTo)then
        return varToReturn
    end
end
