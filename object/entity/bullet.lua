Bullet = Entity:extend()

function Bullet:new(scene, world, x, y)
  Bullet.super.new(self, scene, world, 0, 0, 0.5, 0.5)
  self:setAlive(false)
end

function Bullet:boop(x, y, dx, dy)
  self:setAlive(true)
  self.x, self.y = x, y
  self.world:update(self, x, y)
  self:move(dx, dy)
end

function Bullet:setAlive(value)
  if value then
    if not self:isAlive() then
      self.world:add(self, self.x, self.y, self.w, self.h)
    end
  else
    if self:isAlive() then
      self.world:remove(self)
    end
  end
end

function Bullet:isAlive()
  return self.world:hasItem(self)
end 

function Bullet:update(dt)
  if self:isAlive() then
    Bullet.super.update(self, dt)
  end
end

function Bullet:draw()
  if self:isAlive() then
    Bullet.super.draw(self, dt)
  end
end

function Bullet:filter(item, other)
  --if type(item)=="number" then
    --return "touch"
  --else
    return "cross"
  --end
end

function Bullet:resolve(cols, len)
  for i=1,len do
    if type(cols[i].other)=="number" then
      self:setAlive(false)
    end
  end
end