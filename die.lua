local Die = {}

local Player = require("player")
local Map = require("map")

function Die:load()
end


function Die:update(dt)
    self:quit()
end

function Die:quit()
    if love.keyboard.isDown("space") then
        love.event.quit()
    end
end


function Die:draw()
    self:displayDie()
    self:displayRestart()
    self:displayQuit()
    love.graphics.setColor(1, 1, 1, 0.7 )
end

function Die:displayDie()
    love.graphics.setFont(love.graphics.newFont("assets/Font/RACE1 Brannt Plus NCV.ttf", 80))
    local x = love.graphics.getWidth() / 2 - 180
    local y = love.graphics.getHeight() / 2 - 130
    love.graphics.setColor(0, 0, 0, 0.5) --making black
    love.graphics.print("You die !", x + 2, y + 2) --shadow
    love.graphics.setColor(1, 0, 0, 1) --making red
    love.graphics.print("You die !", x, y)
    love.graphics.setColor(1, 1, 1, 1) --making white
end

function Die:displayRestart()
    love.graphics.setFont(love.graphics.newFont("assets/Font/Sabatica-regular.ttf", 30))
    local x = love.graphics.getWidth() / 2 - 195
    local y = love.graphics.getHeight() / 2 - 45
    love.graphics.setColor(0, 0, 0, 0.5) --making black
    love.graphics.print("Press Enter to restart the game", x + 2, y + 2) --shadow
    love.graphics.setColor(1, 0.5, 1, 1) --making purple
    love.graphics.print("Press Enter to restart the game", x, y)
end

function Die:displayQuit()
    love.graphics.setFont(love.graphics.newFont("assets/Font/Sabatica-regular.ttf", 30))
    local x = love.graphics.getWidth() / 2 - 140
    local y = love.graphics.getHeight() / 2
    love.graphics.setColor(0, 0, 0, 0.5) --making black
    love.graphics.print("Press Space Bar to quit", x + 2, y + 2) --shadow
    love.graphics.setColor(0.5, 1, 1, 1) --making blue green
    love.graphics.print("Press Space Bar to quit", x, y)
    love.graphics.setColor(1, 1, 1, 1) --making white
end


return Die