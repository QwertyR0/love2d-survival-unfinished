Camera = nil
MapW, MapH, TileH, TileW = 50, 50, 16, 16
local mapRW, mapRH = MapW * TileW * Scale, MapH * TileH * Scale
local seed = nil
Inv = nil

function love.load()
    require("src.helper.textures")
    require("src.player")
    require("src.world")
    require("src.ui.inGame")
    require("src.helper.spriteSheet")
    require("src.helper.animation")
    require("src.helper.realHelper")
    require("src.ui.inventory")
    require("src.mouseHover")
    require("src.helper.buttons")
    require("src.animsToPlay")
    Cam = require("libs.camera")

    SpriteSheet:new("playerSheet.png", 16, 16, Scale)
    UI.InfoPrompt:init()

    Char = Player:new()
    Char.hp = 3

    Camera = Cam.new(Char.x, Char.y)

    seed = 10000 * love.math.random()
    love.math.setRandomSeed(seed)
    GenWorld(seed)

    local r = RandomPlayerPos()

    Char.x = r.x*Scale*TileW
    Char.y = r.y*Scale*TileH

    Inv = Inventory:new() -- create new inventory
    DynamicManager:init()
end

function love.update(dt)
    Camera:lookAt(Char.x, Char.y) -- follow player

    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    if Camera.x < w/2 then
        Camera.x = w/2
    end

    if Camera.y < h/2 then
        Camera.y = h/2
    end

    if Camera.x > (mapRW - w/2) then
        Camera.x = (mapRW - w/2)
    end
    if Camera.y > (mapRH - h/2) then
        Camera.y = (mapRH - h/2)
    end

    PlayerUpdate(dt)
    HoverUpdate()
    Inv:update()
    DynamicManager:update(dt)
end

function love.draw()
    Camera:attach()
        RenderWorld()
        RenderObjects2() -- Z value matters 😀
        HoverRender()
        PlayerRender()
        RenderObjects1()
        DynamicManager:render()
    Camera:detach()
    
    UI.heart(Char.hp)
    UI.inv(Inv) -- pass the bigger window for the smaller selection inventory
    Inv:draw()
    UI.info(seed) -- f1
    UI.InfoPrompt:render() -- interection indicator
end

function love.keypressed(key)
    if key == "f1" then
        ToggleInfo() -- info
    end

    Inv:keyPressed(key)
    
    if key == "e" then
        Pickup()
    end
end

function love.mousepressed(x, y, button, istouch)
    ButtonsClick(x, y, button, istouch)
    Inv:mousePressed(x, y, button)
end