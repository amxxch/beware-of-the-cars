local Menu = {}

local Player = require("player")

function Menu:load()
    startDisplay = true
    self.rate = 0.5
    self.timer = 0
end


function Menu:update(dt)
    self:start(dt)
    self:pip(dt)
end

function Menu:start(dt)
   if love.keyboard.isDown("space") then
       currentScreen = "playing"
       Player:countTime(dt)
   end
end

function Menu:pip(dt)
    self.timer = self.timer + dt
    if self.timer > self.rate then
        self.timer = 0
        if startDisplay == true then
            startDisplay = false
        else
            startDisplay = true
        end
    end
end


function Menu:draw()
    self:displayName()
    if startDisplay == true then
        self:displayStart()
    end
end

function Menu:displayName()
    love.graphics.setFont(love.graphics.newFont("assets/Font/RACE1 Brannt Plus Chiseled NCV.ttf", 70))
    local x = love.graphics.getWidth() / 2 - 380
    local y = love.graphics.getHeight() / 2 - 230
    love.graphics.setColor(0, 0, 0, 0.5) --making black
    love.graphics.print("BEWARE OF THE CARS !", x + 2, y + 2) --shadow
    love.graphics.setColor(1, 1, 1, 1) --making white
    love.graphics.print("BEWARE OF THE CARS !", x, y)
end

function Menu:displayStart()
    love.graphics.setFont(love.graphics.newFont("assets/Font/Sabatica-regular.ttf", 40))
    local x = love.graphics.getWidth() / 2 - 190
    local y = love.graphics.getHeight() / 2 - 115
    love.graphics.setColor(0, 0, 0, 0.5) --making black
    love.graphics.print("Press Space Bar to start", x + 2, y + 2) --shadow
    love.graphics.setColor(1, 1, 0.3, 1) --making yellow
    love.graphics.print("Press Space Bar to start", x, y)
    love.graphics.setColor(1, 1, 1, 1) --making white
end

return Menu