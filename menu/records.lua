function recordsDecode(str)
    --x
    local found = string.find(str,"x")
    local x = string.sub(str,1,found-1)
    str = string.sub(str,found+1,#str)
    --y
    found = string.find(str,"x")
    local y = string.sub(str,1,found-1)
    local taps = string.sub(str,found+1,#str)
    --
    return x,y,taps
end

function recordsGet(x,y,taps)
    return records[tostring(x).."x"..tostring(y).."x"..tostring(taps)] or 0
end

function recordsUpdate(x,y,taps,score)
    local r = records[tostring(x).."x"..tostring(y).."x"..tostring(taps)] or 0
    if(r<score)then
        records[tostring(x).."x"..tostring(y).."x"..tostring(taps)] = score
    end
end

function defaultRecords()
    records = {}
end

function saveRecords()
    local data = ""
    data = "records={}\n"
    for k,v in pairs(records)do
        data = data.."records[\""..k.."\"] = "..v.."\n"
    end

    love.filesystem.write(recordsfilename, data)
end

function loadRecords()
    local file = love.filesystem.load(recordsfilename)

    if(file==nil)then
        return false
    end
    
    return xpcall(file,debug.traceback)
end

recordsfilename = "records.lua"