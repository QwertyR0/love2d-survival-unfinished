local spaceBetween = 10
local uiScale = 5
local invScale = 4
local info = false

UI = {}

function UI.init()
end

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

    love.graphics.draw(Tex["ui/inv.png"], love.graphics.getWidth()/2-TexSize["ui/inv.png"].w*invScale/2, love.graphics.getHeight()-TexSize["ui/inv.png"].h*invScale-10, 0, invScale, invScale)

    for i = 1, 5 do
        local preX = love.graphics.getWidth()/2-TexSize["ui/inv.png"].w*invScale/2+16
        local preY = love.graphics.getHeight()-TexSize["ui/inv.png"].h*invScale+6
        
        if Char.inventory[i] then
            if Char.inventory[i].id == "apple" then
                love.graphics.draw(Tex["items/apple.png"], preX + (i - 1) * 56, preY, 0, invScale, invScale)
            elseif Char.inventory[i].id == "bread" then
                love.graphics.draw(Tex["items/bread.png"], preX + (i - 1) * 56 - invScale, preY - invScale, 0, invScale, invScale)
            elseif Char.inventory[i].id == "apple" then
                love.graphics.draw(Tex["items/apple.png"], preX + (i - 1) * 56, preY, 0, invScale, invScale)
            elseif Char.inventory[i].id == "apple" then
                love.graphics.draw(Tex["items/apple.png"], preX + (i - 1) * 56, preY, 0, invScale, invScale)
            end
        end

        if inv.selected ~= i then
            love.graphics.setColor(0, 0, 0, 0.4)
            love.graphics.rectangle("fill", preX + (i - 1) * 56 - invScale, preY - invScale, 13*invScale, 13*invScale)
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

function ToggleInfo()
    info = not(info)
end