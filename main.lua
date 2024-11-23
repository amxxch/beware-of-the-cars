love.graphics.setDefaultFilter("nearest", "nearest")
local Player = require("player")
local redCar = require("redcar")
local greenCar = require("greencar")
local blueCar = require("bluecar")
local navyCar = require("navycar")
local busCar = require("buscar")
local truckCar = require("truckcar")
local Camera = require("camera")
local GUI = require("gui")
local Menu = require("menu")
local Die = require("die")
local Win = require("win")
local Map = require("map")
local STI = require("sti") -- Thanks STI from https://github.com/karai17/Simple-Tiled-Implementation


function love.load()
    currentScreen = "menu"
    Map:load()
    Player:load()
    Camera:load()
    GUI:load()
    Menu:load()
    Win:load()
end


function love.update(dt)
    World:update(dt)
    Map:update(dt)

    if currentScreen == "menu" then
        Menu:update(dt)
        Camera:position(0, Player.y)

    elseif currentScreen == "playing" then
        Camera:position(0, Player.y)
        Player:update(dt)
        GUI:update(dt)
        redCar:updateAll(dt)
        greenCar:updateAll(dt)
        blueCar:updateAll(dt)
        navyCar:updateAll(dt)
        busCar:updateAll(dt)
        truckCar:updateAll(dt)

    elseif currentScreen == "die" then
        Camera:position(0, Player.y)
        Die:update(dt)
        Player:update(dt)
        GUI:update(dt)
        redCar:updateAll(dt)
        greenCar:updateAll(dt)
        blueCar:updateAll(dt)
        navyCar:updateAll(dt)
        busCar:updateAll(dt)
        truckCar:updateAll(dt)

        if love.keyboard.isDown("return") then
            Map:clean()
            love.load()
            currentScreen = "playing"
        end

    elseif currentScreen == "win" then
        Camera:position(0, 0)
        Win:update(dt)
        Player:update(dt)
        redCar:updateAll(dt)
        greenCar:updateAll(dt)
        blueCar:updateAll(dt)
        navyCar:updateAll(dt)
        busCar:updateAll(dt)
        truckCar:updateAll(dt)

        if love.keyboard.isDown("return") then
            Map:clean()
            love.load()
            currentScreen = "playing"
        end
    end
end


function love.draw()
    Map.maps:draw(-Camera.x, -Camera.y, 2, 2)

    if currentScreen  == "menu" then
        Menu:draw()

    elseif currentScreen == "playing" then
        Camera:set()
        Player:draw()
        redCar:drawAll()
        greenCar:drawAll()
        blueCar:drawAll()
        navyCar:drawAll()
        busCar:drawAll()
        truckCar:drawAll()
        Camera:unset()

        GUI:draw()

    elseif currentScreen == "die" then
        Map.maps:draw(-Camera.x, -Camera.y, 2, 2)

        Camera:set()
        Player:draw()
        redCar:drawAll()
        greenCar:drawAll()
        blueCar:drawAll()
        navyCar:drawAll()
        busCar:drawAll()
        truckCar:drawAll()
        Camera:unset()
        Die:draw()

        GUI:draw()

    elseif currentScreen == "win" then
        Map.maps:draw(-Camera.x, -Camera.y, 2, 2)

        Camera:set()
        Player:draw()
        redCar:drawAll()
        greenCar:drawAll()
        blueCar:drawAll()
        navyCar:drawAll()
        busCar:drawAll()
        truckCar:drawAll()
        Camera:unset()
        Win:draw()

    end
end

function beginContact(a, b, collision)
    redCar.beginContact(a, b, collision)
    greenCar.beginContact(a, b, collision)
    blueCar.beginContact(a, b, collision)
    navyCar.beginContact(a, b, collision)
    busCar.beginContact(a, b, collision)
    truckCar.beginContact(a, b, collision)
end