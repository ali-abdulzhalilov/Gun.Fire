Player = Object:extend()

function Player:new(world, x, y)
  self.world = world
  self.x = x or 0
  self.y = y or 0
  self.w = TILE_SIZE*0.75
  self.h = TILE_SIZE*0.75
  self.vx = 0
  self.vy = 0
  self.speed = 100
  self.t = 0
  
  self.world:add(self, self.x, self.y, self.w, self.h)
end

function Player:update(dt)
  local goalX = self.x + self.vx * self.speed * dt
  local goalY = self.y + self.vy * self.speed * dt
  local actualX, actualY, cols, len = self.world:move(self, goalX, goalY, self.filter)
  self.x, self.y = actualX, actualY
  self.t = self.t + dt
  for i=1,len do
    --print('collided with ' .. tostring(cols[i].other) .. " at:" .. self.t)
  end
  
  self.vx, self.vy = 0, 0
end

function Player:filter(item, other)
  return "bounce"
end

function Player:draw()
  love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
end

function Player:move(dx, dy)
  self.vx = dx
  self.vy = dy
end