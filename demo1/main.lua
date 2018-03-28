-- main.lua
-- Demonstrates how DEEP can be used effectively
package.path = package.path .. ";../?.lua"
local deep = require "../deep"

-- Loading tables and sprites
function love.load()
	blueSquare = {
		sprite = love.graphics.newImage("res/blue_cube.png"),
		x = 500,
		y = 300
	}
	greenSquare = {
		sprite = love.graphics.newImage("res/green_cube.png"),
		x = 250,
		y = 300
	}

	player = {
		sprite = love.graphics.newImage("res/red_cube.png"),
		speed = 350,
		x = 100,
		y = 100,
	}
	function player:move(x, y)
		player.x = player.x + x
		player.y = player.y + y
	end
end

-- For getting player input
function getInput(key)
	if love.keyboard.isDown(key) then
		return 1
	end
	return 0
end

-- Handling player controls
function love.update(dt)
	local vel = player.speed * dt
	local dx = getInput("right") - getInput("left")
	local dy = getInput("down") - getInput("up")
	player:move(dx * vel, dy * vel)
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end

function love.draw()
	-- Queue up four objects and draw them 50 times
	-- Take note of the last argument of deep:draw - (the z axis); 
	-- green cubes are at 1, blues at 3, and the player at 2
	for i = 1, 100, 2 do
		deep:draw(blueSquare.sprite, blueSquare.x + i*2, blueSquare.y - i*2, 4)
		deep:draw(greenSquare.sprite, blueSquare.x - i*2, blueSquare.y - i*2, 1)
		deep:draw(greenSquare.sprite, greenSquare.x - i*2, greenSquare.y - i*2, 1)
		deep:draw(blueSquare.sprite, greenSquare.x + i*2, greenSquare.y - i*2, 4)
	end

	-- deep:setColor() works just like love.graphics.setColor(). The color needs to be set 
	-- before queuing instead of drawing
	deep:setColor(255, 255, 0) -- Yellow
	for i = 1, 100, 2 do
		deep:rectangle("fill", 50 + i*6, 210 + i, 5, 50, 50)
	end
	
	-- You can also override the current color by calling any draw function 
	-- with a capital 'C' at the end
	for i = 1, 100, 2 do
		deep:rectangleC({255, 180, 20}, "fill", 50 + i*6, 110 + i, 3, 50, 50) -- Orange
	end

	-- Queue up the player
	deep:draw(player.sprite, player.x, player.y, 3)

	-- Draw everything in the queue
	deep:drawAll()
	--Notice how the queue order is mixed up, but everything gets drawn according to their Z axis

	-- FPS timer to check performance
	-- (anything drawn directly will depend on the draw call being before or after deep:draw())
	love.graphics.print(love.timer.getFPS().."FPS")
	-- Because this draw call is after deep:drawAll() it draws over everything
end
