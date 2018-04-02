local deep = {}

local drawQueue = {}
local maxZ = 1

deep.queue = function(z, fun)
  if z > maxZ then maxZ = z end

  if drawQueue[z] == nil then
    drawQueue[z] = {fun}
  else
    table.insert(drawQueue[z], fun)
  end
end

deep.execute = function()
  for i = 1, maxZ do   
    if drawQueue[i] then
      for _, fun in pairs(drawQueue[i]) do
        fun()
      end
    end
  end

  drawQueue = {}
end

return deep