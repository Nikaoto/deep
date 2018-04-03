local deep = {}

local execQueue = {}
local maxIndex = 1

deep.queue = function(i, fun)
  if i < 1 then i = 1 end
  if i > maxIndex then maxIndex = i end

  if execQueue[i] == nil then
    execQueue[i] = {fun}
  else
    table.insert(execQueue[i], fun)
  end
end

deep.execute = function()
  for i = 1, maxIndex do   
    if execQueue[i] then
      for _, fun in pairs(execQueue[i]) do
        fun()
      end
    end
  end

  execQueue = {}
end

return deep