local spaceBetween = 10
local uiScale = 5
local invScale = 4
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

function UI.inv(invFrontArr)

    love.graphics.draw(Tex["ui/inv.png"], love.graphics.getWidth()/2-TexSize["ui/inv.png"].w*invScale/2, love.graphics.getHeight()-TexSize["ui/inv.png"].h*invScale-10, 0, invScale, invScale)

    for i = 1, #invFrontArr do
        if invFrontArr[i] == 1 then
            local preX = love.graphics.getWidth()/2-TexSize["ui/inv.png"].w*invScale/2+16
            local preY = love.graphics.getHeight()-TexSize["ui/inv.png"].h*invScale+7
            love.graphics.draw(Tex["ui/heartF.png"], preX + (i - 1) * 56, preY, 0, invScale, invScale)
        end
    end
end

function UI.info(seed)
    if info then
        love.graphics.print("Seed:", love.graphics.getWidth()-195, 17, 0, 1.5, 1.5)
        love.graphics.print(tostring(seed), love.graphics.getWidth()-140, 17, 0, 1, 1)
    end
end

function ToggleInfo()
    info = not(info)
end