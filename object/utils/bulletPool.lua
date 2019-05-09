BulletPool = Object:extend()

function BulletPool:new(scene, world, count, tag)
  self._bullets = {}
  
  for i=1,count do
    local bullet = Bullet(scene, world, tag)
    table.insert(self._bullets, bullet)
    scene:addEntity(bullet)
  end
end

function BulletPool:getBullet()
  local bullet = table.remove(self._bullets, 1)
  table.insert(self._bullets, bullet)
  bullet:setAlive(true)
  return bullet
end