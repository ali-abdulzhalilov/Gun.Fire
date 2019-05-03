Player = Entity:extend()

function Player:new(scene, world, x, y)
  Player.super.new(self, scene, world, x, y, 0.75, 0.75)
  self.speed = 100
end

function Player:draw()
  love.graphics.setColor(0, 0, 1)
  love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

function Player:shoot(dx, dy)
  self.scene.bullet:boop(self.x, self.y, dx, dy)
end

function Player:filter(item, other)
  --if item and not type(item)=="nil" then
  --  if type(item)=="number" then
  --    return "bounce"
  --  elseif item:is(Bullet) then
  --    return "cross"
  --  else
  --    return "bounce"
  --  end
  --end
  if type(item)=="number" then
    return "bounce"
  else
    return "cross"
  end
end