BulletPool = Object:extend()

function BulletPool:new(scene, world, count)
  self._bullets = {}
  
  for i=1,count do
    local bullet = Bullet(scene, world)
    table.insert(self._bullets, bullet)
  end
end

function BulletPool:getBullet()
  local bullet = table.remove(self._bullets, 1)
  table.insert(self._bullets, bullet)
  bullet:setAlive(true)
  return bullet
end