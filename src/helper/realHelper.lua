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
    return {x = (x-1)*Scale*TileW+8*Scale, y = (y-1)*Scale*TileH, width = 8*Scale, height = 4*Scale}
end

function GetRockCollision(x, y)
    return {x = (x-1)*Scale*TileW+11*Scale, y = (y-1)*Scale*TileH+9*Scale, width = 3*Scale, height = 6*Scale}
end

function GetMouseRealPos()
    local hw = love.graphics.getWidth()/2
    local hh = love.graphics.getHeight()/2
    local moX = love.mouse.getX()
    local moY = love.mouse.getY()
    local camX = Camera.x-hw
    local camY = Camera.y-hh

    return {x = moX + camX, y = moY + camY}
end

-- TODO:
function PlayerSpawn(seed)
    -- this will be used for deletin spawn objects
end

return {countEmptyPixels = countEmptyPixels}