require "object/scene/scene"
GameScene = Scene:extend()

function GameScene:new()
  self.player = Player(100, 100)
  
  self.progress = 0
  self.scroll_speed = 1
  
  self.level = r.levels["level01"]
  print(inspect(self.level))
  self.map = self.level["map"]
  self.width = #self.map[1]
  self.height = #self.map-1
  --[[self.map = {}
  for i=1,19 do
    local row = {}
    for j=1,width do
      table.insert(row, i..j)
    end
    table.insert(self.map, row)
  end]]
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
  local p = self.progress * self.scroll_speed
  for i=1,#self.map do
    local row = self.map[i]
    local rrow = strToArr(self.map[i])
    for j=1,#row do
      local y = (i-1+p)%#self.map
      local value = rrow[j]
      local c = 0.2+0.3*value
      love.graphics.setColor(c, c, c, 1)
      love.graphics.rectangle("fill", (j-1)*TILE_SIZE, (y-1)*TILE_SIZE, TILE_SIZE, TILE_SIZE)
      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.print(value, 
        (j-1)*TILE_SIZE, 
        (y-1)*TILE_SIZE)
    end
  end
end

function GameScene:onEnter() 
  love.window.setMode(self.width * TILE_SIZE, self.height * TILE_SIZE)
end