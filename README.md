# DEEP
Is a library for [**LÖVE2D**](https://love2d.org) that adds the Z axis.

**DEEP** frees you from the tedious task of rearranging your drawing order and allows you
to simply specify the z axis when drawing objects.



## Usage
To use **DEEP** in your lua files, simply `require "deep"`.

Drawing objects with **DEEP** is straightforward - inside `love.draw()`, queue your objects up and 
then call `deep:draw()`.

To queue up your objects, simply use the listed functions like you would use their love versions.

**DEEP**'s functions work exactly like their love.graphics counterparts.

**NOTE: only use z axis values of 0 and above. DEEP does not support negative axii for now.**
**NOTE2: draw order on the same z axis works just like the traditional draw order in LOVE2D: 
each draw call draws over the previous ones**



## Functions

### deep:draw()
*The heart of the library*

Draws every object inside the draw queue. Always do this at the end of `love.draw()`.
Everything you draw directly after calling `deep:draw()` will be drawn over your queue. Inversely,
anything you directly draw before calling `deep:draw()` will be drawn under the queue.


### deep:queue(x, y, z, r, sx, sy, ox, oy, kx, ky)
*Equivalent to love.graphics.draw()*

Takes every argument that `love.graphics.draw()` does with the addition of the z axis.

Also works with skipping arguments:

```Lua
deep:queue(player.sprite, player.x, player.y, player.z)
```

The same applies to every function in **DEEP**.


### deep:setColor()
*Equivalent to love.graphics.setColor()*

Has a couple of variations:
* **deep:setColor(r, g, b, a)** - Takes RGBA values (ex: `deep:setColor(255, 0, 100)`) and applies the 
color to every following draw call. When you skip the 4th argument (opacity), the default '255' is 
applied.
* **deep:setColor(color)** - Takes RGBA values from a table (ex: `deep:setColor({255, 0, 100})`)
* **deep:setColor()** - When no arguments are passed, **DEEP** resets the color to white


### deep:rectangle(mode, x, y, z, width, height)
*Equivalent to love.graphics.rectangle()*


### deep:print()
*Equivalent to love.graphics.print()*



## Color overriding

**DEEP** allows you to override the current color by calling any draw function followed by a capital
 'C' and specifying your desired color in the first argument, so 

```Lua
deep:setColor(200, 0, 20)
deep:rectangle("fill", 100, 100, 30, 50, 50")
deep:setColor() -- reset color
```

is the same as

```Lua
-- (color, mode, x, y, z, width, height)
deep:rectangleC({200, 0, 20}, "fill", 100, 100, 30, 50, 50) 
```

Color overriding works with every draw function that is also affected by love.graphics.setColor()
(ex. love.graphics.print(), love.graphics.line()...)

**NOTE: When overriding colors, the color must be passed as a table**


## Demos
The demo files have small examples of how **DEEP**'s different functions should be used. I suggest 
you check out each one of them to learn about the various edge cases and details of **DEEP**.

Here's what demo1 does:
![demo](https://i.imgur.com/jRJXcZL.gif)



## TODO
*Drawing techniques that I plan to add to **DEEP*** 
* love.graphics.arc - deep.graphics.arc
* love.graphics.circle- deep.graphics.circle
* love.graphics.clear- deep.graphics.clear
* ~~love.graphics.ellipse- deep.graphics.ellipse~~
* love.graphics.line- deep.graphics.line
* love.graphics.points- deep.graphics.points
* love.graphics.polygon- deep.graphics.polygon
* ~~love.graphics.print- deep.graphics.print~~
* ~~love.graphics.rectangle- deep.graphics.rectangle~~
* love.graphics.stencil- deep.graphics.stencil
* ~~love.graphics.setColor~~
* negative z axii
* particle effects
* other popular graphical libraries for LOVE2D
