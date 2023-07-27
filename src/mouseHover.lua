HoveredOn = {x = nil, y = nil, enable = true}

function HoverUpdate()
    local mousePos = GetMouseRealPos()
    local realX = math.floor(mousePos.x / Scale / TileW)
    local realY = math.floor(mousePos.y / Scale / TileH)

    HoveredOn.x = realX
    HoveredOn.y = realY
end

function HoverRender()
    if HoveredOn.enable then
        love.graphics.setColor(74/255, 237/255, 194/255, 0.5)
        love.graphics.setLineWidth(10)
        love.graphics.rectangle("line", HoveredOn.x * 16 *Scale, HoveredOn.y * Scale * 16, TileW * Scale, TileH * Scale)
        love.graphics.setLineWidth(1)
        love.graphics.setColor(1, 1, 1, 1)
    end
end