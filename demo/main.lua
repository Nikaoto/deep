-- main.lua
-- Demonstrates how DEEP can be used effectively
require "deep"

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

	if love.keyboard.isDown("space") then
		deep:clear()
	end
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end

function love.draw()
	-- Queue up four objects and draw them 50 times
	-- Take note of the last argument of deep:queue - (the z axis); green cubes are at 1, blues at 3, and the player at 2
	for i = 1, 100, 2 do
		deep:queue(blueSquare.sprite, blueSquare.x + i*2, blueSquare.y - i*2, 3)
		deep:queue(greenSquare.sprite, blueSquare.x - i*2, blueSquare.y - i*2, 1)
		deep:queue(greenSquare.sprite, greenSquare.x - i*2, greenSquare.y - i*2, 1)
		deep:queue(blueSquare.sprite, greenSquare.x + i*2, greenSquare.y - i*2, 3)
	end
	-- Queue up the player
	deep:queue(player.sprite, player.x, player.y, 2)

	-- Draw everything in the queue
	deep:draw()

	-- FPS timer to check performance
	-- (anything drawn directly will draw over the queue if it's after deep:draw() and under if it's before deep:draw())
	love.graphics.print(love.timer.getFPS().."FPS")
end
