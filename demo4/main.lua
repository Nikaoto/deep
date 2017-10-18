-- main.lua
-- Ellipse and circle demo for deep

package.path = package.path .. ";../?.lua"
require "deep"


function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end

function love.load()
	yellow = {255, 255, 0}
	cx, cy = 120, 120
	r = 50
	smallR = 5
end

function love.draw()
	for i = -r, r do
		for j = -r, r do
			if i*i + j*j == r*r then
				if (math.random(2) == 1) then
					deep:ellipseC(yellow, "fill", i + cx, j + cy, 6, smallR / 2, smallR * 2)
				else
					deep:circleC(yellow, "fill", i + cx, j + cy, 6, smallR)
				end
			end
		end
	end

	deep:rectangleC({255, 0, 0}, "fill", cx - 60, cy - 60, 5, 120, 120)
	deep:circleC({0, 0, 255}, "fill", cx, cy, 1, 60*math.sqrt(2))

	deep:draw()
end