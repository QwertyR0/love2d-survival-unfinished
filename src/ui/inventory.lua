local spaceBetween = 85
local itemScale = 5
local itemsPerRow = 5

local function itemPlace(item, place, s)
    local row = math.ceil(place / itemsPerRow)
    local column = (place - 1) % itemsPerRow + 1

    local placeX = love.graphics.getWidth()/2 - 200 + (column - 1) * spaceBetween
    local placeY = love.graphics.getHeight()/2 - 120 + (row - 1) * 120

    if item.id == "apple" then
        love.graphics.draw(Tex["items/apple.png"], placeX, placeY, 0, itemScale, itemScale)
    elseif item.id == "bread" then
        love.graphics.draw(Tex["items/bread.png"], placeX, placeY, 0, itemScale, itemScale)
    end

    love.graphics.setFont(s)
    love.graphics.printf(item.id, placeX - 25 * itemScale, placeY + 55, 300, "center")
    love.graphics.printf(item.number, placeX - 25 * itemScale, placeY + 80, 300, "center")
end


Inventory = {}
Inventory.__index = Inventory

function Inventory:new()
    self = setmetatable({}, Inventory)
    self.enable = false
    self.scale = 3.5
    self.selected = 1
    self.font30 = love.graphics.newFont(30)
    self.font20 = love.graphics.newFont(20)
    return self
end

function Inventory:update()

end

function Inventory:draw()
    if self.enable then
        love.graphics.setFont(self.font30)
        love.graphics.draw(Tex["ui/invBig.png"], love.graphics.getWidth()/2-TexSize["ui/invBig.png"].hw*self.scale, love.graphics.getHeight()/2-TexSize["ui/invBig.png"].hh*self.scale, 0, self.scale, self.scale)
        love.graphics.print("Inventory:", love.graphics.getWidth()/2-73, love.graphics.getHeight()/2-185)
        for i = 6, #Char.inventory do
            itemPlace(Char.inventory[i], i-5, self.font20)
        end
    end
end

function Inventory:show()
    self.enable = true
    HoveredOn.enable = true
end

function Inventory:hide()
    self.enable = false
    HoveredOn.enable = false
end

function Inventory:toggle()
    self.enable = not(self.enable)
    HoveredOn.enable = not(self.enable)
end

function Inventory:keyPressed(key)
    if key == "1" then
        self.selected = 1
    elseif key == "2" then
        self.selected = 2
    elseif key == "3" then
        self.selected = 3
    elseif key == "4" then
        self.selected = 4
    elseif key == "5" then
        self.selected = 5
    end

    if key == "tab" then
        self:toggle()
    end
end