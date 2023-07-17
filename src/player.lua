---@diagnostic disable: missing-parameter

local function playerAnimations(SS)
    local front = AnimationS:new(0.2, SS, {1, 2, 3})
    local back = AnimationS:new(0.2, SS, {4, 5, 6})
    local right = AnimationS:new(0.2, SS, {11, 10})
    local left = AnimationS:new(0.2, SS, {8, 7})

    front.name = "front"
    back.name = "back"
    right.name = "right"
    left.name = "left"

    return {
        front = front,
        back = back,
        right = right,
        left = left
    }
end

Player = {}
local PlayerConfig = {
    acceleration = 8,
    maxSpeed = 3,
    friction = 4.5
}
Player.__index = Player

function Player:new(x, y)
    self.x = x or 10
    self.y = y or 10
    self.velx = 0
    self.vely = 0
    self.currentAnimation = "front"
    self.__index = self

    self.empt = {
        LR = 8 -- NOTE: implement this crap before it's too late...
    }

    self.sheet = SpriteSheet:new("playerSheet.png", 16, 16, Scale)
    self.animations = playerAnimations(self.sheet)

    self.animations.front:play()

    return self
end

function Player:update(dt)
    if self.velx > 0 then
        if self.velx - PlayerConfig.friction*dt >= 0 then
            self.velx = self.velx - PlayerConfig.friction*dt
        else
            self.velx = 0
        end
    elseif self.velx < 0 then
        if self.velx + PlayerConfig.friction*dt <= 0 then
            self.velx = self.velx + PlayerConfig.friction*dt
        else
            self.velx = 0
        end
    end

    if self.vely > 0 then
        if self.vely - PlayerConfig.friction*dt >= 0 then
            self.vely = self.vely - PlayerConfig.friction*dt
        else
            self.vely = 0
        end
    elseif self.vely < 0 then
        if self.vely + PlayerConfig.friction*dt <= 0 then
            self.vely = self.vely + PlayerConfig.friction*dt
        else
            self.vely = 0
        end
    end

    self.x = self.x + self.velx
    self.y = self.y + self.vely
end

function Player:accelerate(axis, dir, dt)
    if axis == "x" then
        local newVel = self.velx + PlayerConfig.acceleration * dir * dt

        if dir > 0 then
            if not (newVel >= PlayerConfig.maxSpeed) then
                self.velx = newVel
            else
                self.velx = PlayerConfig.maxSpeed
            end
        elseif dir < 0 then
            if not (newVel <= -PlayerConfig.maxSpeed) then
                self.velx = newVel
            else
                self.velx = -PlayerConfig.maxSpeed
            end
        end
    elseif axis == "y" then
        local newVel = self.vely + PlayerConfig.acceleration * dir * dt

        if dir > 0 then
            if not (newVel >= PlayerConfig.maxSpeed) then
                self.vely = newVel
            else
                self.vely = PlayerConfig.maxSpeed
            end
        elseif dir < 0 then
            if not (newVel <= -PlayerConfig.maxSpeed) then
                self.vely = newVel
            else
                self.vely = -PlayerConfig.maxSpeed
            end
        end
    end
end

function PlayerUpdate(dt)
    if not (love.keyboard.isDown("w") or love.keyboard.isDown("a") or love.keyboard.isDown("d") or love.keyboard.isDown("s")) then
        Char.currentAnimation = "none"

        for k, v in pairs(Char.animations) do
            if v.isPlaying == true then
                v:stop()
            end
        end
    end

    if love.keyboard.isDown("w") then
        Char:accelerate("y", -1, dt)
        Char.currentAnimation = "back"
    end

    if love.keyboard.isDown("s") then
        Char:accelerate("y", 1, dt)
        Char.currentAnimation = "front"
    end

    if love.keyboard.isDown("a") then
        Char:accelerate("x", -1, dt)
        Char.currentAnimation = "left"
    end
    
    if love.keyboard.isDown("d") then
        Char:accelerate("x", 1, dt)
        Char.currentAnimation = "right"
    end
    
    for k, v in pairs(Char.animations) do
        if v.name == Char.currentAnimation then
            if v.isPlaying == false then
                v:play()
            end
        else
            if v.isPlaying == true then
                v:stop()
            end
        end
        
        v:update(dt)
    end
    
    local oldX = Char.x
    local oldY = Char.y

    Char:update(dt)

    if Char.x - 8*Scale + (Char.empt.LR /2)*Scale < 0 then
        Char.x = 8*Scale - (Char.empt.LR /2)*Scale
    elseif Char.x + 8*Scale - (Char.empt.LR /2)*Scale > 30*16*Scale then
        Char.x = 30*16*Scale - 8*Scale + (Char.empt.LR /2)*Scale
    end

    if Char.y - 8*Scale < 0 then
        Char.y = 8*Scale
    elseif Char.y + 8*Scale > 30*16*Scale then
        Char.y = 30*16*Scale - 8*Scale
    end
    
    print(math.floor((Char.x/Scale)/TileW), math.floor((Char.y/Scale)/TileH))
end

function PlayerRender()
    -- local charQuads = PlayerSheet()
    -- love.graphics.draw(Tex["playerSheet.png"], charQuads[Char.currentFrame], Char.x, Char.y, 0, Scale, Scale, 8, 8)

    Char.sheet:draw(Char.x, Char.y, 0, {scale = Scale, ofx = 8, ofy = 8})
end