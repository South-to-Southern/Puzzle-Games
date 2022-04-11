local Scene = require("Lua/module/scene")
local RoomDoor = require("Lua/scenes/scene2/roomDoor")
local Table = require("Lua/scenes/scene2/table")
local Easel = require("Lua/scenes/scene2/easel")
local Resource = require("Lua/resource").BedRoom
local Drawer = require("Lua/scenes/scene2/drawer")

local module = {}

--- @param _name string
--- @param _parent Canvas
function module:Get(_name, _parent)
    local scene = Scene:new(_name, Resource.Background, _parent, Vector2(3290, 900), Vector2(-750, -150), Resource.BGM)

    scene:AddInteractive(RoomDoor.Get(scene))
    scene:AddInteractive(Table.Get(scene))
    scene:AddInteractive(Easel.Get(scene))
    scene:AddInteractive(Drawer.Get(scene))
    return scene
end

return module
