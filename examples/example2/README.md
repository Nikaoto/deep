# example2 [OUTDATED]

![example2-deep](https://i.imgur.com/pv65wx2.png)

Draws 10x amount of rectangles horizontally and 10y vertically with random color each frame .

Vertical arrow keys change the value of y and the horizontal ones change x.

This demo is to test fps decrease when using DEEP when drawing hundreds of objects in each frame.

### Benchmark #1
Mobile 2nd generation Intel i5 with 8gb RAM and an Nvidia GT 520M. 
Considered weak by 2018's standarts.

When drawing normally the device reached 1 fps at `x = 114` and `y = 124`

DEEP reaches 1 fps at `x = 58` and `y = 78`

What that means is, if you're going to be drawing 14136 different objects each frame, deep will 
decrease performance 3.12 times. 

### Benchmark #2
Intel i7 2600k with 12gb RAM and an Nvidia GTX 1060 (3gb). 
Considered high-end by 2018's standarts.

Drawing normally the device reached 1 fps at `x = 108` and `y = 174`

Drawing with DEEP, it reached 1 fps at `x = 76` and `y = 76`

This time the performance decreased 3.25 times


### Summary
Using these two vastly different benchmarks, we can estimate that when drawing tens of thousands of 
objects at at time, the performance of the game will slow down by 318%

Below 10 thousand items, the performance impact is insignificant.

# Notes
Please consider that the benchmarks were done in 2018.03.16 and might need updating. 

In addition, no standard procedures were used to measure the performance, I just multiplied the 
rectangle counts when the program reached 1 fps and compared the numbers.

*You can send a PR any time for updated and/or alternate benchmakrs*
