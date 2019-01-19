Player = Object:extend()

function Player:new(x, y)
  self.x = x or 0
  self.y = y or 0
  self.vx = 0
  self.vy = 0
  self.ax = 0
  self.ay = 0
  self.acc = 1.1
  self.drag = 0.9
  self.speed = 500
end

function Player:update(dt)
  self.vx = self.vx + self.ax * self.acc * dt
  self.vy = self.vy + self.ay * self.acc * dt
  self.x = self.x + self.vx * self.speed * dt
  self.y = self.y + self.vy * self.speed * dt
  
  self.vx = self.vx * self.drag
  self.vy = self.vy * self.drag
  self.ax, self.ay = 0, 0
end

function Player:draw()
  love.graphics.rectangle("line", self.x, self.y, 20, 20)
end

function Player:move(dx, dy)
  self.ax = dx
  self.ay = dy
end