--[[    DISCLAIMER:

        THIS UI CODE IS HOLD WITH DUCkTAPE AND CARDBOARD
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

function itemMenu:update()
end

function itemMenu:render()
    if self.enabled then
        love.graphics.draw(Tex["ui/smallWindow.png"], self.x, self.y, 0, Inv.scale, Inv.scale)
    end
end

function itemMenu:clicked(x, y, button)
    -- if not (x >= self.x and x <= self.x+TexSize["ui/smallWindow.png"].w*Inv.scale and y >= self.y and y <= self.y+TexSize["ui/smallWindow.png"].h*Inv.scale) then
    --     if Inv.enable and self.enabled and button == 1 then
    --         -- self.enabled = false
    --     end
    -- end
end

function itemMenu:setPos()
    local row = math.ceil(self.itemSel / 5)
    local column = (self.itemSel - 1) % 5 + 1
    
    self.y = 10 + (row - 1) * 120
    -- local placeX = love.graphics.getWidth()/2 - 200 + (column - 1) * spaceBetween
    -- local placeY = love.graphics.getHeight()/2 - 120 + (row - 1) * 120

    local predictX = (16 * Inv.scale --[[ set to the starting position ]])
    + (14 * Inv.scale)
    + ((column - 1) * 25 * Inv.scale)

    if IsOutOfBounds(predictX, self.y, TexSize["ui/smallWindow.png"].w, TexSize["ui/smallWindow.png"].h) then
        predictX = predictX - 80 * Inv.scale
    end

    self.x = predictX
end

return { itemMenu = itemMenu }