local GUI = {}

local Player = require("player")

function GUI:load()
    self.scale = 2.5
    self.space = 10

    self.hearts = {}
    self.hearts.img = love.graphics.newImage("assets/hearts_hud.png")
    self.hearts.width = self.hearts.img:getWidth()
    self.hearts.height = self.hearts.img:getHeight()
    self.hearts.x = 10
    self.hearts.y = 20

    self.nohearts = {}
    self.nohearts.img = love.graphics.newImage("assets/no_hearts_hud.png")
    self.nohearts.width = self.nohearts.img:getWidth()
    self.nohearts.height = self.nohearts.img:getHeight()
    self.nohearts.x = self.hearts.x + (self.hearts.width * self.scale + self.space) * Player.heart.max
    self.nohearts.y = self.hearts.y

    self.font = love.graphics.newFont("assets/Font/Sabatica-regular.ttf", 36)

end

function GUI:update(dt)

end

function GUI:draw()
    self:displayHearts()
    self:displayTime()
end


function GUI:displayHearts()
    for i=1,Player.heart.current do
        local hearts_x = self.hearts.x + (self.hearts.width * self.scale + self.space) * i
        love.graphics.draw(self.hearts.img, hearts_x, self.hearts.y, 0, self.scale, self.scale)
    end

    for i=1, (Player.heart.max - Player.heart.current) do
        local nohearts_x = self.nohearts.x - (self.hearts.width * self.scale + self.space) * (i - 1)
        love.graphics.draw(self.nohearts.img, nohearts_x, self.nohearts.y, 0, self.scale, self.scale)
    end
end

function GUI:displayTime()
    love.graphics.setFont(self.font)
    local x = love.graphics:getWidth() - 150
    local y = self.hearts.y
    love.graphics.setColor(0, 0, 0, 0.5) --making black
    love.graphics.print("Time : ".. Player.currentTime, x + 2, y + 2) --shadow
    love.graphics.setColor(1, 1, 1, 1) --making white
    love.graphics.print("Time : ".. Player.currentTime, x, y)
end


return GUI