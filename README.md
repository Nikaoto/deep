# deep
**deep** is a tiny library for queuing and executing actions in sequence. 

This functionality can be used in multiple ways, one of which is for [**LÖVE**](https://love2d.org);
you can use the Z axis when drawing.

## Usage
To use deep in your lua files, at the beginning of the file, simply do:

```Lua
deep = require "deep"
```

// TODO add inline demo

**NOTE:** only use z axis values of 0 and above.*

**NOTE2:** draw order on the same z axis works just like the traditional draw order in LOVE2D: 
each draw call draws over the previous ones*

### `deep.queue(i, fun)`
Queues a function for execution at index i.

```lua
deep.queue(1, print("Hello"))
```

Arguments:
* `i` `(number)` - The index of the action
* `fun` `(function)` - The function to queue

To queue multiple actions, simply create an annonymous function:
```lua
deep.queue(1, function()
	print("Hello")
	print("World!")
end)
```

### `deep:execute()`
Executes all of the queued actions.

```lua
-- Will execute the actions in random order
deep.queue(math.random(10), print("Bleep!"))
deep.queue(math.random(10), print("Bloop!"))
deep.queue(math.random(10), print("Beep!"))
deep.queue(math.random(10), print("Boop!"))

deep.execute()
```

# Demos
The demo files have small examples of how deep's different functions should be used. I suggest 
you check out each one of them to learn about the various edge cases and details of deep.

Here's what demo1 does:
![demo](https://i.imgur.com/jRJXcZL.gif)