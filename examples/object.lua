object = {}
local objlist = {}

function object.create(groupID)
    local obj = {}
    table.insert(objlist,obj)
	obj.key = #objlist
    
    local function ondraw(dt)
        if(not obj.performflag)then return end
        if(obj.ondraw)then obj.ondraw(dt) end
        
    end

    local function onupdate(dt)
        if(not obj.performflag)then return end
        if(obj.onupdate)then obj.onupdate(dt) end
        
    end

    local function oncreate()
        obj.performflag = false

        addon.update.add(onupdate,groupID)
        addon.draw.add(ondraw,groupID)

        
    end
	
	function obj.perform(flag)
        if(obj.oncreate and obj.iscreated~=true)then
            obj.iscreated=true
            obj.oncreate()
        end

        obj.performflag = flag

    end
	
	function obj.destroy()
		addon.update.remove(onupdate,groupID)
        addon.draw.remove(ondraw,groupID)

        if(obj.ondestroy)then obj.ondestroy() end
		
		objlist[obj.key] = nil
		obj = nil

    end

    
    obj.iscreated = false
    oncreate()
    return obj
end