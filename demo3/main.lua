-- main.lua
-- Text demo for deep using love's Text object and deep:print

package.path = package.path .. ";../?.lua"
require "deep"


function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end

function love.load()
	yellow = {255, 255, 0}
	blue = {0, 0, 255}
	green = {0, 255, 0}
	white = {255, 255, 255}

	font = love.graphics.newFont(34)
	t1 = love.graphics.newText(font)
	t1:addf({white, "A"}, 100, "left", 40, 40, _, 2, 2)
	t1:addf({green, "B"}, 100, "center", 40, 40, _, 2, 2)
end

function love.draw()
	deep:queue(t1, 10, 10, 50)

	deep:printC(blue, "I am drawn over the red square", 10, 30, 15, _, 2, 2)
	deep:rectangleC({255, 0, 0}, "fill", 10, 10, 10, 200, 200)
	deep:printC(yellow, "I am drawn under the red square", 10, 10, 5, _, 2, 2)

	deep:draw()
end