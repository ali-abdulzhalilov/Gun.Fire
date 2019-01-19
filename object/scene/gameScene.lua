require "object/scene/scene"
GameScene = Scene:extend()

function GameScene:new()
  self.player = Player(100, 100)
end

function GameScene:update(dt)
  local dx = 0
  if input:down("left") then dx = dx - 1 end
  if input:down("right") then dx = dx + 1 end
  
  local dy = 0
  if input:down("up") then dy = dy - 1 end
  if input:down("down") then dy = dy + 1 end
  
  self.player:move(dx, dy)
  
  self.player:update(dt)
end

function GameScene:draw()
  self.player:draw()
end