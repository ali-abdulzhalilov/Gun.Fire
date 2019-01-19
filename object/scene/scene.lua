Scene = Object:extend()

function Scene:new() end
function Scene:input() end
function Scene:update(dt) end
function Scene:draw() end

function Scene:onEnter() end
function Scene:onExit() end

function Scene.setScene(next_scene) 
  if next_scene then
    if scene then
      scene:onExit()
    end
    scene = next_scene
    scene:onEnter()
  end
end