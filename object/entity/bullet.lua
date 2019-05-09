Bullet = Entity:extend()

function Bullet:new(scene, world, tag)
  Bullet.super.new(self, scene, world, 0, 0, 0.4, 0.4)
  self:setAlive(false)
  self.name = getUID()
  self.speed = 250
  self.tag = tag
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
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("fill", self.x+self.w/2, self.y+self.h/2, self.w/2, self.h/2)
    love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
  end
end

function Bullet:resolve(cols, len)
  for i=1,len do
    if type(cols[i].other)=="number" then
      self:setAlive(false)
    elseif cols[i].other.is then
      if cols[i].other:is(Enemy) and self.tag=="player" then
        cols[i].other:die()
      elseif cols[i].other:is(Player) and self.tag=="enemy" then
        --print("pep")
      end
    end
  end
end

function Bullet:__tostring()
  return "Bullet " .. self.name .. " at " .. math.floor(self.x) .. " " .. math.floor(self.y)
end