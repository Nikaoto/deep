```
██████╗ ███████╗███████╗██████╗ 
██╔══██╗██╔════╝██╔════╝██╔══██╗
██║  ██║█████╗  █████╗  ██████╔╝
██║  ██║██╔══╝  ██╔══╝  ██╔═══╝ 
██████╔╝███████╗███████╗██║     
╚═════╝ ╚══════╝╚══════╝╚═╝     
```

**deep** is a tiny library for queuing and executing actions in sequence. 

This functionality can be used in multiple ways, one of which is for [**LÖVE**](https://love2d.org),
where you can use the Z axis when drawing.

# Usage
Place `deep.lua` inside your project and require it:

```lua
deep = require "deep"
```

### Queue actions
```lua
deep.queue(3, print, "wound!")
deep.queue(1, print, "It's just")
deep.queue(2, print, "a flesh")
```

### Execute
```lua
deep.execute()
```
Prints:
```
It's just
a flesh
wound!
```

# Documentation

### `deep.queue(i, fun, ...)`
Queues a function for execution at index `i`

```lua
deep.queue(100, print, "Hello")
-- or
deep.queue(100, function() print("Hello") end)
```

Arguments:
* `i` `(number)` - The index of the action, must be positive.
* `fun` `(function)` - An anonymous or named function
* `...` `(*)` - The arguments of the passed named function

Usage:

* With anonymous functions: 
	```lua
	deep.queue(30, function() hit(iron, 100) end)
	```

* With named functions: 
	```lua
	deep.queue(30, hit, iron, 100)
	```

* With multiple functions:
	```lua
	deep.queue(30, function()
	  hit(iron, 100)
	  strike(steel, 200)
	end)
	```
---

### `deep:execute()`
Executes all of the queued actions

```lua
-- Will execute the actions in random order
deep.queue(math.random(10), print, "'Tis")
deep.queue(math.random(10), print, "but")
deep.queue(math.random(10), print, "a")
deep.queue(math.random(10), print, "scratch!")

deep.execute()
```

# Examples
Deep can be effectively used with any 2D graphics framework in lua to help with the drawing process.

For example, with [**LÖVE**](https://love2d.org), one could add layers or a full isometric/2.5D 
drawing process to the framework:
![love2d z axis drawing example](https://i.imgur.com/yk2O1ao.gif)

To achieve this, you could do the following: 
```lua
local deep = require "deep"

-- The z index of the red cube
local current_z = 1

-- Draws a horizontal line at passed y coordinate
local function draw_rectangle(y)
  love.graphics.setColor(255, 255, 255) -- Set color to white
  love.graphics.rectangle("fill", 200, y, 300, 10) -- Draw thin rectangle
end

function love.draw()
  -- Queue the three horizontal lines
  deep.queue(2, draw_rectangle, 60)
  deep.queue(3, draw_rectangle, 80)
  deep.queue(4, draw_rectangle, 100)

  -- Red square, which can move through z axis
  deep.queue(current_z, function()
    love.graphics.setColor(255, 0, 0) -- Set color to red
    love.graphics.rectangle("fill", 300, 40, 80, 80)
  end)

  -- Draw everything in the queue
  deep.execute()
end

-- Increases/decreases red square z on key press
function love.keypressed(key)
  if key == "up" then
    current_z = current_z + 1
  elseif key == "down" then
    current_z = current_z - 1
  end
end
```
---

The demo files have small examples of how deep's different functions should be used. I suggest 
you check out each one of them to learn about the various edge cases and details of deep.

Here's what demo1 does:
![demo](https://i.imgur.com/jRJXcZL.gif)