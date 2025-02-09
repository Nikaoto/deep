--[[
   deep v3.1.0
   Add layers or z axis to 2D graphics.
   https://github.com/Nikaoto/deep

   License (MIT):
   Copyright (c) 2023 Nikoloz Otiashvili

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the "Software"), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:
   
   The above copyright notice and this permission notice shall be included in
   all copies or substantial portions of the Software.
   
   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
   SOFTWARE.
]]--

local deep = {}

function deep:new()
   local instance = {
      r = {},
      z_min = nil,
      z_max = nil,
      q = {},
   }
   setmetatable(instance, self)
   self.__index = self
   return instance
end

function deep:queue(z, fn)
   if not self.q[z] then
      self.q[z] = {}
   end

   table.insert(self.q[z], fn)

   if not self.z_min or not self.z_max then
      self.z_min = z
      self.z_max = z
   elseif z < self.z_min then
      self.z_min = z
   elseif z > self.z_max then
      self.z_max = z
   end
end

function deep:draw(z_from, z_to)
   local from, to
   if z_from and z_to then
      if z_from > z_to then
         printf("z_from (%i) can't be larger than z_to (%i)", z_from, z_to)
         return
      end
   
      if z_from > self.z_max or z_to < self.z_min then
         -- Nothing to draw
         return
      end
   
      from = math.max(z_from, self.z_min)
      to = math.min(z_to, self.z_max)
   else
      from = self.z_min
      to = self.z_max
   end

   -- Nothing queued, nothing to draw
   if not from or not to then
      return
   end

   if from > to then
      -- Nothing to draw
      return
   end

   for i=from, to do
      local fns = self.q[i]
      if fns then
         for _, fn in ipairs(fns) do
            fn()
         end
      end
   end

   self.q = {}
end

return deep
