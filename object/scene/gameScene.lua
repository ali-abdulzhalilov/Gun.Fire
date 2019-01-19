require "object/scene/scene"
GameScene = Scene:extend()

function GameScene:new()
  self.player = Player(100, 100)
  
  self.progress = 0
  self.scroll_speed = 1
  
  self.map = {}
  for i=1,19 do
    local row = {}
    for j=1,width do
      table.insert(row, i..j)
    end
    table.insert(self.map, row)
  end
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
  
  self.progress = self.progress + dt
end

function GameScene:draw()
  self.player:draw()
  love.graphics.print(self.progress, 0, 0)
  local p = self.progress * self.scroll_speed + height + 1
  for i=1,#self.map do
    local row = self.map[i]
    for j=1,#row do
      local y = (i-1+p)%#self.map
      love.graphics.print(row[j], 
        (j-1)*TILE_SIZE, 
        (y-1)*TILE_SIZE)
    end
  end
end