# example0
![example0 love2d 2.5D example](https://i.imgur.com/j5OJe46.gif)

Ties the y coordinate of the player to its z axis.

`Y_MOVE_MOD` is used to slow down the player's movement so it looks like it's moving forwards and 
backwards in depth.

Don't get confused by this part of the code:
```lua
package.path = package.path .. ";../?.lua"
local deep = require "../deep"
```

It's only meant for reaching `deep.lua` from a child directory. You probably don't need to use this 
and can stick to simply 
```lua 
deep = require "lib/deep"
```
(the lib directory is where libraries are placed by standard)
