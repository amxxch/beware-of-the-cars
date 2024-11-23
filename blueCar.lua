

local blueCar = {}
blueCar.__index = blueCar

local Player = require("player")

local ActiveblueCars = {}

function blueCar.new(x, y)
    local individual = setmetatable({}, blueCar)
    individual.x = x
    individual.y = y 
    individual.scale = -1
    individual.xVel = 170

    individual.img = love.graphics.newImage("assets/car_blue.png")
    individual.width = individual.img:getWidth() 
    individual.height = individual.img:getHeight()

    individual.physics = {}
    individual.physics.body = love.physics.newBody(World, individual.x, individual.y, "dynamic")
    individual.physics.body:setGravityScale(0) -- remove gravity
    individual.physics.shape = love.physics.newRectangleShape(individual.width, individual.height)
    individual.physics.body:setMass(individual.width / 2, individual.height / 2, 100)
    individual.physics.fixture = love.physics.newFixture(individual.physics.body, individual.physics.shape)
    individual.physics.fixture:setSensor(true)
    table.insert(ActiveblueCars, individual)
end


function blueCar:update(dt)
    self:syncPhysics()
    self:setBoundary()
end

function blueCar:remove()
    for i,individual in ipairs(ActiveblueCars) do
        if individual == self then -- if current individual is equal to self (the coin that called this function)
            self.physics.body:destroy()
            table.remove(ActiveblueCars, i) --remove the data with index i (index of the current individual) from the table
        end
    end
end

function blueCar.removeAll()
    for i,v in ipairs(ActiveblueCars) do
        v.physics.body:destroy()
    end

    ActiveblueCars = {}
end

function blueCar:setBoundary() -- to move infinitely
    if self.x > MapWidth then
        self.physics.body:setX(0)
    end
end

function blueCar:syncPhysics()
    self.x, self.y = self.physics.body:getPosition()
    self.physics.body:setLinearVelocity(self.xVel, 0)
end

function blueCar:updateAll(dt)
    for i,individual in ipairs(ActiveblueCars) do
        individual:update(dt) -- tell each blueCar to update themselves
    end
end


function blueCar:draw()
    local scaleX = self.scale
    if self.scale < 0 then
        scaleY = -self.scale
    else 
        scaleY = self.scale
    end
    love.graphics.draw(self.img, self.x, self.y, 0, scaleX, scaleY, self.width / 2, self.height / 2)

end

function blueCar:drawAll()
    for i,individual in ipairs(ActiveblueCars) do
        individual:draw()
    end
end

function blueCar.beginContact(a, b, collision)
    for i,individual in ipairs(ActiveblueCars) do
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

return blueCar