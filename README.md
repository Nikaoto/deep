# DEEP
Is a library for [**LÖVE2D**](https://love2d.org) that adds the Z axis.

**DEEP** frees you from the tedious task of rearranging your drawing order and allows you
to simply specify the z axis when drawing objects.


## Usage
To use **DEEP** in your lua files, simply `require "deep"`.

Drawing objects with **DEEP** is straightforward. Inside `love.draw()`, queue your objects up and then call `deep:draw()`.

To enqueue your objects, simply use `deep:queue()` like you wolud use `love.graphics.draw()`. 

For example:

`
deep:queue(player.sprite, player.x, player.y, player.z)
`


`deep:queue()` takes every arguments that `love.graphics.draw()` does with the addition of the z axis:

`
function deep:queue(x, y, z, r, sx, sy, ox, oy, kx, ky)
`

The file `demo` has small examples of how **DEEP** should be used. I suggest you check it out to learn about more details.


## Draw support
*A list of the drawing techniques that **DEEP** currently supports*

* love.graphics.draw()


## TODO
*Drawing techniques that I plan to add to **DEEP*** 
* love.graphics.arc - deep.graphics.arc
* love.graphics.circle- deep.graphics.circle
* love.graphics.clear- deep.graphics.clear
* love.graphics.ellipse- deep.graphics.ellipse
* love.graphics.line- deep.graphics.line
* love.graphics.point- deep.graphics.point
* love.graphics.points- deep.graphics.points
* love.graphics.polygon- deep.graphics.polygon
* love.graphics.print- deep.graphics.print
* love.graphics.quad- deep.graphics.quad
* love.graphics.rectangle- deep.graphics.rectangle
* love.graphics.stencil- deep.graphics.stencil
* particle effects
* other popular graphical libraries for LOVE2D
