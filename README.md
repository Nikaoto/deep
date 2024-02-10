```
██████╗ ███████╗███████╗██████╗ 
██╔══██╗██╔════╝██╔════╝██╔══██╗
██║  ██║█████╗  █████╗  ██████╔╝
██║  ██║██╔══╝  ██╔══╝  ██╔═══╝ 
██████╔╝███████╗███████╗██║     
╚═════╝ ╚══════╝╚══════╝╚═╝     
```

**deep** is a tiny high-performance library that lets you add drawing layers and
a Z axis to any graphics framework in Lua.

# Usage
After placing `deep.lua` inside your project:

```lua
deep = require("deep")
layer = deep:new()

-- Queue actions. These actions can be drawcalls or anything at all.
layer:queue(3, function() print("wound!") end)
layer:queue(1, function() print("It's just") end)
layer:queue(2, function() print("a flesh") end)

-- Execute all actions in the layer
layer:draw()
```

This will print:
```
It's just
a flesh
wound!
```

# Documentation

### `deep:new() -> layer`

Returns a new drawing layer that holds its own queue of actions (its z-axis).

You can have multiple layers which get drawn one after the other, or not drawn at all:
```lua
background_layer = deep:new()
game_object_layer = deep:new()
ui_layer = deep:new()

function love.draw()
   -- Queue the actions for drawing stuff
   background_layer:queue(...)
   game_object_layer:queue(...)
   ui_layer:queue(...)

   -- With this, we will have the ui drawing over the game_objects.
   -- And both will be drawn in front of the background.
   background_layer:draw()
   game_object_layer:draw()
   ui_layer:draw()
end
```

### `layer:queue(z, fn)`
Queues a function for execution at index `z`. `z` **must** be an integer. It can
be negative, positive or zero. Using a float or any other type here will not
queue the action.

### `layer:restrict(z_from, z_to)`
Used for culling drawcalls that don't fall into the given interval.

This is basically a primitive way to do frustum-culling to optimize your performance.
```
function love.draw()
   -- This will get added to the queue, but because of the restrict statement,
   -- it won't get drawn when layer:draw() is called.
   layer:queue(102, function() print("hi") end)

   layer:restrict(100, 120)
   
   -- This will not get added to the queue
   layer:queue(101, function() draw_something() end)
   
    -- Will not do anything, because we have no valid actions
   layer:draw()
end
```

# Examples
![love2d z axis drawing example](https://i.imgur.com/yk2O1ao.gif)

To achieve this, you could do the following: 
```lua
deep = require("deep")
layer = deep:new()

-- The z index of the red cube
current_z = 1

function love.draw()
   -- Queue the three horizontal lines
   layer:queue(2, function() draw_strip(200, 60) end)
   layer:queue(3, function() draw_strip(200, 80) end)
   layer:queue(4, function() draw_strip(200, 100) end)

   -- Red square, which can move through z axis
   layer:queue(current_z, function()
      -- Draws a red square
      love.graphics.setColor(1, 0, 0)
      love.graphics.rectangle("fill", 300, 40, 80, 80)
   end)

   -- Draw everything in the queue
   layer:draw()
end

-- Increases/decreases red square z on key press
function love.keypressed(key)
   if key == "up" then
      current_z = current_z + 1
   elseif key == "down" then
      current_z = current_z - 1
   end
end

-- Draws a horizontal white strip
function draw_strip(x, y)
   love.graphics.setColor(1, 1, 1)
   love.graphics.rectangle("fill", x, y, 300, 10)
end
```
---

The example files have small demos of how deep's different functions should be used. You should at
least look at the `README.md` of each example to see what deep can do. If you intend to use deep, I
*highly* recommend you read some of the code as well.

Here's what [example0](https://github.com/Nikaoto/deep/tree/master/examples/example0) does:

![example0 love2d 2.5D example](https://i.imgur.com/j5OJe46.gif)

You can also check out a small jam game I made with deep: https://github.com/nikaoto/shamen
![Shamen preview](https://i.imgur.com/YOdBqGR.gif)

# Possible speed optimizations
- Preallocate the queue with `table.new()` (only works in LuaJIT)
- Clear the queue on each exec with `table.clear()` (only works in LuaJIT)
