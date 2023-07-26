Scale = 8 -- currently optimized to work in Scale of 8 so I don't suggest messing with this value

function love.conf(t)
    t.window.width = 64*Scale
    t.window.height = 64*Scale
end