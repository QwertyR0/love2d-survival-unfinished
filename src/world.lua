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
            local chance = love.math.random(1, 12) 

            if World.grid[x][y] == 0 then
                print(World.grid[x][y])
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

function RenderObjects()
    for k, v in ipairs(World.objects) do
        if v.type == "tree" then
            love.graphics.draw(Tex["tree.png"], (v.x-1)*Scale*TileW, (v.y-2)*Scale*TileH, 0, Scale, Scale)
        end
    end
end