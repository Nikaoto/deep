local deep = {}

local drawQueue = {}
local maxIndex = 1

deep.queue = function(i, fun)
  if i < 1 then i = 1 end
  if i > maxIndex then maxIndex = i end

  if drawQueue[i] == nil then
    drawQueue[i] = {fun}
  else
    table.insert(drawQueue[i], fun)
  end
end

deep.execute = function()
  for i = 1, maxIndex do   
    if drawQueue[i] then
      for _, fun in pairs(drawQueue[i]) do
        fun()
      end
    end
  end

  drawQueue = {}
end

return deep