Benjamin Avrahami and Ethan Morgan's APCS2 Final Project

[Development Log](https://github.com/emorgan00/CatanLite/blob/master/devlog.md)

This is the game of Catan, which supports at least two players (but should be four or less). 
Build settlements, roads and cities to hunt for resources, and be the first to 10 victory points!

Instructions:
The first thing to appear on the screen is a menu, which allows the user to input the number, names, and colors of the players. After that, there is a setup phase, where each player adds two settlements and two roads, which have to touch the corresponding settlement (in snake order).
After the setup, normal gameplay begins. During each player's turn, the dice are rolled. Each hexagonal tile has a resource and a number except for the desert. If one of your settlements or cities is adjacent to that tile when its number is rolled (there are two dice), you get one of that resource for every adjacent settlement and two for every adjacent city, regardless of whether it is your turn. If a 7 is rolled, the player moves the robber onto another tile, which stops that tile from giving out resources, and then steals a random resource from a player with a settlement or city adjacent to that tile. After a turn, the player can do one of several things: they can buy a settlement, which costs 1 wood, 1 brick, 1 wool, and 1 wheat; they can buy a city (which can only replace a settlement, not be put somewhere new), which costs 3 ore and 2 wheat; they can buy a road, which connects settlements, costing 1 wood and 1 brick; they can buy a development card, which can do several things depending on the card, costing 1 wool, 1 ore, and 1 wheat; they can switch 4 of any one resource for 1 of any other resource; and they can play a development card. Multiple actions can be taken on any one turn.
However, there are restrictions on the placement of settlements, roads, and cities. After the setup phase, each object put down must be connected to something else that the player owns. In addition, any settlement put down must be at least two spaces away (road spaces do not count) from any other settlement or city of any player. There is a maximum (per player) of 5 settlements, 4 cities, and 15 roads.
Each settlement is worth 1 victory point, each city is worth 2 victory points, and certain development cards also provide victory points. The first person to 10 victory points wins.

Anything available to buy will be highlighted. To place settlements, roads, and cities, click on the appropriate object in the lower right hand corner of the screen and then click on the place where you want it to go. If the place clicked is invalid, nothing will happen. If you click outside the board (technically, the rectangle containing the board), the purchase will cancel. To substitute 4:1, click on the resource you want to buy and then click on the resource you will pay. To end a turn, press Enter.
