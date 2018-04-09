-- example1
-- Demonstrates how DEEP can be used effectively
package.path = package.path .. ";../../?.lua"
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
		z = 3,
		move = function (self, x, y)
			player.x = player.x + x
			player.y = player.y + y	
		end
	}
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
	local dx, dy = 0, 0
	if love.keyboard.isDown("up") then
		dy = dy - player.speed * dt
	end

	if love.keyboard.isDown("down") then
		dy = dy + player.speed * dt
	end

	if love.keyboard.isDown("left") then
		dx = dx - player.speed * dt
	end

	if love.keyboard.isDown("right") then
		dx = dx + player.speed * dt
	end

	player:move(dx, dy)
end

-- W and S used to move player through layers
function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	elseif key == "w" then
		player.z = player.z - 1
	elseif key == "s" then
		player.z = player.z + 1
	end
end

function love.draw()
	-- Queue up four objects and draw them 50 times
	-- Take note of the first argument of deep.queue - (the z axis); 
	for i = 1, 100, 2 do
		deep.queue(4, love.graphics.draw, blueSquare.sprite, blueSquare.x + i*2, blueSquare.y - i*2)
		deep.queue(2, love.graphics.draw, greenSquare.sprite, blueSquare.x - i*2, blueSquare.y - i*2)
		deep.queue(2, love.graphics.draw, greenSquare.sprite, greenSquare.x - i*2, greenSquare.y - i*2)
		deep.queue(4, love.graphics.draw, blueSquare.sprite, greenSquare.x + i*2, greenSquare.y - i*2)
	end

	-- Queueing multiple actions is perfect for setting colors
	for i = 1, 100, 2 do
		deep.queue(5, function() 
			love.graphics.setColor(1, 1, 0) -- Yellow
			love.graphics.rectangle("fill", 50 + i*6, 210 + i, 50, 50)
			love.graphics.setColor(1, 1, 1) -- Reset to white
		end)
	end
	
	-- This method is NOT recommended. Negatively affects performance and code readability.
	-- Use deep like the the previous loop uses when specifying the same Z index
	for i = 1, 100, 2 do
		deep.queue(3, love.graphics.setColor, 1, 0.647, 0) -- Orange
		deep.queue(3, love.graphics.rectangle, "fill", 50 + i*6, 110 + i, 50, 50)
		deep.queue(3, love.graphics.setColor, 1, 1, 1) -- Reset to white
	end

	-- Queue up the player
	deep.queue(player.z, love.graphics.draw, player.sprite, player.x, player.y)

	-- Draw everything in the queue
	deep.execute()
	--Notice how the queue order is mixed up, but everything gets drawn according to their Z axis

	-- FPS timer to check performance
	-- (anything drawn directly will depend on the draw call being before or after deep.execute())
	love.graphics.print(love.timer.getFPS().."FPS")
	-- Because this draw call is after deep.execute() it draws over everything
end
