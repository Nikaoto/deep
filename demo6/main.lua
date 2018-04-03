package.path = package.path .. ";../?.lua"
local deep = require "../deep"
--

local current_z = 2
local rect = {
  x = 200,
  width = 300,
  height = 50  
}

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

  -- Red square, which can move through the z axis
  deep.queue(current_z, function()
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle("fill", 300, 80, 80, 80) -- (type, x, y, width, height)
  end)
  
  -- Draw everything in the queue
  deep.execute()

  -- Draw the current z index on top-left of the screen
  love.graphics.setColor(255, 255, 255)
  love.graphics.print("current_z is "..current_z)
end

-- Increases/decreases player z on key press
function love.keypressed(key)
  if key == "up" then
    current_z = current_z - 1
  elseif key == "down" then
    current_z = current_z + 1
  end
end
