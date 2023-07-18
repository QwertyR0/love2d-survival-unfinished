local function countEmptyPixels(image, axis, quad)
    local emptyPixelCount = 0
    local quadX, quadY, quadW, quadH = quad:getViewport()

    if axis == "x" then
        for x = quadX, quadX + quadW - 1 do
            local emptyColumn = true
            for y = quadY, quadY + quadH - 1 do
                local r, g, b, a = image:getPixel(x, y)
                if a ~= 0 then
                    emptyColumn = false
                    break
                end
            end
            if emptyColumn then
                emptyPixelCount = emptyPixelCount + 1
            end
        end
    elseif axis == "y" then
        for y = quadY, quadY + quadH - 1 do
            local emptyRow = true
            for x = quadX, quadX + quadW - 1 do
                local r, g, b, a = image:getPixel(x, y)
                if a ~= 0 then
                    emptyRow = false
                    break
                end
            end
            if emptyRow then
                emptyPixelCount = emptyPixelCount + 1
            end
        end
    end

    return emptyPixelCount
end

function CheckBoxCollision(box1, box2)
    return box1.x < box2.x + box2.width and
           box1.x + box1.width > box2.x and
           box1.y < box2.y + box2.height and
           box1.y + box1.height > box2.y
end

function GetTreeCollision(x, y)
    return {x = (x-1)*Scale*TileW+7*Scale, y = (y-1)*Scale*TileH, width = 9*Scale, height = 4*Scale}
end

return {countEmptyPixels = countEmptyPixels}
