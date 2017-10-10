-- main.lua
-- Fills the screen with randomly colored rectangles
-- Demonstrates how much impact DEEP has on performance
package.path = package.path .. ";../?.lua"
require "deep"

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

	love.graphics.setColor(0, 0, 0)
	-- FPS timer to check performance
	love.graphics.print(love.timer.getFPS().."FPS")
	love.graphics.print("\n"..ys.." rects vertically")
	love.graphics.print("\n\n"..xs.." rects horizontally")
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
	deep:draw()

	-- FPS timer to check performance
	love.graphics.print(love.timer.getFPS().."FPS")
	love.graphics.print("\n"..ys.." rects vertically")
	love.graphics.print("\n\n"..xs.." rects horizontally")
end

function love.draw()
	deepdraw()
	--lovedraw()
end

function randColor()
	return math.random(0, 255), math.random(0, 255), math.random(0, 255)
end

function love.keypressed(key)
	if key == "escape" then
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