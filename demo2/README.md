# Demo 2

![demo2](https://i.imgur.com/lGfO7xd.png)

Draws 10x amount of rectangles horizontally and 10y vertically with random color each frame .

Vertical arrow keys change the value of y and the horizontal ones change x.

This demo is to test fps decrease when using DEEP when drawing hundreds of objects in each frame.

When drawing normally my PC reached 1 fps at `x = 114` and `y = 124`

DEEP reaches 1 fps at `x = 580` and `y = 780`

What that means is, if you're going to be drawing 14136 different objects each frame, deep will 
decrease performance 3.12 times. 

# Notes
The benchmark was done on a 2nd generation i5 (up to 3.2ghz) with 
8gb RAM and an Nvidia GT 520M. Considered weak by 2018's standarts
