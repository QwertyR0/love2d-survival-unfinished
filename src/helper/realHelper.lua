Fonts = {
    default = love.graphics.getFont(),
    tiny = love.graphics.newFont(15),
    small = love.graphics.newFont(20),
    medium = love.graphics.newFont(30),
    big = love.graphics.newFont(40),
    huge = love.graphics.newFont(50)
}
 
-- no need this currently:

--[[
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

]]

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

function StrSplit(str)
    local words = {}
    
    for word in str:gmatch("%S+") do
        table.insert(words, word)
    end
    
    return words
end

function StrStartsWith(String1, String2)
	local Count = #String1
	local FirstChars = string.sub(String2, 1, Count)
	return FirstChars == String1
end

function IsOutOfBounds(x, y, width, height)
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    -- Check if the rectangle is out of the screen's bounds
    if x < 0 or x + width > screenWidth or y < 0 or y + height > screenHeight then
        return true
    else
        return false
    end
end

local items = {
    apple = {
        id = "apple",
        description = "A very tasty fruit",
        max = 7,
        eat = {
            eatable = true,
            health = 1,
            power = nil
        },
        pickable = false,
        TexPath = "items/apple.png"
    },

    bread = {
        id = "bread",
        description = "bread bread bread",
        max = 5,
        eat = {
            eatable = true,
            health = 2,
            power = nil
        },
        pickable = false,
        TexPath = "items/bread.png"
    },

    rock = {
        id = "rock",
        description = "feels hard to hold",
        max = 15,
        eat = {
            eatable = false,
        },
        pickable = true,
        TexPath = "smallRock.png"
    },

    tree = {
        pickable = false
    }
}

function GetItemInfo(name)
    local info = items[name]

    if info then
        return info
    else
        return false
    end
end

function IsInteger(str)
    return not (str == "" or str:find("%D"))
end

function RelocateElems(list, fromIndex, toIndex)
    local element1 = list[fromIndex]
    local element2 = list[toIndex]
    list[fromIndex] = element2
    list[toIndex] = element1
end

-- NOTE: developement only
function LogTable(tableToLog, indent)
    if type(tableToLog) == "table" then
        indent = indent or 0
        local indentation = string.rep(" ", indent)
        for key, value in pairs(tableToLog) do
            if type(value) == "table" then
                print(indentation .. key .. " = {")
                LogTable(value, indent + 2)
                print(indentation .. "}")
            else
                print(indentation .. key .. " = " .. tostring(value))
            end
        end
    else
        print("Error: Not a table")
    end
end

-- size of object on pickup:
function EaseOutExpo(x)
    local y = 0

    if x == 1 then
        y = 1
    else
        y = 1 - math.pow(2, -10 * x)
    end

    return y
end

-- movement of object on pickup:
function EaseInExpo(x)
    local y = 0

    if x == 0 then
        y = 0
    else
        y = 1 - math.pow(2, 10 * x - 10)
    end

    return y
end

function TableFind(list, elem, name)
    local r = false

    if name == nil then
        for k, v in pairs(list) do
            if v == elem then
                r = k
                break
            end
        end
    else
        for k, v in pairs(list) do
            if v[name] == elem then
                r = k
                break
            end
        end
    end

    return r
end

-- return {countEmptyPixels = countEmptyPixels}