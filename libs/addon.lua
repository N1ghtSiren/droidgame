---------------------------------------------------------------------
--main draw stack
addon = {}
addon.draw = {}
addon.drawgroup = {}

local drawGroup = {}

function addon.drawgroup.create(groupId)
    if(drawGroup[groupId]==nil)then
        drawGroup[groupId]={}
        drawGroup[groupId].drawflag=true
        return true
    end
    return false, ("draw group"..groupId.." already exist")
end

function addon.drawgroup.delete(groupId)
    if(drawGroup[groupId]==nil)then return end

    local group = drawGroup[groupId]
    for k,v in pairs(group) do
        group[k]=nil
    end
    drawGroup[groupId]=nil
end

function addon.drawgroup.perform(groupId,flag)
    if(drawGroup[groupId]~=nil)then
        return false, ("draw group"..groupId.."does not exist")
    end
    drawGroup[groupId].drawflag = flag
    return true
end

function addon.draw.add(func,groupId,position)
    groupId=groupId or 0
    if(drawGroup[groupId]==nil)then
        return false, ("draw group"..groupId.." does not exist")
    end

    if(position~=nil)then
        table.insert(drawGroup[groupId],position,func)
    else
        table.insert(drawGroup[groupId],func)
    end

    return true
end

function addon.draw.remove(func,groupId)
    local group = drawGroup[groupId]
    for k,v in pairs(group) do
        if(v==func)then group[k]=nil
            return
        end
    end
end

function addon.draw.If(previousFlag,func,groupId,...)
    local flag = true
    local conditions = {...}

    for k,v in pairs(conditions) do
        if(v==false)then
            flag=false
        end
    end
    
    if(flag==false) then
        addon.draw.remove(func,groupId)
        return false
    elseif(flag==true)then
        if(previousFlag==false)then
            addon.draw.add(func,groupId)
        end
        return true
    end
    
end

function love.draw(dt)
    local drawGroup=drawGroup

    for gid,t in pairs(drawGroup)do
        --exception, skip draw
        if(t.drawflag==false)then
            goto next
        end

        for key,func in pairs(t)do
            if(key~=nil and func~=nil and key~="drawflag")then
                if(func(dt)==true)then
                    drawGroup[gid][key]=nil
                end
            end
        end

        ::next::
    end

end
---------------------------------------------------------------------
--main update stack
addon.update = {}
addon.updategroup = {}

local updateGroup = {}

function addon.updategroup.create(groupId)
    if(updateGroup[groupId]==nil)then
        updateGroup[groupId]={}
        updateGroup[groupId].updateflag=true
        return true
    end
    return false, ("update group"..groupId.." already exist")
end

function addon.updategroup.delete(groupId)
    if(updateGroup[groupId]==nil)then return end
    
    local group = updateGroup[groupId]
    for k,v in pairs(group) do
        group[k]=nil
    end
    updateGroup[groupId]=nil
end

function addon.updategroup.perform(groupId,flag)
    if(updateGroup[groupId]~=nil)then
        return false, ("update group"..groupId.."does not exist")
    end
    updateGroup[groupId].updateflag = flag
    return true
end

function addon.update.add(func,groupId,position)
    groupId=groupId or 0
    if(updateGroup[groupId]==nil)then
        return false, ("update group"..groupId.." does not exist")
    end

    if(position~=nil)then
        table.insert(updateGroup[groupId],position,func)
    else
        table.insert(updateGroup[groupId],func)
    end

    return true
end

function addon.update.remove(func,groupId)
    local group = updateGroup[groupId]
    for k,v in pairs(group) do
        if(v==func)then group[k]=nil
            return
        end
    end
end

function addon.update.If(previousFlag,func,groupId,...)
    local flag = true
    local conditions = {...}

    for k,v in pairs(conditions) do
        if(v==false)then
            flag=false
        end
    end

    if(flag==false) then
        addon.update.remove(func,groupId)
        return false
    elseif(flag==true)then
        if(previousFlag==false)then
            addon.update.add(func,groupId)
        end
        return true
    end
end

function love.update(dt)
    local updateGroup=updateGroup
    local flag

    for gid,t in pairs(updateGroup)do
        --exception, skip update
        if(t.updateflag==false)then
            goto next
        end

        for key,func in pairs(t)do
            if(key~=nil and func~=nil and key~="updateflag")then
                if(func(dt)==true)then
                    updateGroup[gid][key]=nil
                end
            end
        end

        ::next::
    end
end
---------------------------------------------------------------------
--system groups
addon.drawgroup.create(0)
addon.updategroup.create(0)