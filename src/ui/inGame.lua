local spaceBetween = 10
local uiScale = 5
local barScale = 4
local info = false

UI = {}

function UI.heart(charHealth)
    if charHealth >= 1 then
        love.graphics.draw(Tex["ui/heartF.png"], 3, 5, 0, uiScale, uiScale)
    else
        love.graphics.draw(Tex["ui/heartE.png"], 3, 5, 0, uiScale, uiScale)
    end

    if charHealth >= 2 then
        love.graphics.draw(Tex["ui/heartF.png"], (3 + 8*uiScale + spaceBetween), 5, 0, uiScale, uiScale)
    else
        love.graphics.draw(Tex["ui/heartE.png"], (3 + 8*uiScale + spaceBetween), 5, 0, uiScale, uiScale)
    end

    if charHealth >= 3 then
        love.graphics.draw(Tex["ui/heartF.png"], (3 + 8*uiScale*2 + spaceBetween*2), 5, 0, uiScale, uiScale)
    else
        love.graphics.draw(Tex["ui/heartE.png"], (3 + 8*uiScale*2 + spaceBetween*2), 5, 0, uiScale, uiScale)
    end
end

function UI.inv(inv)

    love.graphics.draw(Tex["ui/inv.png"], love.graphics.getWidth()/2-TexSize["ui/inv.png"].w*barScale/2, love.graphics.getHeight()-TexSize["ui/inv.png"].h*barScale-10, 0, barScale, barScale)

    for i = 1, 5 do
        local preX = love.graphics.getWidth()/2-TexSize["ui/inv.png"].w*barScale/2+16
        local preY = love.graphics.getHeight()-TexSize["ui/inv.png"].h*barScale+6
        
        if Char.inventory[i] then
            if Char.inventory[i].id == "apple" then
                love.graphics.draw(Tex["items/apple.png"], preX + (i - 1) * 56, preY, 0, barScale, barScale)
            elseif Char.inventory[i].id == "bread" then
                love.graphics.draw(Tex["items/bread.png"], preX + (i - 1) * 56 - barScale, preY - barScale, 0, barScale, barScale)
            elseif Char.inventory[i].id == "rock" then
                love.graphics.draw(Tex["items/rock.png"], preX + (i - 1) * 56, preY, 0, barScale, barScale)
            elseif Char.inventory[i].id == "apple" then
                love.graphics.draw(Tex["items/apple.png"], preX + (i - 1) * 56, preY, 0, barScale, barScale)
            end
        end

        if inv.selected ~= i then
            love.graphics.setColor(0, 0, 0, 0.4)
            love.graphics.rectangle("fill", preX + (i - 1) * 56 - barScale, preY - barScale, 13*barScale, 13*barScale)
            love.graphics.setColor(1,1,1,1)
        end
    end
end

function UI.info(seed)
    if info then
        love.graphics.setFont(Fonts.default)

        love.graphics.print("Seed:", love.graphics.getWidth() - 195, 17, 0, 1.5, 1.5)
        love.graphics.print(tostring(seed), love.graphics.getWidth() - 140, 17, 0, 1, 1)
        love.graphics.print("X:", love.graphics.getWidth() - 195, 37, 0, 1.5, 1.5)
        love.graphics.print(tostring(Char.x / Scale), love.graphics.getWidth() - 140, 39, 0, 1, 1)
        love.graphics.print("Y:", love.graphics.getWidth() - 195, 50, 0, 1.5, 1.5)
        love.graphics.print(tostring(Char.y / Scale), love.graphics.getWidth() - 140, 55, 0, 1, 1)
    end
end

local infoPrompt = {}
infoPrompt.__index = infoPrompt

function infoPrompt:init()
    self.enabled = false
    self.text = ""
    self.font = Fonts.small
    self.__index = self
end

function infoPrompt:render()
    if self.enabled then
        love.graphics.setFont(self.font)
        
        local tX, tY = love.graphics.getWidth() / 2 - self.font:getWidth(self.text) / 2, love.graphics.getHeight() - 120
        love.graphics.print(self.text, tX, tY)
    end
end

UI.InfoPrompt = infoPrompt

function ToggleInfo()
    info = not(info)
end