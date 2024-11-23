# Beware of the Cars!
Video Demo:  https://youtu.be/gNLMu6onGpg
Description: This is the 2D game called Beware of the Cars that is made using Lua with Love. The instruction of the game is easy: you as a player have 10 hearts, and your mission is to cross the roads to the finish points. Every time you got hit by the cars, you will get hurt and your heart will be dropped by 1. There are 6 types of cars in the game that have different sizes, directions, and speeds. If you run out of hearts, it means that you die in the game and have to restart again. There will be a timer that count the amount of time you have used until reaching the finishing point. At the finishing point, there is a zone of livings with houses and gardens. Now let's look through each file of coding.

main.lua : This is the main file that integrates all minor files together. In other words, the game will run mainly based on this file. Moreover, it contains the condition of showing each screen (menu, playing, win, and die).

player.lua : This is the file that contains every information and ability of player. In general,  the player can move in 4 directions: right, left, up, and down (by pressing arrow at the keyboards). Also, it has 5 states based on the movement: idle and the 4 directions. The player cannot move out of the boundary of the screen. At first, the player will be spawn at the below of the map with 10 hearts and alive status. If the player gets hit, its heart will decrease and its body will turn red for a second. Eventually, if it is out of heart, its status will turn into not alive and die. The animation of player is from Twitter : Gif (@gif_not_jif), Noiracide (@Noiracide), Romi (@DessRomaric).

redCar.lua , greenCar.lua , blueCar.lua, navyCar.lua, busCar.lua, truckCar.lua : This is the car that automatically moving horizontally on the road. Each single car is kept at the meta table of each type of cars, which runs in various speeds and directions. Every time it touches the boundary of the screen, its position will automatically be reset to the other side of the screen again and keep running infinitely. If it begins contact horizontally with the player, it will call the function getHit in the player, and the player will react as described above. The animation of each car is from Twitter : @Exuin_

map.lua : This is the file that uses to call the map that has been designed in the program named Tiled. Also, it will spawn all the objects that have been created in the map by linking each object to each individual .lua file. The map is created using tileset from Twitter : @Exuin_

camera.lua : This is to set the camera to move along with the player's position.

menu.lua : This is the file that draws the front letters that you will see when first entering the game. It consists of the name of the game and the instruction to press space bar in order to start the game. If the space bar is pressed, the currentScreen status will be changed into playing and the timer will start counting.

win.lua : This is the file that draws the letters and animations that will declare that you win when you reach the top of the map. It consists of the phrase you win, the instruction to press space bar to quit or press enter to restart, the animation of a player, and the amount of time used. 

die.lua : This is the file that draws the letters and animations that will declare that you die when you run out of hearts. It consists of the phrase you die and the instruction to press space bar to quit or press enter to restart.

gui.lua : This is the graphical user interface that is drawn while playing. It consists of the amount of hearts left at the top left of the screen and the amounts of time passing at the top right of the screen.

conf.lua : This is the file that declares some overall information of the game.

Lastly, I studied how to create the game using Love2D with youtube: DevJeeper and adapt the knowledge to design my own games. So thanks to DevJeeper!
