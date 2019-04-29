Object = require "lib.classic"
bump = require "lib.bump"
inspect = require "lib.inspect"
Input = require "lib.input"
json = require "lib.json"

function love.load()
  TILE_SIZE = 32
  love.window.setMode(320, 240)
  
  local object_files = {}
  recursiveEnumerate('object', object_files)
  requireFiles(object_files)
  
  r = ResourceManager()
  
  input = Input()
  for action, keys in pairs(r.options["keys"]) do
    input:bind(keys, action)
  end
  
  scene = nil
  menu = MenuScene()
  game = GameScene("level01")
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
        local type = love.filesystem.getInfo(file).type
        if type == "file" then
          table.insert(file_list, file)
        elseif type == "directory" then
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