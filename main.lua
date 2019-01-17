Object = require "lib.classic"
local bump = require "lib.bump"

function love.load()
  love.window.setMode(320, 480)
  love.keyboard.setKeyRepeat(true)
  
  require "object.scene.scene"
  require "object.scene.menuScene"
  require "object.scene.gameScene"
  
  menu = MenuScene()
  game = GameScene()
  scene = nil
  Scene.setScene(menu)
end

function love.update(dt) scene:update(dt) end 
function love.draw() scene:draw() end

function love.keypressed(key) scene:keyPressed(key) end
function love.keyreleased(key) scene:keyReleased(key) end