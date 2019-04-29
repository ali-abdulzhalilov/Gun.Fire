GameScene = Scene:extend()

function GameScene:new(level_name)
  self.world = bump.newWorld(TILE_SIZE)
  self.player = Player(self, self.world, 100, 100)
  self.bullet = Bullet(self, self.world)
  
  self.progress = 0
  self.scroll_speed = 1
  
  self.level = r.levels[level_name]
  self.map = Map(self.world, self.level["map"])
  self.width = 16
  self.height = 16
  
  self.world:add("top", 0, -TILE_SIZE, self.width*TILE_SIZE, TILE_SIZE)
  self.world:add("bottom", 0, self.height*TILE_SIZE, self.width*TILE_SIZE, TILE_SIZE)
  self.world:add("left", -TILE_SIZE, 0, TILE_SIZE, self.height*TILE_SIZE)
  self.world:add("right", self.width*TILE_SIZE, 0, TILE_SIZE, self.height*TILE_SIZE)
end

function GameScene:input()
  local dx = 0
  if input:down("left") then dx = dx - 1 end
  if input:down("right") then dx = dx + 1 end
  
  local dy = 0
  if input:down("up") then dy = dy - 1 end
  if input:down("down") then dy = dy + 1 end
  
  self.player:move(dx, dy)
  if input:down("go") then self.player:shoot(1, 1) end
end

function GameScene:update(dt)
  self.progress = self.progress + self.scroll_speed * dt
  self.map:update(self.progress)
  self.player:update(dt)
  self.bullet:update(dt)
end

function GameScene:draw()
  self.map:draw(self.progress)
  self.player:draw()
  self.bullet:draw()
  love.graphics.print(self.progress, 0, 0)
end

function GameScene:onEnter() 
  self.progress = 0
  love.window.setMode(self.width * TILE_SIZE, self.height * TILE_SIZE)
end