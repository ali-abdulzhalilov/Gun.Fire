Player = Entity:extend()

function Player:new(scene, world, x, y)
  Player.super.new(self, scene, world, x, y, 0.75, 0.75)
  self.speed = 100
end

function Player:shoot(dx, dy)
  self.scene.bullet:boop(self.x, self.y, dx, dy)
end

function Player:filter(item, other)
  print("p "..item)
  if item then
    if item:is(Bullet) then
      return "cross"
    end
  end
  
  return "bounce"
end