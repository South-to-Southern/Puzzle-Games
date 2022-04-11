local Interactive = require("Lua/module/interactive")
local GameManager = require("Lua/game")
local Resource = require("Lua/resource").RoomDoorInside

local RoomDoor = {}

--- @param _parent Scene
function RoomDoor.Get(_parent)
    --- @type Interactive
    local door = Interactive:new("RoomDoor",Resource.Door, Resource.Door, _parent, Vector2(420, 720), Vector2(-800,-30))

    door:SetFunc(function()
        GameManager.CallFunc("EnterLivingRoom")
    end)

    return door
end

return RoomDoor
