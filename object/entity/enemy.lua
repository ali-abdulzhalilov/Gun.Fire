Enemy = Entity:extend()

function Enemy:new(scene, world, x, y)
  Enemy.super.new(self, scene, world, x, y, 0.75, 0.75)
  self.speed = 100
end

function Enemy:draw()
  love.graphics.setColor(1, 0.5, 0)
  love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end


function Enemy:filter(item, other)
  --if type(item)=="number" then
  --  return "bounce"
  --else
  --  return "cross"
  --end
end