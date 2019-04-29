Bullet = Entity:extend()

function Bullet:new(scene, world, x, y)
  Bullet.super.new(self, scene, world, 0, 0, 0.5, 0.5)
end

function Bullet:boop(x, y, dx, dy)
  self:setAlive(true)
  self.x, self.y = x, y
  self:move(dx, dy)
end

function Bullet:setAlive(value)
  if value then
    if not self.world:hasItem(self) then
      self.world:add(self.x, self.y, self.w, self.h)
    end
  else
    if self.world:hasItem(self) then
      self.world:remove(self)
    end
  end
end

function Bullet:filter(item, other)
  
  if item then
    if item:is(Player) then
      return "cross"
    else
      return "bounce"
    end
  end
end