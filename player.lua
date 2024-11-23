local Player = {}

function Player:load()
    self:loadAssets()
    self.x = love.graphics.getWidth() / 4
    self.y = MapHeight - 40
    self.startX = self.x
    self.startY = self.y
    self.width = self.animation.width
    self.height = self.animation.height
    self.xVel = 0
    self.yVel = 0
    self.speed = 150
    self.acceleration = 10000
    self.friction = 5000
    self.heart = {current = 10, max = 10}
    self.isAlive = true
    self.success = false

    self.time = 0
    self.currentTime = 0
    self.winTime = 0

    self.color = {
        red = 1,
        blue = 1,
        green = 1,
        speed = 3
    }
    
    self.direction = "down"
    self.state = "idle"

    self.physics = {}
    self.physics.body = love.physics.newBody(World, self.x, self.y, "dynamic") --keep track of the player (where it is, where it is going)
    self.physics.body:setFixedRotation(true) -- no rotation
    self.physics.body:setGravityScale(0) -- remove gravity
    self.physics.shape = love.physics.newRectangleShape(self.width, self.height) --define the shape of the physical body
    self.physics.body:setMass(self.width / 2, self.height / 2, 25)
    self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape) --connect physical body and shape
end 

function Player:loadAssets() --make the animation of the player while moving
    self.animation = {timer = 0, rate = 0.1}

    self.animation.idle = {img = "assets/character_down2.png"}

    self.animation.up = {total = 3, current = 1, img = {}}
    for i=1, self.animation.up.total do
        self.animation.up.img[i] = love.graphics.newImage("assets/character_up"..i..".png")
    end

    self.animation.down = {total = 3, current = 1, img = {}}
    for i=1, self.animation.down.total do
        self.animation.down.img[i] = love.graphics.newImage("assets/character_down"..i..".png")
    end

    self.animation.left = {total = 3, current = 1, img = {}}
    for i=1, self.animation.left.total do
        self.animation.left.img[i] = love.graphics.newImage("assets/character_left"..i..".png")
    end

    self.animation.right = {total = 3, current = 1, img = {}}
    for i=1, self.animation.right.total do
        self.animation.right.img[i] = love.graphics.newImage("assets/character_right"..i..".png")
    end

    self.animation.draw = self.animation.down.img[2]
    self.animation.width = self.animation.draw:getWidth() 
    self.animation.height = self.animation.draw:getHeight()
end

function Player:update(dt)
    if self.isAlive == true then
        self:syncPhysics()
        self:animate(dt)
        self:setNormalColor(dt)
        self:setState()
        self:setBoundary(dt)
        self:move(dt)
        self:win(dt)
        self:setWinBoundary(dt)
        self:countTime(dt)
    end
end

function Player:countTime(dt)
    if currentScreen == "playing" then
        self.time = self.time + dt
        if self.time >= 1 then
            self.time = 0
            self.currentTime = self.currentTime + 1
        end
    end
end

function Player:win(dt)
    if self.y < 180 then
        currentScreen = "win"
        self.winTime = self.currentTime
    end
end

function Player:setWinBoundary(dt)
    if currentScreen == "win" then
        if self.y > 270 then
            self.physics.body:setY(270)
            self:setFriction(dt)
        end
    end
end

function Player:die()
    self.isAlive = false --die
    self.heart.current = 0
    currentScreen = "die"
    self.physics.body:destroy()
end

function Player:getHit()
    self.color.blue = 0
    self.color.green = 0

    self.heart.current = self.heart.current - 1
    if self.heart.current < 1 then
        self:die()
    end
end

function Player:setNormalColor(dt)
    if self.color.blue < 1 then
        self.color.blue = self.color.blue + self.color.speed * dt
    else
        self.color.blue = 1
    end

    if self.color.green < 1 then
        self.color.green = self.color.green + self.color.speed * dt
    else
        self.color.green = 1
    end
end

function Player:setBoundary(dt)
    if self.x < 10 then
        self.physics.body:setX(10)
        self:setFriction(dt)
    elseif self.x > MapWidth - 10 then
        self.physics.body:setX(MapWidth - 10)
        self:setFriction(dt)
    end

    if self.y > MapHeight - 15 then
        self.physics.body:setY(MapHeight - 15)
        self:setFriction(dt)
    elseif self.y < 15 then
        self.physics.body:setY(15)
        self:setFriction(dt)
    end
end

function Player:animate(dt)
    if self.state == "idle" then return true
    else
        self.animation.timer = self.animation.timer + dt -- to acknowledge the amount of time passed by
        if self.animation.timer > self.animation.rate then --if time passed = rate then we will set the new frame
            self.animation.timer = 0
            self:setNewFrame()
        end
    end
end

function Player:setNewFrame()
    local anim = self.animation[self.state]
    if anim.current < anim.total then --run each frame respectively
        anim.current = anim.current + 1
    else
        anim.current = 1
    end
    self.animation.draw = anim.img[anim.current]
end

function Player:setState() -- based on player's moving
    if self.xVel == 0 and self.yVel == 0 then
        self.state = "idle"
    elseif self.xVel > 0 then
        self.state = "right"
    elseif self.xVel < 0 then
        self.state = "left"
    elseif self.yVel > 0 then
        self.state = "down"
    elseif self.yVel < 0 then
        self.state = "up"
    end
end

function Player:move(dt)
    if love.keyboard.isDown("d", "right") then
        self.xVel = self.xVel + self.acceleration * dt
        if self.xVel + self.acceleration * dt > self.speed then
            self.xVel = self.speed
        end
    elseif love.keyboard.isDown("a", "left") then
        self.xVel = self.xVel - self.acceleration * dt
        if self.xVel - self.acceleration * dt < -self.speed then
            self.xVel = -self.speed
        end
    elseif love.keyboard.isDown("w", "up") then
        self.yVel = self.yVel - self.acceleration * dt
        if self.yVel - self.acceleration * dt < -self.speed then
            self.yVel = -self.speed
        end
    elseif love.keyboard.isDown("s", "down") then
        self.yVel = self.yVel + self.acceleration * dt
        if self.yVel + self.acceleration * dt > self.speed then
            self.yVel = self.speed
        end
    else
        self:setFriction(dt)
    end
end

function Player:setFriction(dt)
    if self.xVel > 0 then
        self.xVel = self.xVel - self.friction * dt
        if self.xVel < 0 then
            self.xVel = 0
        end
    elseif self.xVel < 0 then
        self.xVel = self.xVel + self.friction * dt
        if self.xVel > 0 then
            self.xVel = 0
        end
    end

    if self.yVel > 0 then 
        self.yVel = self.yVel - self.friction * dt
        if self.yVel < 0 then
            self.yVel = 0
        end
    elseif self.yVel < 0 then
        self.yVel = self.yVel + self.friction * dt
        if self.yVel > 0 then
            self.yVel = 0
        end
    end
end

function Player:syncPhysics() --synchronize physical body to x and y position
    self.x, self.y = self.physics.body:getPosition()
    self.physics.body:setLinearVelocity(self.xVel, self.yVel)
end

function Player:draw()
    if self.isAlive == true then
        love.graphics.setColor(self.color.red, self.color.green, self.color.blue) -- in case getRed()
        love.graphics.draw(self.animation.draw, self.x, self.y, 0, 1.3, 1.3, self.animation.width / 2, self.animation.height / 2)
        love.graphics.setColor(1, 1, 1, 1) -- set color back to normal
    end
end

return Player