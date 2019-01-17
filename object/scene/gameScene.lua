GameScene = Scene:extend()

function GameScene:new()
  self.t = 0
end

function GameScene:update(dt)
  self.t = self.t + dt
end

function GameScene:draw()
  love.graphics.print("I am a game"..self.t, 100, 100)
end

function GameScene:keyPressed(key)
  self.t = self.t - 1
end