GameScene = Scene:extend()

function GameScene:new(level_name)
  self.level = r.levels[level_name]
  self.width = 16
  self.height = 16
  
  self.world = bump.newWorld(TILE_SIZE)
  self.map = Map(self.world, self.level["map"])
  
  self._updateOrder = {Player, Enemy, Bullet}
  self._drawOrder = {Player, Enemy, Bullet}
  self._entities = {}
  
  self.player = Player(self, self.world, (self.width/2-0.5)*TILE_SIZE, 400)
  self.enemy = Enemy(self, self.world)
  self.enemy:spawn(200, 50)
  
  self.progress = 0
  self.scroll_speed = 1
  
  self.world:add("top", 0, -TILE_SIZE, self.width*TILE_SIZE, TILE_SIZE)
  self.world:add("bottom", 0, self.height*TILE_SIZE, self.width*TILE_SIZE, TILE_SIZE)
  self.world:add("left", -TILE_SIZE, 0, TILE_SIZE, self.height*TILE_SIZE)
  self.world:add("right", self.width*TILE_SIZE, 0, TILE_SIZE, self.height*TILE_SIZE)
end

function GameScene:addEntity(entity)
  table.insert(self._entities, entity)
end

function GameScene:input()
  local dx = 0
  if input:down("left") then dx = dx - 1 end
  if input:down("right") then dx = dx + 1 end
  
  local dy = 0
  if input:down("up") then dy = dy - 1 end
  if input:down("down") then dy = dy + 1 end
  
  self.player:move(dx, dy)
  
  local sx = 0
  local s = 0
  if input:down("pewLeft") then sx = sx - 1 s=1 end
  if input:down("pewRight") then sx = sx + 1 s=1 end
  
  if s==1 then 
    local x, y = normalizeVector(sx, -1)
    self.player:shoot(x, y) 
  end
end

function GameScene:update(dt)
  self.progress = self.progress + self.scroll_speed * dt
  self.map:update(self.progress)
  
  local t = 2
  if self.progress > t-dt/2 and self.progress < t+dt/2 then
    self.enemy:spawn(300, 200)
  end
  
  for i, class in pairs(self._updateOrder) do
    for j, entity in pairs(self._entities) do
      if entity:is(class) then
        entity:update(dt)
      end
    end
  end
end

function GameScene:draw()
  self.map:draw(self.progress)
  
  for i, class in pairs(self._drawOrder) do
    for j, entity in pairs(self._entities) do
      if entity:is(class) then
        entity:draw()
      end
    end
  end
  
  love.graphics.setColor(1, 1, 1)
  love.graphics.print(self.progress, 0, 0)
end

function GameScene:onEnter() 
  self.progress = 0
  love.window.setMode(self.width * TILE_SIZE, self.height * TILE_SIZE)
end