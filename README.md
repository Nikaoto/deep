# deep
**deep** is a library for [**LÖVE2D**](https://love2d.org) that adds the Z axis.

It frees you from the tedious task of rearranging your drawing order and allows you
to simply specify the z axis when drawing objects.

## Usage
To use deep in your lua files, at the beginning of the file, simply do:

```Lua
deep = require "deep"
```

// TODO add inline demo

Drawing objects with deep is straightforward - inside `love.draw()`, queue your objects up and 
then call `deep:drawAll()`.

To queue up your objects, simply use the listed functions like you would use their love versions.

Deep's functions work exactly like their love.graphics counterparts.

**NOTE:** only use z axis values of 0 and above.*

**NOTE2:** draw order on the same z axis works just like the traditional draw order in LOVE2D: 
each draw call draws over the previous ones*

<br><br>

# Documentation

## Drawing

Deep works by queuing each drawcall you make and then drawing them all according to their z axis. 
I suggest tying each object's z coordinate to its y value.

---
#### `deep:drawAll()`

Draws every object inside the draw queue. Call this at the end of your `love.draw()` function.
Everything you draw directly with love after calling `deep:drawAll()` will be drawn over your queue. 
Inversely, anything you directly draw before calling `deep:drawAll()` will be drawn under the queue.

<br>

---
#### `deep:draw(drawable, x, y, z, r, sx, sy, ox, oy, kx, ky)`
*Equivalent to love.graphics.draw()*

// TODO: add argument list

Takes every argument that `love.graphics.draw()` does with the addition of the z axis.

Also works with skipping arguments:

```Lua
deep:draw(player.sprite, player.x, player.y, player.z)
```

The same applies to every function in deep.

<br>

---
#### `deep:setColor()`
*Equivalent to love.graphics.setColor()*

Has a couple of variations:
* **deep:setColor(r, g, b, a)** - Takes RGBA values (ex: `deep:setColor(255, 0, 100)`) and applies the 
color to every following draw call. When you skip the 4th argument (opacity), the default '255' is 
applied.
* **deep:setColor(color)** - Takes RGBA values from a table (ex: `deep:setColor({255, 0, 100})`)
* **deep:setColor()** - When no arguments are passed, deep resets the color to white

<br>

---
#### `deep:rectangle(mode, x, y, z, width, height)`
*Equivalent to love.graphics.rectangle()*

<br>

---
#### `deep:print(text)`
*Equivalent to love.graphics.print()*

<br>

---
#### `deep:ellipse(mode, x, y, z, rediusx, radiusy)`
*Equivalent to love.graphics.ellipse()*

<br>

---
#### `deep:circle(mode, x, y, z, segments)`
*Equivalent to love.graphics.circle()*

<br>

## Color overriding

//TODO add setColor here
//TODO add shader explanation here

deep allows you to override the current color by calling any draw function followed by a capital
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

***NOTE:** When overriding colors, the color must be passed as a table*

<br>

## Defaults

When you skip arguments in deep's function calls, the variables from the `defaults` table will 
instead be used. 

For example:
```Lua
deep:print("Hello!", 10, 10) -- Drawing at x = 10, y = 10
```

The z argument is skipped as you can see, so it will be defaulted to `defaults.z`

<br><br>

# Demos
The demo files have small examples of how deep's different functions should be used. I suggest 
you check out each one of them to learn about the various edge cases and details of deep.

Here's what demo1 does:
![demo](https://i.imgur.com/jRJXcZL.gif)

<br><br>

# TODO
//TODO add License

*Drawing techniques that I plan to add to deep* 

* `love.graphics.arc` - `deep.graphics.arc`
* `love.graphics.clear` - `deep.graphics.clear`
* `love.graphics.line` - `deep.graphics.line` *works only when drawing one line*
* `love.graphics.points` - `deep.graphics.points`
* `love.graphics.polygon` - `deep.graphics.polygon`
* `love.graphics.stencil` - `deep.graphics.stencil`
* negative z axii
* particle effects
* support for other popular graphical libraries for LOVE2D
