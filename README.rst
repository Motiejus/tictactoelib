Game Logic for Ultimate Tic Tac Toe
===================================

This library should allow to easily create front-ends
for ultimate-tic-tac-toe game. It takes care of game rules,
validating the arguments, calling the right functions.

``main.lua`` is an example how this library can be used. To try out::

    ./main.lua examples/player1.lua examples/player1.lua

The file takes two arguments: Lua files, which implement a player.
``examples/player1.lua`` is a demo player which marks a first available slot.
Command-line example above makes it fight with itself.

See ``examples/player1.lua`` how to implement a player (it could also be
something that takes events from UI).
