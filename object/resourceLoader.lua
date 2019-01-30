ResourceManager = Object:extend()

function ResourceManager:new()
  self.levels = self:loadLevels()
  
  
  
  
  self.options = {}
end

function ResourceManager:loadLevels()
  local files = {}
  recursiveEnumerate('levels', files)
  local levels = {}
  
  for _, file in ipairs(files) do
    local name = string.split(file:sub(1,-5), "/")
    name = name[#name]
    
    local t = love.filesystem.read(file)
    t = json.decode(t)
    
    levels[name] = t
  end
  
  return levels
end

function string.split(str, delim)
    local t = {}

    for substr in string.gmatch(str, "[^".. delim.. "]*") do
        if substr ~= nil and string.len(substr) > 0 then
            table.insert(t,substr)
        end
    end

    return t
end