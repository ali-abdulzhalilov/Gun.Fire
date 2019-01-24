ResourceManager = Object:extend()

function ResourceManager:new()
  self.levels = {}
  
  local files = {}
  recursiveEnumerate('levels', files)
  self:loadLevels(files)
end

function ResourceManager:loadLevels(files)
  for _, file in ipairs(files) do
    --local name = strSplit(file:sub(1,-5), "/")
    local name = string.split(file:sub(1,-5), "/")
    name = name[#name]
    
    local t = love.filesystem.read(file)
    t = json.decode(t)
    
    self.levels[name] = t
  end
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