--[[
main thing - FUCK THE : 

how to name things
draw/update
- obj.ondraw        - for main thing object does
- obj.thingondraw   - for another thing object does (aka inner object not defined in another file)
- obj.pefrofm       - for setting if object should be drawn/updated (obj.performflag = false) on default
same with update

on creating/on destroy
- obj.oncreate()    - call when object created, aka init
- obj.ondestroy()   - call when object no longer needed, aka cleaning

another things in object
obj.[thing]_init = init

obj.oncreate()
    if(obj.[thing]_init)then obj.[thing]_init() end

end

words to use in names
set/get for some inner things

init>setup  - on create
perform>others - on/off flags name

coords
posx/posx
cx,cy - current x/y
nx,ny - next x/y
mx,my - mouse x/y
maxx/y,minx/y - if used in range - if(x<maxx and x>minx and y>miny and y<maxy)then end

loops
1 layered - i
2 layered - depends on what we looping for, may be width/height(w/h), if no param set then should be a/b

try to name things that way so they wont need comments to understand

evade big things of code, comment if happens

--shit related to metatables

indextable = contains ???
metatable = contains methods

---------------------------------------
--needed things
---------------------------------------
1) improve objects to be able to add functions to stack
and then call stack on event
e.g. 
function onupdate(dt)
    if(not perform)then return end
    for k,v in pairs(updatestack)do
        v(dt)
    end
end

+add things to highest level that allows to move draw functions between layers

+add obj.updater which will work as drawIf and updateIf logic

2) improve addon lib to be able to configure draw layers easily
e.g. 
drawstack[(k==func)].z = 1/99999

first z being drawed first


3) add thing to not add duplicated functions and throw smth to cmd ^

4) understand metatables when

5) add check to nox emulator to not get "click is out of bounds" error