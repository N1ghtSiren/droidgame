function getSameColorNearby(obj)
    if(obj.state=="fading" or obj.state=="fading2" or obj.state=="birth")then return end

    --get all nearby cells with same color, within 1 cell up/down/left/rigt
    local unpack = unpack
    local insert = table.insert
    local remove = table.remove
    local t = Grid.cells

    local sx,sy = obj.curx, obj.cury

    local basecolor = obj.color
    local count = 0
    local match = {}

    local stack = {}    --loop over it, starting from current tap
    insert(stack,{sx,sy})

    local blacklist = {}
    local x,y = nil
    local cx,cy

    while(#stack>0)do
        x,y = unpack(stack[1])
        remove(stack,1)

        --out of bounds check
        if(y<0 or x<0 or y>settings.cellsY-1 or x>settings.cellsX-1)then
            insert(blacklist,{x,y})
            goto next2
        end

        --blacklist check
        for _,t in pairs(blacklist)do
            if(x==t[1] and y==t[2])then
                goto next2
            end
        end

        --matching color
        if(t[x][y].color==basecolor)then
            insert(match,{x,y})
            insert(blacklist,{x,y})
        end
        
        --add nearby cells to check
        if(t[x][y].color==basecolor)then
            cx,cy = x+1,y
            if( not(cy<0 or cx<0 or cy>settings.cellsY-1 or cx>settings.cellsX-1) and t[cx][cy].state=="alive")then
                insert(stack,{cx,cy})
            end
            cx,cy = x-1,y
            if( not(cy<0 or cx<0 or cy>settings.cellsY-1 or cx>settings.cellsX-1) and t[cx][cy].state=="alive")then
                insert(stack,{cx,cy})
            end
            cx,cy = x,y+1
            if( not(cy<0 or cx<0 or cy>settings.cellsY-1 or cx>settings.cellsX-1) and t[cx][cy].state=="alive")then
                insert(stack,{cx,cy})
            end
            cx,cy = x,y-1
            if( not(cy<0 or cx<0 or cy>settings.cellsY-1 or cx>settings.cellsX-1) and t[cx][cy].state=="alive")then
                insert(stack,{cx,cy})
            end
        end

        ::next2::
    end

    --remove fading cells
    local x,y = nil
    for i = #match, 1, -1 do
        x,y = match[i][1],match[i][2]
        if(t[x][y].state=="fading" or t[x][y].state=="fading2" or t[x][y].state=="birth")then
            table.remove(match,i)
        end
    end
    
    --create table with objects
    local result = {}
    for _,pos in pairs(match)do
        table.insert(result,t[pos[1]][pos[2]])
    end

    --UI.calc(basetype,#match,match[1][1],match[1][2])

    return result,basecolor,#result,sx,sy
end