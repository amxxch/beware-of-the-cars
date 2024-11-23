local Map = {}

local Player = require("player")
local redCar = require("redcar")
local greenCar = require("greencar")
local blueCar = require("bluecar")
local navyCar = require("navycar")
local busCar = require("buscar")
local truckCar = require("truckcar")
local STI = require("sti") -- Thanks STI from https://github.com/karai17/Simple-Tiled-Implementation

function Map:load()
    self.maps = STI("Map/Maps.lua", {"box2d"}) 
    World = love.physics.newWorld(0,2000)
    World:setCallbacks(beginContact, endContact)
    self.maps:box2d_init(World)
    self.maps.layers.object.visible = false

    MapWidth = self.maps.layers.tile.width * 16
    MapHeight = self.maps.layers.tile.height * 16
    
    self:spawnObjects()

end


function Map:update(dt)
    --if what then self:next()
end

function Map:clean()
    redCar.removeAll()
    greenCar.removeAll()
    blueCar.removeAll()
    navyCar.removeAll()
    busCar.removeAll()
    truckCar.removeAll()
 end


 function Map:spawnObjects()
    for i,v in ipairs(self.maps.layers.object.objects) do
        if v.class == "redCar" then
            redCar.new(v.x + v.width / 2, v.y + v.height / 2)
        elseif v.class == "greenCar" then
            greenCar.new(v.x + v.width / 2, v.y + v.height / 2)
        elseif v.class == "blueCar" then
            blueCar.new(v.x + v.width / 2, v.y + v.height / 2)
        elseif v.class == "navyCar" then
            navyCar.new(v.x + v.width / 2, v.y + v.height / 2)
        elseif v.class == "busCar" then
            busCar.new(v.x + v.width / 2, v.y + v.height / 2)
        elseif v.class == "truckCar" then
            truckCar.new(v.x + v.width / 2, v.y + v.height / 2)
        end
    end
end

return Map