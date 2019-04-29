Entity = Object:extend()

function Entity:new(scene, world, x, y, w, h)
  self.scene = scene
  self.world = world
  self.x = x or 0
  self.y = y or 0
  self.w = TILE_SIZE * w or TILE_SIZE
  self.h = TILE_SIZE * h or TILE_SIZE
  self.vx = 0
  self.vy = 0
  self.speed = 100
  self.world:add(self, self.x, self.y, self.w, self.h)
end

function Entity:update(dt)
  cols, len = self:collide(dt)
  self:resolve(cols, len)
end

function Entity:draw()
  love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
end

function Entity:move(dx, dy)
  self.vx = dx
  self.vy = dy
end

function Entity:filter(item, other)
  return "bounce"
end

function Entity:collide(dt)
  local goalX = self.x + self.vx * self.speed * dt
  local goalY = self.y + self.vy * self.speed * dt
  --self.vx, self.vy = 0, 0
  
  local actualX, actualY, cols, len = self.world:move(self, goalX, goalY, self.filter)
  self.x, self.y = actualX, actualY
  
  return cols, len
end

function Entity:resolve(cols, len)
  for i=1,len do
    --print('collided with ' .. tostring(cols[i].other) .. " at:" .. self.t)
  end
end