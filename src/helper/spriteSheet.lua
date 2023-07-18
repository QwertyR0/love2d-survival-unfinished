SpriteSheet = {}
SpriteSheet.__index = {}

function SpriteSheet:new(imagePath, qw, qh, scale)
    self.currentFrame = 1
    self.image = Tex[imagePath]
    self.imageDimensions = TexSize[imagePath]
    self.imageData = TexData[imagePath]
    self.qw = qw
    self.qh = qh
    self.scale = scale or 1
    self.quads = {}

    local cols = self.imageDimensions.w / self.qw -- 3
    local rows = self.imageDimensions.h / self.qh -- 4

    for y = 1, rows do
        for x = 1, cols do
            local qframe = love.graphics.newQuad((x-1)*qw, (y-1)*qh, qw, qh, self.imageDimensions.w, self.imageDimensions.h)
            table.insert(self.quads, qframe)
        end
    end

    return self
end

function SpriteSheet:setFrame(frame)
    self.currentFrame = frame
end

function SpriteSheet:draw(x, y, rot, options)
    rot = rot or 0

    options = options or {
        ofx = 0,
        ofy = 0,
        scale = self.scale
    }

    love.graphics.draw(self.image, self.quads[self.currentFrame], x, y, rot, options.scale, options.scale, options.ofx, options.ofy)
end