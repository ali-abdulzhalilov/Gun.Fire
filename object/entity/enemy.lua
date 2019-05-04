Enemy = Entity:extend()

function Enemy:new(scene, world)
  Enemy.super.new(self, scene, world, 0, 0, 0.75, 0.75)
  self.speed = 100
end

function Enemy:spawn(x, y)
  if not self.world:hasItem(self) then
    self.world:add(self, x, y, self.w, self.h)
  end
  
  self.x, self.y = x, y
  self.world:update(self, x, y)
end

function Enemy:die()
  if self.world:hasItem(self) then
    self.world:remove(self)
  end
end

function Enemy:update(dt)
  if self.world:hasItem(self) then
    Enemy.super.update(self, dt)
  end
end

function Enemy:draw()
  if self.world:hasItem(self) then
    love.graphics.setColor(1, 0.5, 0)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
  end
end

function Enemy:__tostring()
  return "Enemy at " .. math.floor(self.x) .. " " .. math.floor(self.y)
end