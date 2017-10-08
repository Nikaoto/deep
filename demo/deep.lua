deep = {}
local drawQueue = {}

-- Stores default values for queue function
local defaults = {z = 0, r = 0, sx = 1, sy = 1, ox = 0, oy = 0, kx = 0, ky = 0}

-- Rereate drawQueue if needed
local function renewQueue()
	if (drawQueue == nil) then
		drawQueue = {}
	end
end

local function enqueue(t, z)
	if (drawQueue[z] == nil) then
		drawQueue[z] = {t}
	else
		table.insert(drawQueue[z], t)
	end
end

-- Queues up an object to draw according to its Z axis
function deep:queue(drawable, x, y, z, r, sx, sy, ox, oy, kx, ky)
	renewQueue()

	z = z or defaults.z
	r = r or defaults.r
	sx = sx or defaults.sx; sy = sy or defaults.sy
	ox = ox or defaults.ox; oy = oy or defaults.oy
	kx = kx or defaults.ks; ky = ky or defaults.ky

	local temp = {drawable, x, y, r, sx, sy, ox, oy, kx, ky}
	setmetatable(temp, {__call = function () 
			love.graphics.draw(temp[1], temp[2], temp[3], temp[4], temp[5],
				temp[6], temp[7], temp[8], temp[9], temp[10], temp[11]) 
		end})

	enqueue(temp, z)
end

function deep:rectangle(mode, x, y, z, width, height)
	renewQueue()

	local temp = {mode, x, y, width, height}
	setmetatable(temp, {__call = function() 
			love.graphics.rectangle(temp[1], temp[2], temp[3], temp[4],temp[5]) 
		end})

	enqueue(temp, z)
end

-- Draws every queued object in order of their Z axii
function deep:draw()
	for k, v in pairs(drawQueue) do
		for _, o in pairs(v) do
			o()
		end
	end
	drawQueue = {}
end