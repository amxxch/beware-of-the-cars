local Win = {}

local Player = require("player")
local Map = require("map")

function Win:load()
    self:loadAssets()
end

function Win:loadAssets()
    self.animation = {timer = 0, rate = 0.1 , current = 1, total = 12, img = {}}

    for i=1,self.animation.total do
        local n = i - 1
        if n < 10 then
            self.animation.img[i] = love.graphics.newImage("assets/win/tile00"..n..".png")
        else
            self.animation.img[i] = love.graphics.newImage("assets/win/tile0"..n..".png")
        end
    end

    self.animation.draw = self.animation.img[1]
    self.animation.width = self.animation.draw:getWidth()
    self.animation.height = self.animation.draw:getHeight()
end

function Win:update(dt)
    self:amimate(dt)
    self:quit()
end

function Win:amimate(dt)
    self.animation.timer = self.animation.timer + dt
    if self.animation.timer > self.animation.rate then
        self.animation.timer = 0
        self:setNewFrame()
    end
end

function Win:setNewFrame(dt)
    if self.animation.current < self.animation.total then
        self.animation.current = self.animation.current + 1
    else
        self.animation.current = 1
    end

    self.animation.draw = self.animation.img[self.animation.current]
end

function Win:quit()
    if love.keyboard.isDown("space") then
        love.event.quit()
    end
end


function Win:draw()
    self:displayWin()
    self:displayRestart()
    self:displayQuit()
    self:displayPlayer()
    self:displayTime()
    love.graphics.setColor(1, 1, 1, 1)
end

function Win:displayWin()
    love.graphics.setFont(love.graphics.newFont("assets/Font/RACE1 Brannt Plus NCV.ttf", 80))
    local x = love.graphics.getWidth() / 2 - 175
    local y = love.graphics.getHeight() / 2 - 130
    love.graphics.setColor(0, 0, 0, 0.5) --making black
    love.graphics.print("You Win !", x + 2, y + 2) --shadow
    love.graphics.setColor(1, 1, 0, 1) --making red
    love.graphics.print("You Win !", x, y)
    love.graphics.setColor(1, 1, 1, 1) --making white
end

function Win:displayRestart()
    love.graphics.setFont(love.graphics.newFont("assets/Font/Sabatica-regular.ttf", 30))
    local x = love.graphics.getWidth() / 2 - 190
    local y = love.graphics.getHeight() / 2 - 45
    love.graphics.setColor(0, 0, 0, 0.5) --making black
    love.graphics.print("Press Enter to restart the game", x + 2, y + 2) --shadow
    love.graphics.setColor(1, 0.5, 1, 1) --making purple
    love.graphics.print("Press Enter to restart the game", x, y)
end

function Win:displayQuit()
    love.graphics.setFont(love.graphics.newFont("assets/Font/Sabatica-regular.ttf", 30))
    local x = love.graphics.getWidth() / 2 - 140
    local y = love.graphics.getHeight() / 2
    love.graphics.setColor(0, 0, 0, 0.5) --making black
    love.graphics.print("Press Space Bar to quit", x + 2, y + 2) --shadow
    love.graphics.setColor(0.5, 1, 1, 1) --making blue green
    love.graphics.print("Press Space Bar to quit", x, y)
    love.graphics.setColor(1, 1, 1, 1) --making white
end

function Win:displayPlayer()
    local x = love.graphics.getWidth() / 2 + 20
    local y = love.graphics.getHeight() / 2 + 140

    love.graphics.draw(self.animation.draw, x, y, 0, 6, 6, self.animation.width / 2, self.animation.height / 2)
end

function Win:displayTime()
    love.graphics.setFont(love.graphics.newFont("assets/Font/Sabatica-regular.ttf", 40))
    local x = love.graphics:getWidth() / 2 - 110
    local y = 20
    love.graphics.setColor(0, 0, 0, 0.5) --making black
    love.graphics.print("Time used : ".. Player.winTime, x + 2, y + 2) --shadow
    love.graphics.setColor(1, 1, 1, 1) --making white
    love.graphics.print("Time used : ".. Player.winTime, x, y)
end

return Win