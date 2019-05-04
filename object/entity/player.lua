Player = Entity:extend()

function Player:new(scene, world, x, y)
  Player.super.new(self, scene, world, x, y, 0.75, 0.75)
  self.speed = 100
  self.bPool = BulletPool(scene, world, 10)
  
  self.fireRate = 0.2
  self._fireTimer = 0
end

function Player:update(dt)
  Player.super.update(self, dt)
  
  self._fireTimer = self._fireTimer + dt
end

function Player:draw()
  love.graphics.setColor(0, 0, 1)
  love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

function Player:shoot(dx, dy)
  if self._fireTimer >= self.fireRate then
    local bullet1 = self.bPool:getBullet()
    local bullet2 = self.bPool:getBullet()
    local cx, cy = self.x + (self.w-bullet1.w)/2, self.y + (self.h-bullet1.h)/2
    bullet1:boop(cx-TILE_SIZE*0.7, cy, dx, dy)
    bullet2:boop(cx+TILE_SIZE*0.7, cy, dx, dy)
    self._fireTimer = 0
  end
end

function Player:filter(item, other)
  if type(item)=="number" then
    return "bounce"
  else
    return "cross"
  end
end

function Player:__tostring()
  return "Player at " .. math.floor(self.x) .. " " .. math.floor(self.y)
end