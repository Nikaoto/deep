deep = {}
local drawQueue = {}

-- Stores default values for queue function
local defaults = {z = 0, r = 0, sx = 1, sy = 1, ox = 0, oy = 0, kx = 0, ky = 0}

-- Queues up an object to draw according to its Z axis
function deep:queue(drawable, x, y, z, r, sx, sy, ox, oy, kx, ky)
	-- Create new table if first queue in draw loop
	if (drawQueue == nil) then
		drawQueue = {}
	end

	z = z or defaults.z
	r = r or defaults.r
	sx = sx or defaults.sx; sy = sy or defaults.sy
	ox = ox or defaults.ox; oy = oy or defaults.oy
	kx = kx or defaults.ks; ky = ky or defaults.ky

	if (drawQueue[z] == nil) then
		drawQueue[z] = {{drawable, x, y, r, sx, sy, ox, oy, kx, ky}}
	else
		table.insert(drawQueue[z], {drawable, x, y, r, sx, sy, ox, oy, kx, ky})
	end
end

-- Draws every queued object in order of their Z axii
function deep:draw()
	for k, v in pairs(drawQueue) do
		for _, o in pairs(v) do
			love.graphics.draw(o[1], o[2], o[3], o[4], o[5], o[6], o[7], o[8], o[9], o[10])
		end
	end
	drawQueue = {}
end