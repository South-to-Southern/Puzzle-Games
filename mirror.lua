local Animation = require("Lua/module/animation")
local Interactive = require("Lua/module/interactive")
local AudioPlayer = require("Lua/module/audio")
local MirrorImage = require("Lua/resource").Mirror
local GameManager = require("Lua/game")

local Mirror = {}

--- @param _parent Scene
function Mirror.Get(_parent)
    local mirror = Interactive:new("Mirror", "", MirrorImage.Mirror, _parent, Vector2(190, 640), Vector2(930, -90))

    local animation = Animation:new(mirror.obj, MirrorImage.MirrorAni, 0.5)

    mirror:SetAnimation(animation)

    local doorRinged = false

    local doorRing = AudioPlayer("doorRing", MirrorImage.DoorRing, true)

    GameManager.SetDoorRing(doorRing)

    local function syncMirror()
        if math.abs(mirror.obj.Offset.X - _parent.player.obj.Offset.X) > 200 then
            world.OnRenderStepped:Disconnect(syncMirror)
            animation.t = MirrorImage.MirrorAni
            return
        end
        if _parent.player.faceLeft == true then
            animation.t = MirrorImage.MirrorPlayerAniRight
        else
            animation.t = MirrorImage.MirrorPlayerAniLeft
        end
    end

    mirror:SetFunc(
        function()
            world.OnRenderStepped:Connect(syncMirror)
            GameManager.CheckMirror()
            _parent:Tip("这是我吗……？为什么看起来这么陌生，我是谁？", 3)
            if doorRinged == false then
                doorRing:Play()
                doorRinged = true
            end
        end
    )

    return mirror
end

return Mirror
