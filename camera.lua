
local Camera = {}

function Camera:load()
    self.x = 0
    self.y = 0
end

function Camera:set()
    love.graphics.push()
    love.graphics.scale(2, 2)
    love.graphics.translate(-self.x, -self.y)
end

function Camera:unset()
    love.graphics.pop()
end

function Camera:position(x, y)
    self.x = x
    self.y = y - love.graphics.getHeight() / 2 / 2 -- / scale

    if self.y < 0 then
        self.y = 0
    elseif self.y + love.graphics.getHeight() / 2 > MapHeight then
        self.y = MapHeight - love.graphics.getHeight() / 2
    end
end

return Camera