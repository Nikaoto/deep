deep = {}
local drawQueue = {}

-- Stores default values for queue function
local defaults = {
	z = 0, r = 0, 
	sx = 1, sy = 1, 
	ox = 0, oy = 0, 
	kx = 0, ky = 0, 
	color = {255, 255, 255, 255}
}

local color = defaults.color

function deep:setColor(c, ...)
	if c == nil then
		color = defaults.color
		return
	end

	local n = select("#", ...)

	if n == 0 then
		if #c < 5 and #c >2 then
			color = c
		end
	elseif n > 1 and n < 4 then
		color = {c, select(1, ...), select(2, ...), select(3, ...)}
	end
end

function deep:getColor()
	return color[1], color[2], color[3], color[4]
end

-- Rereate drawQueue if needed
local function renewQueue()
	if (drawQueue == nil) then
		drawQueue = {}
	end
end

-- Takes table __call function and z index and inserts it into drawQueue
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

function deep:queueS(shader, drawable, x, y, z, r, sx, sy, ox, oy, kx, ky)
	renewQueue()

	z = z or defaults.z
	r = r or defaults.r
	sx = sx or defaults.sx; sy = sy or defaults.sy
	ox = ox or defaults.ox; oy = oy or defaults.oy
	kx = kx or defaults.ks; ky = ky or defaults.ky

	local temp = {shader, drawable, x, y, r, sx, sy, ox, oy, kx, ky}
	setmetatable(temp, {__call = function () 
			love.graphics.setShader(temp[1])
			love.graphics.draw(temp[2], temp[3], temp[4], temp[5],
				temp[6], temp[7], temp[8], temp[9], temp[10], temp[11], temp[12]) 
			love.graphics.setShader()
		end})

	enqueue(temp, z)
end

function deep:rectangleC(c, mode, x, y, z, width, height)
	renewQueue()

	local temp = {mode, x, y, width, height}
	setmetatable(temp, {__call = function()
			love.graphics.setColor(c)
			love.graphics.rectangle(temp[1], temp[2], temp[3], temp[4], temp[5])
			love.graphics.setColor(defaults.color)
		end})

	enqueue(temp, z)
end

function deep:rectangle(mode, x, y, z, width, height)
	self:rectangleC(color, mode, x, y, z, width, height)
end

function deep:printC(c, text, x, y, z, r, sx, sy, ox, oy, kx, ky)
	renewQueue()

	z = z or defaults.z
	r = r or defaults.r
	sx = sx or defaults.sx; sy = sy or defaults.sy
	ox = ox or defaults.ox; oy = oy or defaults.oy
	kx = kx or defaults.kx;	ky = ky or defaults.ky

	local temp = {text, x, y, r, sx, sy, ox, oy, kx, ky}
	setmetatable(temp, {__call = function()
			love.graphics.setColor(c)
			love.graphics.print(temp[1], temp[2], temp[3], temp[4], temp[5], 
				temp[6], temp[7], temp[8], temp[9], temp[10])
			love.graphics.setColor(defaults.color)
		end})

	enqueue(temp, z)
end

function deep:print(text, x, y, z, r, sx, sy, ox, oy, kx, ky)
	self:printC(color, text, x, y, z, r, sx, sy, ox, oy, kx, ky)
end

function deep:line(x1, y1, x2, y2, z)
	self:lineC(color, x1, y1, x2, y2, z)
end

function deep:lineC(overrideColor, x1, y1, x2, y2, z)
	renewQueue()

	z = z  or defaults.z

	local temp = {x1, y1, x2, y2}
	setmetatable(temp, {__call = function()
			love.graphics.setColor(overrideColor)
			love.graphics.line(temp[1], temp[2], temp[3], temp[4])
			love.graphics.setColor(defaults.color)
		end})

	enqueue(temp, z)
end

function deep:circleC(c, mode, x, y, z, radius, segments)
	renewQueue()

	z = z or defaults.z

	local temp = {mode, x, y, radius, segments}
	setmetatable(temp, {__call = function()
			love.graphics.setColor(c)	
			love.graphics.circle(temp[1], temp[2], temp[3], temp[4], temp[5])
			love.graphics.setColor(defaults.color)
		end})

	enqueue(temp, z)
end

function deep:circle(mode, x, y, z, radius, segments)
	self:circleC(color, mode, x, y, z, radius, segments)
end

function deep:ellipseC(c, mode, x, y, z, radiusx, radiusy)
	renewQueue()

	z = z or defaults.z

	local temp = {mode, x, y, radiusx, radiusy}
	setmetatable(temp, {__call = function()
			love.graphics.setColor(c)
			love.graphics.ellipse(temp[1], temp[2], temp[3], temp[4], temp[5])	
			love.graphics.setColor(defaults.color)
		end})

	enqueue(temp, z)
end

function deep:ellipse(mode, x, y, z, radiusx, radiusy)
	self:ellipsec(color, mode, x, y, z, radiusx, radiusy)
end

local function reset()
	color = defaults.color
	drawQueue = {}
end

-- Draws every queued object in order of their Z axii
function deep:draw()
	-- Check if draw color was directly changed and revert to deep's color
	if love.graphics.getColor() ~= deep:getColor() then
		love.graphics.setColor(deep:getColor())
	end

	-- Draw everything in queue
	for k, v in pairs(drawQueue) do
		for _, o in pairs(v) do
			o()
		end
	end

	-- Reset queue and color for next draw loop
	reset()
end
