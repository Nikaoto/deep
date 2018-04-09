-- example2
-- Fills the screen with randomly colored rectangles
-- Demonstrates how much impact DEEP has on performance
package.path = package.path .. ";../?.lua"
local deep = require "deep"

local shouldDrawWithDeep = true

function love.load()
	love.window.setFullscreen(true)
	width, height = love.graphics.getDimensions()
	xs = 50
	ys = 50
end

-- Draws everything the LOVE way
-- This reaches 1 FPS at sx = 1140 and sy = 1240 
function lovedraw()
	local sw = width / xs
	local sh = height / ys

	for x = 1, width, sw do
		for y = 1, height, sh do
			love.graphics.setColor(randColor())
			love.graphics.rectangle("fill", x, y, sw, sh)
		end 
	end

	drawOverlay()
end

-- Draws everything using DEEP
-- This reaches 1 FPS at sx = 580 and sy = 780 
function deepdraw()
	local sw = width / xs
	local sh = height / ys

	for x = 1, width, sw do
		for y = 1, height, sh do
			deep:rectangleC({randColor()}, "fill", x, y, 1, sw, sh)
		end 
	end

	-- Draw everything in the queue
	deep:drawAll()

	drawOverlay()
end

function drawOverlay()
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("fill", 0, 0, 150, 60)
	love.graphics.setColor(0, 0, 0)
	love.graphics.print(love.timer.getFPS().."FPS")
	love.graphics.print("\n"..ys.." rects vertically")
	love.graphics.print("\n\n"..xs.." rects horizontally")
	love.graphics.print("\n\n\nDEEP:"..tostring(shouldDrawWithDeep))
end

function love.draw()
	if shouldDrawWithDeep then
		deepdraw()
	else
	 	lovedraw()
	end
end

function randColor()
	return math.random(0, 255), math.random(0, 255), math.random(0, 255)
end

function love.keypressed(key)
	if key == "space" then
		shouldDrawWithDeep = not shouldDrawWithDeep
	elseif key == "escape" then
		love.event.quit()
	elseif key == "up" then
		ys = ys + 10
	elseif key == "down" then
		ys = ys - 10
	elseif key == "left" then
		xs = xs - 10
	elseif key == "right" then
		xs = xs + 10
	end	
end