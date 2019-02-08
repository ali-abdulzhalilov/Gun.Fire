Map = Object:extend()

function Map:new(world, map)
  self.world = world
  self.map = map
  
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

function Map:update(progress)
  local p = progress - love.graphics:getHeight()/TILE_SIZE
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

function Map:draw(progress)
  local p = progress - love.graphics:getHeight()/TILE_SIZE
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