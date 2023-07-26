local itemMenu = {}
itemMenu.__index = itemMenu

function itemMenu:new()
    self.enabled = false
    self.properties = {}
    self.itemSel = 0
    self.x = 0
    self.y = 0

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
    if not (x >= self.x and x <= self.x+TexSize["ui/smallWindow.png"].w*self.scale and y >= self.y and y <= self.y+TexSize["ui/smallWindow.png"].h*self.scale) then
        if Inv.enable and self.enabled then
            self.enabled = false
        end
    end
end

function itemMenu:setPos(x, y)
    self.x = x + 2 * Inv.scale
    self.y = y
end

return { itemMenu = itemMenu }