
local truckCar = {}
truckCar.__index = truckCar

local Player = require("player")

local ActivetruckCars = {}

function truckCar.new(x, y)
    local individual = setmetatable({}, truckCar)
    individual.x = x
    individual.y = y 
    individual.scale = -1
    individual.xVel = 250

    individual.img = love.graphics.newImage("assets/car_truck.png")
    individual.width = individual.img:getWidth()
    individual.height = individual.img:getHeight()

    individual.physics = {}
    individual.physics.body = love.physics.newBody(World, individual.x, individual.y, "dynamic")
    individual.physics.body:setGravityScale(0) -- remove gravity
    individual.physics.shape = love.physics.newRectangleShape(individual.width, individual.height)
    individual.physics.body:setMass(individual.width / 2, individual.height / 2, 100)
    individual.physics.fixture = love.physics.newFixture(individual.physics.body, individual.physics.shape)
    individual.physics.fixture:setSensor(true)
    table.insert(ActivetruckCars, individual)
end


function truckCar:update(dt)
    self:syncPhysics()
    self:setBoundary()
end

function truckCar:remove()
    for i,individual in ipairs(ActivetruckCars) do
        if individual == self then -- if current individual is equal to self (the coin that called this function)
            self.physics.body:destroy()
            table.remove(ActivetruckCars, i) --remove the data with index i (index of the current individual) from the table
        end
    end
end

function truckCar.removeAll()
    for i,v in ipairs(ActivetruckCars) do
        v.physics.body:destroy()
    end

    ActivetruckCars = {}
end

function truckCar:setBoundary() -- to move infinitely
    if self.x > MapWidth then
        self.physics.body:setX(0)
    end
end

function truckCar:syncPhysics()
    self.x, self.y = self.physics.body:getPosition()
    self.physics.body:setLinearVelocity(self.xVel, 0)
end

function truckCar:updateAll(dt)
    for i,individual in ipairs(ActivetruckCars) do
        individual:update(dt) -- tell each truckCar to update themselves
    end
end


function truckCar:draw()
    local scaleX = self.scale
    if self.scale < 0 then
        scaleY = -self.scale
    else 
        scaleY = self.scale
    end
    love.graphics.draw(self.img, self.x, self.y, 0, scaleX, scaleY, self.width / 2, self.height / 2)

end

function truckCar:drawAll()
    for i,individual in ipairs(ActivetruckCars) do
        individual:draw()
    end
end

function truckCar.beginContact(a, b, collision)
    for i,individual in ipairs(ActivetruckCars) do
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

return truckCar