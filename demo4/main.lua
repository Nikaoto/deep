-- main.lua
-- Ellipse demo for deep

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
	colors = {yellow, blue, green, white}
	cx, cy = 120, 120
	r = 50
	ellipseR = 5
end

function love.draw()
	for i = -r, r do
		for j = -r, r do
			if i*i + j*j == r*r then
				deep:ellipseC({math.random(20,255), math.random(20, 255), math.random(20, 255)}, 
					"fill", i + cx, j + cy, 6, ellipseR, ellpiseR)
			end
		end
	end

	deep:rectangleC({255, 0, 0}, "fill", cx - 60, cy - 60, 5, 120, 120)

	deep:draw()
end