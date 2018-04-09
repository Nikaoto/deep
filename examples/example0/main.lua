-- example0
-- Demonstrates how DEEP can be used for drawing in 2.5D
package.path = package.path .. ";../../?.lua"
local deep = require "../deep"

function love.load()
	Y_MOVE_MOD = 0.85 -- For the illusion of moving forward or backward, slows vertical movement

	player = {
		speed = 350,
		x = 300,
		y = 80,
		z = 180,
		width = 80,
		height = 80
	}
end

-- Handling player controls
function love.update(dt)
	local dx = 0
	local dy = 0

	if love.keyboard.isDown("up") then
		dy = dy - player.speed * dt * Y_MOVE_MOD
	end

	if love.keyboard.isDown("down") then
		dy = dy + player.speed * dt * Y_MOVE_MOD
	end

	if love.keyboard.isDown("left") then
		dx = dx - player.speed * dt
	end

	if love.keyboard.isDown("right") then
		dx = dx + player.speed * dt
	end

	player.x = player.x + dx
	player.y = player.y + dy
	player.z = math.ceil(player.y + player.height)
	-- adding player.height basically sets the z to be where the square stands
	-- generally, you'd want to add the object's origin y instead of height here
end

function love.draw()
	-- (color, mode, x, y, z, width, height)
	deep.queue(150, function()
		love.graphics.setColor(1, 1, 0)
		love.graphics.rectangle("fill", 0, 100, 500, 50)
	end)

	deep.queue(190, function()
		love.graphics.setColor(0, 1, 0)
		love.graphics.rectangle("fill", 300, 140, 500, 50)
	end)

	-- Blue
	deep.queue(230, function()
		love.graphics.setColor(0, 0, 1)
		love.graphics.rectangle("fill", 0, 180, 500, 50)
	end)

	-- Cyan
	deep.queue(270, function()
		love.graphics.setColor(0, 1, 1)
		love.graphics.rectangle("fill", 300, 220, 500, 50)
	end)

	-- Queue the player (red cube)
	deep.queue(player.z, function()
		love.graphics.setColor(1, 0, 0)
		love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
	end)
	
	-- Draw everything in the queue
	deep.execute()
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end