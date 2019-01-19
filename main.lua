Object = require "lib.classic"
local bump = require "lib.bump"
inspect = require "lib.inspect"
Input = require "lib.input"

function love.load()
  TILE_SIZE = 32
  width = 8
  height = 12
  
  love.window.setMode(width * TILE_SIZE, height * TILE_SIZE)
  
  input = Input()
  input:bind("space", "go")
  input:bind("up", "up")
  input:bind("down", "down")
  input:bind("left", "left")
  input:bind("right", "right")
  
  local object_files = {}
  recursiveEnumerate('object', object_files)
  requireFiles(object_files)
  
  scene = nil
  menu = MenuScene()
  game = GameScene()
  Scene.setScene(menu)
end

function love.update(dt)
  scene:input()
  scene:update(dt) 
end 
function love.draw() scene:draw() end

function recursiveEnumerate(folder, file_list)
    local items = love.filesystem.getDirectoryItems(folder)
    for _, item in ipairs(items) do
        local file = folder .. '/' .. item
        if love.filesystem.isFile(file) then
            table.insert(file_list, file)
        elseif love.filesystem.isDirectory(file) then
            recursiveEnumerate(file, file_list)
        end
    end
end

function requireFiles(files)
    for _, file in ipairs(files) do
        local file = file:sub(1, -5)
        require(file)
    end
end