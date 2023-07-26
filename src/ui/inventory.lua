local spaceBetween = 85
local itemScale = 5
local itemsPerRow = 5
local closeSum = 0
local clickedInside = false

local function itemPlace(item, place, s)
    if place <= 10 then
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
end

        -- MM DUCTAPE THERE PUT SOME HERE TOO

local function onInvButtonPress(x, y, button, istouch, id)
    local bPlace = tonumber(StrSplit(id)[2])

    if not (x >= Inv.smallWindow.x and x <= Inv.smallWindow.x+TexSize["ui/smallWindow.png"].w*Inv.scale and y >= Inv.smallWindow.y and y <= Inv.smallWindow.y+TexSize["ui/smallWindow.png"].h*Inv.scale and Inv.smallWindow.enabled) then
        if Inv.smallWindow.itemSel == bPlace and Inv.smallWindow.enabled then
            Inv.smallWindow.enabled = false
        elseif Char.inventory[bPlace + 5] then -- SMELLS LIKE  DUCKGTAPE
            Inv.smallWindow.enabled = true
            Inv.smallWindow.itemSel = bPlace -- PUT SOME HERE TOOO MHMHMMM
            Inv.smallWindow:setPos()
        end
    end
end

local function onNotInvButtonPress(x, y, button, istouch, id)
    local bPlace = tonumber(StrSplit(id)[2])

    if StrStartsWith("inv:", id) and Char.inventory[bPlace + 5] then
        closeSum = (closeSum or 0) + 1
    end
end

-- sorry I started to lose my mind

Inventory = {}
Inventory.__index = Inventory

function Inventory:new()
    self = setmetatable({}, Inventory)
    self.enable = false
    self.scale = 3.5
    self.selected = 1
    self.font30 = love.graphics.newFont(30)
    self.font20 = love.graphics.newFont(20)

    for i = 1, 10 do
        local row = math.ceil(i / itemsPerRow)
        local column = (i - 1) % itemsPerRow + 1

        local bx = love.graphics.getWidth()/2 - 200 + (column - 1) * spaceBetween
        local by = love.graphics.getHeight()/2 - 120 + (row - 1) * 120

        Button:new("rectangle", bx, by, 8.9*Scale, 12.7*Scale, 1, onInvButtonPress, ("inv: " .. tostring(i)), onNotInvButtonPress)
    end

    local SW = require("src.ui.invItemSettings")
    SW = SW.itemMenu
    self.smallWindow = SW:new()

    return self
end

function Inventory:update()
    if closeSum >= #Char.inventory - 5 and clickedInside == false then
        self.smallWindow.enabled = false
    end

    closeSum = 0
end

function Inventory:draw()
    if self.enable then
        love.graphics.setFont(self.font30)
        love.graphics.draw(Tex["ui/invBig.png"], love.graphics.getWidth()/2-TexSize["ui/invBig.png"].hw*self.scale, love.graphics.getHeight()/2-TexSize["ui/invBig.png"].hh*self.scale, 0, self.scale, self.scale)
        love.graphics.print("Inventory:", love.graphics.getWidth()/2-73, love.graphics.getHeight()/2-185)
        for i = 6, #Char.inventory do
            itemPlace(Char.inventory[i], i-5, self.font20)
        end

        self.smallWindow:render()
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

        if self.enable then
            self.smallWindow.enabled = false
        end
    end
end

function Inventory:mousePressed(x, y, button)
    self.smallWindow:clicked(x, y, button)

    if (x >= self.smallWindow.x and x <= self.smallWindow.x + TexSize["ui/smallWindow.png"].w * self.scale and y >= self.smallWindow.y and y <= self.smallWindow.y + TexSize["ui/smallWindow.png"].h * self.scale and self.smallWindow.enabled) then
        clickedInside = true
    else
        clickedInside = false
    end
end