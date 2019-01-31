ResourceManager = Object:extend()

function ResourceManager:new()
  self.levels = self:loadLevels('levels')
  self.options = self:loadOptions('options.cfg')
end

function ResourceManager:loadLevels(level_directory)
  local files = {}
  recursiveEnumerate(level_directory, files)
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

function ResourceManager:loadOptions(option_filepath)
  local options = {}
  
  local t = love.filesystem.read(option_filepath)
  options = json.decode(t)      
  
  return options
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