function onBonus(obj)
    local x,y = obj.curx,obj.cury
    local type = obj.bonus
    local t = Grid.cells
    local match = {}

    if(type==1)then
        cx,cy = x-1,y+1
        if( not(cy<0 or cx<0 or cy>settings.cellsY-1 or cx>settings.cellsX-1)and t[cx][cy].state~="fading")then
            table.insert(match,t[cx][cy])
        end

        cx,cy = x,y+1
        if( not(cy<0 or cx<0 or cy>settings.cellsY-1 or cx>settings.cellsX-1)and t[cx][cy].state~="fading")then
            table.insert(match,t[cx][cy])
        end
        cx,cy = x+1,y+1
        if( not(cy<0 or cx<0 or cy>settings.cellsY-1 or cx>settings.cellsX-1)and t[cx][cy].state~="fading")then
            table.insert(match,t[cx][cy])
        end
        cx,cy = x-1,y
        if( not(cy<0 or cx<0 or cy>settings.cellsY-1 or cx>settings.cellsX-1)and t[cx][cy].state~="fading")then
            table.insert(match,t[cx][cy])
        end
        cx,cy = x+1,y
        if( not(cy<0 or cx<0 or cy>settings.cellsY-1 or cx>settings.cellsX-1)and t[cx][cy].state~="fading")then
            table.insert(match,t[cx][cy])
        end
        cx,cy = x-1,y-1
        if( not(cy<0 or cx<0 or cy>settings.cellsY-1 or cx>settings.cellsX-1)and t[cx][cy].state~="fading")then
            table.insert(match,t[cx][cy])
        end
        cx,cy = x,y-1
        if( not(cy<0 or cx<0 or cy>settings.cellsY-1 or cx>settings.cellsX-1)and t[cx][cy].state~="fading")then
            table.insert(match,t[cx][cy])
        end
        cx,cy = x+1,y-1
        if( not(cy<0 or cx<0 or cy>settings.cellsY-1 or cx>settings.cellsX-1)and t[cx][cy].state~="fading")then
            table.insert(match,t[cx][cy])
        end

    elseif(type==2)then
        --5x5 except very corners
        local m = {
                 {x-1,y+2}, {x,y+2},  {x+1,y+2},
        {x-2,y}, {x-1,y+1}, {x,y+1},  {x+1,y+1}, {x+2,y+1},
        {x-2,y}, {x-1,y},   {x,y},    {x+1,y},   {x+2,y},
        {x-2,y}, {x-1,y-1}, {x,y-1},  {x+1,y+1}, {x+2,y-1},
                 {x-1,y-2}, {x,y-2},  {x+1,y+2}
        }

        for k,_ in pairs(m)do
            cx,cy = m[k][1],m[k][2]
            if( not(cy<0 or cx<0 or cy>settings.cellsY-1 or cx>settings.cellsX-1)and t[cx][cy].state~="fading")then
                table.insert(match,t[cx][cy])
            end
        end
    elseif(type==3)then
        --7x7 except corners - 3 on each
        local m = {
                                {x-1,y+3},  {x,y+3},    {x+1,y+3},  
                    {x-2,y+2},  {x-1,y+2},  {x,y+2},    {x+1,y+2},  {x+2,y+2},  
        {x-3,y+1},  {x-2,y+1},  {x-1,y+1},  {x,y+1},    {x+1,y+1},  {x+2,y+1},  {x+3,y+1},
        {x-3,y},    {x-2,y},    {x-1,y},    {x,y},      {x+1,y},    {x+2,y},    {x+3,y},
        {x-3,y-1},  {x-2,y-1},  {x-1,y-1},  {x,y-1},    {x+1,y-1},  {x+2,y-1},  {x+3,y-1},
                    {x-2,y-2},  {x-1,y-2},  {x,y-2},    {x+1,y-2},  {x+2,y-2},  
                                {x-1,y-3},  {x,y-3},    {x+1,y-3}
        }

        for k,_ in pairs(m)do
            cx,cy = m[k][1],m[k][2]
            if( not(cy<0 or cx<0 or cy>settings.cellsY-1 or cx>settings.cellsX-1)and t[cx][cy].state~="fading")then
                table.insert(match,t[cx][cy])
            end
        end
    end

    return match,x,y
end

