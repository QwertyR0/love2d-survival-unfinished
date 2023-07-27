--[[    DISCLAIMER:

        THIS UI CODE IS HOLD WITH DUCKTAPE AND CARDBOARD
        DON'T BE MAD I WAS TIRED
        I ALSO DISPISE THIS CODE
        Sorry about that
]]

local itemMenu = {}
itemMenu.__index = itemMenu

function itemMenu:new()
    self.enabled = false
    self.properties = {}
    self.itemSel = 0
    self.x = love.graphics.getWidth() -- hide the mess just in case...
    self.y = love.graphics.getHeight()
    self.__index = self

    return self
end

function itemMenu:render()
    if self.enabled then
        love.graphics.draw(Tex["ui/smallWindow.png"], self.x, self.y, 0, Inv.scale, Inv.scale)
        love.graphics.setFont(Fonts.medium)
        local idX = self.x + TexSize["ui/smallWindow.png"].hw * Inv.scale - Fonts.medium:getWidth(self.properties.id) / 2
        love.graphics.print(self.properties.id, idX, self.y + 8 * Inv.scale)

        local buttonX = self.x + TexSize["ui/smallWindow.png"].hw * Inv.scale - TexSize["ui/wideButton.png"].hw * Inv.scale
        local buttonY = self.y + TexSize["ui/smallWindow.png"].h*Inv.scale - 20 * Inv.scale
        local sTextX = buttonX + TexSize["ui/wideButton.png"].hw * Inv.scale - Fonts.tiny:getWidth("Set Place") / 2
        local sTextY = buttonY + TexSize["ui/wideButton.png"].hh * Inv.scale - Fonts.tiny:getLineHeight() / 2
        love.graphics.draw(Tex["ui/wideButton.png"], buttonX, buttonY, 0, Inv.scale, Inv.scale)
        love.graphics.setFont(Fonts.tiny)
        love.graphics.print("Set Place", sTextX, sTextY)

        love.graphics.setFont(Fonts.small)
        local aText = ("Amount: " .. tostring(self.properties.amount).. "/" .. tostring(self.properties.max))
        local adX = (self.x + TexSize["ui/smallWindow.png"].hw * Inv.scale - Fonts.small:getWidth(aText) / 2) - 6 * Inv.scale
        love.graphics.print(aText, adX, self.y + 20 * Inv.scale)
    end
end

function itemMenu:set()
    local row = math.ceil(self.itemSel / 5)
    local column = (self.itemSel - 1) % 5 + 1
    
    self.y = 10 + (row - 1) * 120
    -- local placeX = love.graphics.getWidth()/2 - 200 + (column - 1) * spaceBetween
    -- local placeY = love.graphics.getHeight()/2 - 120 + (row - 1) * 120

    local predictX = (16 * Inv.scale --[[ set to the starting position ]])
    + (14 * Inv.scale)
    + ((column - 1) * 25 * Inv.scale)

    if IsOutOfBounds(predictX, self.y, TexSize["ui/smallWindow.png"].w * Inv.scale, TexSize["ui/smallWindow.png"].h * Inv.scale) then
        predictX = predictX - 80 * Inv.scale
    end

    self.x = predictX

    -- properties:
    local prop = GetItemInfo(Char.inventory[self.itemSel + 5].id)
    prop.amount = Char.inventory[self.itemSel + 5].number
    self.properties = prop
end

return { itemMenu = itemMenu }