package.path = package.path .. ";../?.lua"
local deep = require "../deep"
--

local player
local rectangle

function love.load()
  player = {
    x = 300,
    y = 80,
    z = 2,
    width = 80,
    height = 80
  }

  rect = {
    x = 200,
    width = 300,
    height = 50  
  }
end

function love.draw()
  -- Queue a green rectangle draw call (x = 200, y = 60, z = 2)
  deep.queue(2, function()
    love.graphics.setColor(0, 255, 0)
    love.graphics.rectangle("fill", rect.x, 60, rect.width, rect.height)
  end)

  -- Yellow rectangle. Execution index (3) affects draw order, so it acts just like the z coordinate
  deep.queue(3, function()
    love.graphics.setColor(255, 255, 0)
    love.graphics.rectangle("fill", rect.x, 100, rect.width, rect.height)
  end)

  -- Blue rectangle
  deep.queue(4, function()
    love.graphics.setColor(0, 0, 255)
    love.graphics.rectangle("fill", rect.x, 140, rect.width, rect.height)
  end)

  -- Player (red square)
  deep.queue(player.z, function()
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
  end)
  
  -- Draw everything in the queue
  deep.execute()

  -- Draw player's z index on top-left of the screen
  love.graphics.setColor(255, 255, 255)
  love.graphics.print("player.z: "..player.z)
end

-- Increases/decreases player z on key press
function love.keypressed(key)
  if key == "up" then
    player.z = player.z - 1
  elseif key == "down" then
    player.z = player.z + 1
  end
end
