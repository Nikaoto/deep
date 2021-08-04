local deep = {
  _VERSION = "deep v2.0.3",
  _DESCRIPTION = "Queue and execute actions in sequence (can add Z axis to 2D graphics frameworks)",
  _URL = "https://github.com/Nikaoto/deep",
  _LICENSE = [[
  Copyright (c) 2017 Nikoloz Otiashvili

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
  ]]
}

local execQueue = {}

-- for compatibility with Lua 5.1/5.2
local unpack = rawget(table, "unpack") or unpack

deep.queue = function(i, fun, ...)
  if type(i) ~= "number" then
    print("Error: deep.queue(): passed index is not a number")
    return nil
  end

  if type(fun) ~= "function" then
    print("Error: deep.queue(): passed action is not a function")
    return nil
  end

  local arg = { ... }
  
  if arg and #arg > 0 then
    local t = function() return fun(unpack(arg)) end

    if execQueue[i] == nil then
      execQueue[i] = { t }
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
  if next(execQueue) then
    local keys = {}
    
    for k, v in pairs(execQueue) do
      keys[#keys + 1] = k
    end
    
    table.sort(keys)
    
    for k = 1, #keys do
      for _, fun in ipairs(execQueue[keys[k]]) do
        fun()
      end
    end
    
    execQueue = {}
  end
end

return deep
