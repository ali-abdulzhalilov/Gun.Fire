MenuScene = Scene:extend()

function MenuScene:new()
  self.t = 0
end

function MenuScene:update(dt)
  self.t = self.t + dt
end

function MenuScene:draw()
  love.graphics.print("Hello, World!"..self.t, 100, 100)
end

function MenuScene:keyPressed(key)
  self.t = self.t - 1
end