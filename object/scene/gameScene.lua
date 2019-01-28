require "object/scene/scene"
GameScene = Scene:extend()

function GameScene:new(level_name)
  self.world = bump.newWorld(TILE_SIZE)
  self.player = Player(self.world, 100, 100)
  
  self.progress = 0
  self.scroll_speed = 1
  
  self.level = r.levels[level_name]
  self.map = self.level["map"]
  self:initMap()
  self.width = #self.map[1]
  self.height = 16
  
  self.world:add("top", 0, -TILE_SIZE, self.width*TILE_SIZE, TILE_SIZE)
  self.world:add("bottom", 0, self.height*TILE_SIZE, self.width*TILE_SIZE, TILE_SIZE)
  
  self.world:add("left", -TILE_SIZE, 0, TILE_SIZE, self.height*TILE_SIZE)
  self.world:add("right", self.width*TILE_SIZE, 0, TILE_SIZE, self.height*TILE_SIZE)
end

function GameScene:update(dt)
  self.progress = self.progress + dt
  self:updateMap()
  
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
  self:drawMap()
  self.player:draw()
  love.graphics.print(self.progress, 0, 0)
end

function GameScene:onEnter() 
  self.progress = 0
  love.window.setMode(self.width * TILE_SIZE, self.height * TILE_SIZE)
end

function GameScene:drawMap()
  local p = self.progress * self.scroll_speed - self.height
  for i=1,#self.map do
    local row = self.map[i]
    local t = (i-1+p)%#self.map
    local y = (t-1)*TILE_SIZE
    for j=1,#row do
      local value = row[j]
      local c = 0.25*value
      love.graphics.setColor(c, c, c, 1)
      local x = (j-1)*TILE_SIZE
      love.graphics.rectangle("fill", x, y, TILE_SIZE, TILE_SIZE)
      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.print(value, x, y)
    end
  end
end

function GameScene:updateMap()
  local p = self.progress * self.scroll_speed - self.height
  for i=1,#self.map do
    local row = self.map[i]
    local t = (i-1+p)%#self.map
    local y = (t-1)*TILE_SIZE
    for j=1,#row do
      local num = (i-1)*#self.map + j
      if self.world:hasItem(num) then
        local x = (j-1)*TILE_SIZE
        self.world:update(num, x, y)
      end
    end
  end
end

function GameScene:initMap()
  for i=1,#self.map do
    local row = self.map[i]
    for j=1, #row do
      if row[j] == 2 then
        local num = (i-1)*#self.map + j
        local x, y = (j-1)*TILE_SIZE, (i-1)*TILE_SIZE
        self.world:add(num, x, y, TILE_SIZE, TILE_SIZE)
      end
    end
  end
end