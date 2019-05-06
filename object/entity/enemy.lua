Enemy = Entity:extend()

function Enemy:new(scene, world)
  Enemy.super.new(self, scene, world, 0, 0, 0.75, 0.75)
  self.speed = 100
  self.waypoints = {}
  self.currentWaypointIndex = 1
  self.dist = 10
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

function Enemy:spawn(x, y)
  if not self.world:hasItem(self) then
    self.world:add(self, x, y, self.w, self.h)
  end
  
  self.x, self.y = x, y
  self.world:update(self, x, y)
  self.currentWaypointIndex = 1
  
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