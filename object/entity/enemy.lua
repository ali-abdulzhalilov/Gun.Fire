Enemy = Entity:extend()

function Enemy:new(scene, world)
  Enemy.super.new(self, scene, world, 0, 0, 0.75, 0.75)
  self.speed = 100
  self.waypoints = {}
  self.currentWaypointIndex = 1
  self.dist = 10
  
  self.fireRate = 0.3
  self._fireTimer = 0
  self:die()
end

function Enemy:addWaypoint(x, y)
  table.insert(self.waypoints, {x, y})
  return self
end

function Enemy:moveTo(pos)
  local x, y = pos[1], pos[2]
  local dx, dy = x - self.x, y - self.y
  local ndx, ndy = normalizeVector(dx, dy)
  self:move(ndx, ndy)
end

function Enemy:shoot()
  local bullet = self.scene.enemyBulletPool:getBullet()
  local cx, cy = self.x + (self.w-bullet.w)/2, self.y + (self.h-bullet.h)/2
  
  local dx, dy = normalizeVector(self.scene.player.x-self.x, self.scene.player.y-self.y)
  
  bullet:boop(cx, cy, dx, dy)
  self._fireTimer = 0
end

function Enemy:spawn(x, y)
  if not self.world:hasItem(self) then
    self.world:add(self, x, y, self.w, self.h)
  end
  
  self.x, self.y = x, y
  self.world:update(self, x, y)
  self.currentWaypointIndex = 1
  self._fireTimer = 0
  
  return self
end

function Enemy:die()
  if self.world:hasItem(self) then
    self.world:remove(self)
  end
end

function Enemy:update(dt)
  if self.world:hasItem(self) then
    Enemy.super.update(self, dt)
    
    local pos = self.waypoints[self.currentWaypointIndex]
    self:moveTo(pos)
    if math.sqrt(math.pow(self.x-pos[1],2)+math.pow(self.y-pos[2], 2)) < self.dist then
      if self.currentWaypointIndex == #self.waypoints then
        self:die()
      else
        self.currentWaypointIndex = self.currentWaypointIndex + 1
      end
    end
    
    self._fireTimer = self._fireTimer + dt
    if self._fireTimer >= self.fireRate then
      self:shoot()
    end
  end
end

function Enemy:draw()
  if self.world:hasItem(self) then
    love.graphics.setColor(1, 0.5, 0)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
  end
end

function Enemy:filter(item, other)
  if type(item)=="number" then
    return "bounce"
  else
    return "cross"
  end
end

function Enemy:__tostring()
  return "Enemy at " .. math.floor(self.x) .. " " .. math.floor(self.y)
end