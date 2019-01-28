Tile = Object:extend()

function Tile:new(world, x, y, t)
  local type = {
    false,
    true
  }
  
  self.x = x
  self.y = y
  self.type = t
  self.wall = type[t]
  self.world = world
  if self.wall then
    self.world:add(self, self.x, self.y, TILE_SIZE, TILE_SIZE)
  end
end

function Tile:update(x, y)
  self.world:update(self, x, y)
end

function Tile:draw()
  local c = 0.2+0.3*self.type
  love.graphics.setColor(c, c, c, 1)
  love.graphics.rectangle("fill", (self.x-1)*TILE_SIZE, (self.y-1)*TILE_SIZE, TILE_SIZE, TILE_SIZE)
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.print(self.type, 
    (j-1)*TILE_SIZE, 
    (y-1)*TILE_SIZE)
end