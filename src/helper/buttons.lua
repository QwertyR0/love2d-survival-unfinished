Button = {}
Button.__index = Button
Buttons = {}

function Button:new(type, x, y, width, height, scale, onClick, id, onNotClick)
    local o = {}

    o.onClick = onClick -- "If it works it works I know this is stupid but it just works and I won't touch this"
    o.type = type
    o.x = x
    o.y = y
    o.scale = scale
    o.width = width -- use this as radius if type == "circle"
    o.height = height
    o.id = id --trying to address the stupidness with id's
    o.onNotClick = onNotClick or nil -- got nothing better lmao

    setmetatable(o, Button)

    table.insert(Buttons, o)
    return o
end

function ButtonsClick(x, y, button, istouch)
    for i = 1, #Buttons do
        if Buttons[i].type == "rectangle" then
            if x >= Buttons[i].x and x <= Buttons[i].x+Buttons[i].width and y >= Buttons[i].y and y <= Buttons[i].y+Buttons[i].height then
                Buttons[i].onClick(x, y, button, istouch, Buttons[i].id)
            else
                if Buttons[i].onNotClick then
                    Buttons[i].onNotClick(x, y, button, istouch, Buttons[i].id)
                end
            end
        elseif Buttons[i].type == "circle" then
            if math.sqrt((Buttons[i].x-x+Buttons[i].width)^2+(Buttons[i].y-y+Buttons[i].width)^2) <= Buttons[i].width then
                Buttons[i].onClick(x, y, button, istouch, Buttons[i].id)
            else
                if Buttons[i].onNotClick then
                    Buttons[i].onNotClick(x, y, button, istouch, Buttons[i].id)
                end
            end
        end
    end
end