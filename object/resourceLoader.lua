ResourceManager = Object:extend()

function ResourceManager:new()
  levels = {}
  local levels = {}
  recursiveEnumerate('levels', levels)
  printStuff(levels)
end

function printStuff(files)
  for _, file in ipairs(files) do
    print(file..":")
    for line in love.filesystem.lines(file) do
      print(line)
    end
  end
end