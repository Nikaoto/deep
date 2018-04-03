local deep = {}

local execQueue = {}
local maxIndex = 1

-- for compatibility with Lua 5.1/5.2
local unpack = rawget(table, "unpack") or unpack

deep.queue = function(i, fun, ...)
  if i == nil then
    print("Error: deep.queue(): passed index is nil")
    return nil
  end

  if fun == nil then
    print("Error: deep.queue(): passed function is nil")
    return nil
  end
  --

  local arg = { ... }
  if i < 1 then i = 1 end
  if i > maxIndex then maxIndex = i end

  if arg and #arg > 0 then
    if execQueue[i] == nil then
      execQueue[i] = { function() return fun(unpack(arg)) end }
    else
      table.insert(execQueue[i], t)
    end
  else
    if execQueue[i] == nil then
      execQueue[i] = { fun }
    else
      table.insert(execQueue[i], fun)
    end
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