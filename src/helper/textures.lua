-- Code by Blendi Goose

Tex = {}
TexSize = {}
TexData = {}
love.graphics.setDefaultFilter("nearest", "nearest")

function ScanTextures(basepath,currentpath)
    currentpath = currentpath or basepath
    for i,v in ipairs(love.filesystem.getDirectoryItems(currentpath)) do
        local filepath = currentpath .. "/" .. v

        if love.filesystem.getInfo(filepath,"directory") then
            ScanTextures(basepath,filepath)
        else
            local tex = love.graphics.newImage(filepath)
            local texd = love.image.newImageData(filepath)
            if filepath:sub(1,#basepath+1) == basepath .. "/" then
                filepath = filepath:sub(#basepath+2)
            end
            Tex[filepath] = tex
            TexSize[filepath] = {w = tex:getWidth(), h = tex:getHeight(), hw = tex:getWidth()/2, hh = tex:getHeight()/2}
            TexData[filepath] = texd
        end
    end
end

ScanTextures("textures")