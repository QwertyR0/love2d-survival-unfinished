World = {
    grid = {},
    objects = {}
}

function GenWorld(seed)
    for x = 1, MapW do
        World.grid[x] = {}
        for y = 1, MapH do
            local gen = love.math.noise(x*0.1, y*0.1, seed)
            local ret = nil
           
            ret = 0
            
            if gen >= 0.6 then
                ret = 1
            end
            
            World.grid[x][y] = ret
        end
    end

    for x = 1, MapW do
        for y = 1, MapH do
            local chance = love.math.random(1, 5)

            if World.grid[x][y] == 0 then
                if World.grid[x][y-1] == 0 then
                    for k, v in ipairs(World.objects) do
                        if v.y == y-1 or v.y == y+1 then
                            chance = 2
                        end
                    end

                    if chance == 1 then
                        table.insert(World.objects, {x = x, y = y, type = "tree"})
                    end
                end
            end
        end
    end

    for x = 1, MapW do
        for y = 1, MapH do
            local chance = love.math.random(1, 8)

            if World.grid[x][y] == 0 then
                if World.grid[x][y-1] == 0 then
                    for k, v in ipairs(World.objects) do
                        if v.y == y+1 or (v.y == y and v.x == x) then
                            chance = 2
                        end
                    end

                    if chance == 1 then
                        table.insert(World.objects, {x = x, y = y, type = "rock"})
                    end
                end
            end
        end
    end
end

function RenderWorld()
    for x = 1, #World.grid do
        for y = 1, #World.grid[x] do
            if World.grid[x][y] == 0 then
                love.graphics.draw(Tex["tiles/grass.png"], (x - 1)*TileW*Scale, (y - 1)*TileH*Scale, 0, Scale, Scale)
            elseif World.grid[x][y] == 1 then
                love.graphics.draw(Tex["tiles/rock.png"], (x - 1)*TileW*Scale, (y - 1)*TileH*Scale, 0, Scale, Scale)
            end
        end
    end
end

function RenderObjects1() -- rendered before
    for k, v in ipairs(World.objects) do
        if v.type == "tree" then
            if CheckBoxCollision({x = Char.x-5*Scale, y = Char.y-8*Scale, width = 9*Scale, height = 16*Scale}, {x = (v.x-1)*Scale*TileW, y = (v.y-2)*Scale*TileH, width = 12*Scale, height = 16*Scale}) then
                love.graphics.setColor(1, 1, 1, 0.3)
            end

            love.graphics.draw(Tex["tree1.png"], (v.x-1)*Scale*TileW, (v.y-2)*Scale*TileH, 0, Scale, Scale)
            love.graphics.setColor(1, 1, 1, 1)
        elseif v.type == "rock" then
            love.graphics.draw(Tex["smallRock.png"], (v.x-1)*Scale*TileW, (v.y-1)*Scale*TileH, 0, Scale, Scale)
        end
    end
end

function RenderObjects2() -- rendered after
    for k, v in ipairs(World.objects) do
        if v.type == "tree" then
            love.graphics.draw(Tex["tree2.png"], (v.x-1)*Scale*TileW, (v.y-1)*Scale*TileH, 0, Scale, Scale)
        end
    end 
end

function RandomPlayerPos()
    local spawnables = {}

    for x = 1, #World.grid do
        for y = 1, #World.grid[x] do
            if World.grid[x][y] == 0 then
                for k, v in ipairs(World.objects) do
                    if not (v.x == x and v.y == y) then
                        if not (v.x == x and v.y-1 == y) then
                            table.insert(spawnables, { x = x, y = y })
                        end
                    end
                end
            end
        end
    end

    return spawnables[math.random(1, #spawnables)]
end