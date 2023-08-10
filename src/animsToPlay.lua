Dynamic = {}
Dynamic.__index = Dynamic

function Dynamic:init(type, x, y, scale, duration, f, id)
    id = id or 0
    self.id = id
    self.f = f
    self.type = GetItemInfo(type)
    self.scale = scale
    self.duration = duration
    self.currentTime = 0
    self.x = x
    self.y = y
    self.ix = x
    self.iy = y
    self.tx = 0
    self.ty = 0
    self.__index = self

    return self
end

function Dynamic:setTarget(x, y)
    self.tx = x
    self.ty = y
end

DynamicManager = {}
DynamicManager.__index = DynamicManager

function DynamicManager:init()
    self.dynamics = {}
    self.__index = self

    return self
end

function DynamicManager:update(dt)
    for k, v in ipairs(self.dynamics) do
        v:setTarget(Char.x - 0.5 * Scale * TileW, Char.y - 0.5 * Scale * TileH)
        v.currentTime = v.currentTime + dt

        if v.currentTime < v.duration then
            local t = v.currentTime / v.duration
            local easedT = EaseOutExpo(t)
            v.x = v.ix + (v.tx - v.ix) * easedT
            v.y = v.iy + (v.ty - v.iy) * easedT
            print(v.x, v.y, Char.x, Char.y)
        else
            v.x = v.tx
            v.y = v.ty
-- 
            if v.f ~= nil then
                v.f(v.id)
                print("fin")
            end

            table.remove(self.dynamics, k)
        end

    end
end

function DynamicManager:render()
    for _, v in ipairs(self.dynamics) do
        love.graphics.draw(Tex[v.type.TexPath], v.x, v.y, 0, v.scale, v.scale)
    end
end

function DynamicManager:add(dyn)
    self.dynamics[#self.dynamics+1] = dyn
    return #self.dynamics
end