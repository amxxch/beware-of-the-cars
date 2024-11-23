

local navyCar = {}
navyCar.__index = navyCar

local Player = require("player")

local ActivenavyCars = {}

function navyCar.new(x, y)
    local individual = setmetatable({}, navyCar)
    individual.x = x
    individual.y = y
    individual.scale = 1
    individual.xVel = -600

    individual.img = love.graphics.newImage("assets/car_navy.png")
    individual.width = individual.img:getWidth()
    individual.height = individual.img:getHeight()

    individual.physics = {}
    individual.physics.body = love.physics.newBody(World, individual.x, individual.y, "dynamic")
    individual.physics.body:setGravityScale(0) -- remove gravity
    individual.physics.shape = love.physics.newRectangleShape(individual.width, individual.height)
    individual.physics.fixture = love.physics.newFixture(individual.physics.body, individual.physics.shape)
    individual.physics.fixture:setSensor(true)
    table.insert(ActivenavyCars, individual)
end

function navyCar:update(dt)
    self:syncPhysics()
    self:setBoundary()
end

function navyCar:remove()
    for i,individual in ipairs(ActivenavyCars) do
        if individual == self then -- if current individual is equal to self (the coin that called this function)
            self.physics.body:destroy()
            table.remove(ActivenavyCars, i) --remove the data with index i (index of the current individual) from the table
        end
    end
end

function navyCar.removeAll()
    for i,v in ipairs(ActivenavyCars) do
        v.physics.body:destroy()
    end

    ActivenavyCars = {}
end

function navyCar:syncPhysics()
    self.x, self.y = self.physics.body:getPosition()
    self.physics.body:setLinearVelocity(self.xVel, 0)
end

function navyCar:setBoundary() -- to move infinitely
    if self.x < 0 then
        self.physics.body:setX(MapWidth)
    end
end

function navyCar:updateAll(dt)
    for i,individual in ipairs(ActivenavyCars) do
        individual:update(dt) -- tell each navyCar to update themselves
    end
end


function navyCar:draw()
    local scaleX = self.scale
    if self.scale < 0 then
        scaleY = -self.scale
    else 
        scaleY = self.scale
    end
    love.graphics.draw(self.img, self.x, self.y, 0, scaleX, scaleY, self.width / 2, self.height / 2)

end

function navyCar:drawAll()
    for i,individual in ipairs(ActivenavyCars) do
        individual:draw()
    end
end

function navyCar.beginContact(a, b, collision)
    for i,individual in ipairs(ActivenavyCars) do
        local nx, ny = collision:getNormal() -- get normal vector to check the direction of collision
        if a == Player.physics.fixture or b == Player.physics.fixture then
            if a == individual.physics.fixture or b == individual.physics.fixture then
                if nx < 0 or nx > 0 then
                    Player:getHit()
                end
            end
        end
    end
end

return navyCar