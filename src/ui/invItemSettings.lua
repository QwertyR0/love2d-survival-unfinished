--[[    DISCLAIMER:

        THIS UI CODE IS HOLD WITH DUCKTAPE AND CARDBOARD
        DON'T BE MAD I WAS TIRED
        I ALSO DISPISE THIS CODE
        Sorry about that
]]

local itemMenu = {}
itemMenu.__index = itemMenu

local function semiClick(x, y, button, isTouch, id)
    -- drop:
    if id == "drop" then
        local actionItem = Char.inventory[Inv.smallWindow.itemSel + 5]
        if actionItem.number <= 1 then
            table.remove(Char.inventory, Inv.smallWindow.itemSel + 5)
        else
            Char.inventory[Inv.smallWindow.itemSel + 5].number = actionItem.number - 1
        end
        Inv.smallWindow.enabled = false

    -- eat:
    elseif id == "eat" and Inv.smallWindow.properties.eat.eatable then
        
    -- set:
    elseif id == "set" then
        Inv.smallWindow.state = 1
    end
end

function itemMenu:new()
    self.enabled = false
    self.state = 0 -- if 0 menu, if 1 setting place
    self.properties = {}
    self.itemSel = 0
    self.x = love.graphics.getWidth() -- hide the mess just in case...
    self.y = love.graphics.getHeight()
    self.buttons = {
        left = Button:new("rectangle", self.x, self.y, 12 * InvScale, 10 * InvScale, 1, semiClick, "drop"),
        mid = Button:new("rectangle", self.x, self.y, 12 * InvScale, 10 * InvScale, 1, semiClick, "drop"),
        right = Button:new("rectangle", self.x, self.y, 12 * InvScale, 10 * InvScale, 1, semiClick, "eat"),
        set = Button:new("rectangle", self.x, self.y, 28 * InvScale, 10 * InvScale, 1, semiClick, "set")
    }
    self.__index = self

    return self
end

function itemMenu:render()
    if self.enabled then
        -- window itself:
        love.graphics.draw(Tex["ui/smallWindow.png"], self.x, self.y, 0, InvScale, InvScale)
        
        if self.state == 0 then
            love.graphics.setFont(Fonts.medium)
            local idX = self.x + TexSize["ui/smallWindow.png"].hw * InvScale - Fonts.medium:getWidth(self.properties.id) / 2
            love.graphics.print(self.properties.id, idX, self.y + 8 * InvScale)

            -- set button:
            local sTextX = self.buttons.set.x + TexSize["ui/wideButton.png"].hw * InvScale - Fonts.tiny:getWidth("Set Place") / 2
            local sTextY = self.buttons.set.y + TexSize["ui/wideButton.png"].hh * InvScale - Fonts.tiny:getHeight() / 2
            love.graphics.draw(Tex["ui/wideButton.png"], self.buttons.set.x, self.buttons.set.y, 0, InvScale, InvScale)
            love.graphics.setFont(Fonts.tiny)
            love.graphics.print("Set Place", sTextX, sTextY)

            -- amount text:
            local aText = ("Amount: " .. tostring(self.properties.amount).. "/" .. tostring(self.properties.max))
            local adX = (self.x + TexSize["ui/smallWindow.png"].hw * InvScale - Fonts.small:getWidth(aText) / 2) - 6 * InvScale
            love.graphics.setFont(Fonts.small)
            love.graphics.print(aText, adX, self.y + 20 * InvScale)

            --other 2 buttons:
            if self.properties.eat.eatable then
                love.graphics.draw(Tex["ui/eat.png"], self.buttons.right.x, self.buttons.right.y, 0, InvScale, InvScale)
                love.graphics.draw(Tex["ui/drop.png"], self.buttons.left.x, self.buttons.left.y, 0, InvScale, InvScale)
            else
                love.graphics.draw(Tex["ui/drop.png"], self.buttons.mid.x, self.buttons.mid.y, 0, InvScale, InvScale)
            end
        elseif self.state == 1 then
            love.graphics.setFont(Fonts.small)
            local textW = Fonts.small:getWrap("Please Press Press a Number From 1 to 5", 120)
            local tX, tY = self.x + TexSize["ui/smallWindow.png"].hw * InvScale - textW / 2, self.y + TexSize["ui/smallWindow.png"].hh * InvScale - 20 * InvScale
            love.graphics.printf("Please Press Press a Number From 1 to 5", tX, tY, 120, "center")
        end
    end
end

function itemMenu:set()
    local row = math.ceil(self.itemSel / 5)
    local column = (self.itemSel - 1) % 5 + 1
    
    self.y = 10 + (row - 1) * 120
    -- local placeX = love.graphics.getWidth()/2 - 200 + (column - 1) * spaceBetween
    -- local placeY = love.graphics.getHeight()/2 - 120 + (row - 1) * 120

    local predictX = (16 * InvScale --[[ set to the starting position ]])
    + (14 * InvScale)
    + ((column - 1) * 25 * InvScale)

    if IsOutOfBounds(predictX, self.y, TexSize["ui/smallWindow.png"].w * InvScale, TexSize["ui/smallWindow.png"].h * InvScale) then
        predictX = predictX - 80 * InvScale
    end

    self.x = predictX

    -- properties:
    local prop = GetItemInfo(Char.inventory[self.itemSel + 5].id)
    prop.amount = Char.inventory[self.itemSel + 5].number
    self.properties = prop
    self.properties.place = self.itemSel + 5 -- might remove this stupid method as there 
                                             -- will be one instance of every item.
    -- buttons:
    self.buttons.set.x = self.x + TexSize["ui/smallWindow.png"].hw * InvScale - TexSize["ui/wideButton.png"].hw * InvScale
    self.buttons.set.y = self.y + TexSize["ui/smallWindow.png"].h*InvScale - 20 * InvScale
    
    local sY = self.y + TexSize["ui/smallWindow.png"].h*InvScale - 33 * InvScale
    self.buttons.left.y = sY
    self.buttons.right.y = sY
    self.buttons.mid.y = sY
    if self.properties.eat.eatable then
        self.buttons.left.x = self.x + TexSize["ui/smallWindow.png"].hw * InvScale / 2 - TexSize["ui/eat.png"].hw * InvScale
        self.buttons.right.x = self.x + (TexSize["ui/smallWindow.png"].hw/2 * 3) * InvScale - TexSize["ui/eat.png"].hw * InvScale
    else
        self.buttons.mid.x = self.x + TexSize["ui/smallWindow.png"].hw * InvScale - TexSize["ui/eat.png"].hw * InvScale
    end
end

function itemMenu:keypress(key)
    if IsInteger(key) and self.state == 1 then
        key = tonumber(key)
        if key <= 5 and key >= 1 then
            RelocateElems(Char.inventory, self.properties.place, key)
            self.state = 0
            self.enabled = false
        end
    end
end

return { itemMenu = itemMenu }