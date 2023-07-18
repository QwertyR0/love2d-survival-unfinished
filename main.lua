local camera
MapW, MapH, TileH, TileW = 30, 30, 16, 16
local mapRW, mapRH = MapW * TileW * Scale, MapH * TileH * Scale
local seed = nil

function love.load()
    require("src.helper.textures")
    require("src.player")
    require("src.world")
    require("src.ui.inGame")
    require("src.helper.spriteSheet")
    require("src.helper.animation")

    SpriteSheet:new("playerSheet.png", 16, 16, Scale)

    Camera = require("libs.hump.camera")
    
    Char = Player:new()
    
    Char.hp = 3
    
    camera = Camera.new(Char.x, Char.y)

    seed = 10000 * love.math.random()
    love.math.setRandomSeed(seed)
    GenWorld(seed)
end

function love.update(dt)
    camera:lookAt(Char.x, Char.y)

    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    if camera.x < w/2 then
        camera.x = w/2
    end

    if camera.y < h/2 then
        camera.y = h/2
    end

    if camera.x > (mapRW - w/2) then
        camera.x = (mapRW - w/2)
    end
    if camera.y > (mapRH - h/2) then
        camera.y = (mapRH - h/2)
    end

    PlayerUpdate(dt)
end

function love.draw()
    camera:attach()
        RenderWorld()
        PlayerRender()
        RenderObjects()
    camera:detach()

    UI.heart(Char.hp)
    UI.inv({1, 1, 1, 1})
    UI.info(seed)
end