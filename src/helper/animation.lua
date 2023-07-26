-- the "S" stands for (sprite)sheet

AnimationS = {}
AnimationS.__index = AnimationS

function AnimationS:new(delay, instance, animSeq)
    self = setmetatable({}, AnimationS)
    
    self.instance = instance
    self.delay = delay
    self.animSeq = animSeq or nil
    self.currentFrame = 1
    self.isPlaying = false
    self.elapsedTime = 0
    self.animIndex = 1

    return self
end

function AnimationS:update(dt)
    if self.isPlaying == true then
        self.elapsedTime = self.elapsedTime + dt

        if self.elapsedTime >= self.delay then
            -- if animation sequence is provided:
            if self.animSeq ~= nil then
                self.animIndex = self.animIndex + 1

                if self.animIndex > #self.animSeq then
                    self.animIndex = 1
                end

                self.currentFrame = self.animSeq[self.animIndex]
            else -- else progress through normally
                self.currentFrame = self.currentFrame + 1

                if self.currentFrame >= #self.instance.quads then
                    self.currentFrame = 1
                end
            end

            self.elapsedTime = 0
        end

        self.instance:setFrame(self.currentFrame)
    end
end

function AnimationS:play()
    self.isPlaying = true
end

function AnimationS:stop()
    self.isPlaying = false
    self.currentFrame = 1
    if self.animSeq ~= nil then
        self.currentFrame = self.animSeq[1]
    end
    self.instance:setFrame(self.currentFrame)
    self.elapsedTime = 0
    self.animIndex = 1
end

function AnimationS:pause()
    self.isPlaying = false
end