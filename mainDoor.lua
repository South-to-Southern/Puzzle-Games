local Interactive = require("Lua/module/interactive")
local Animation = require("Lua/module/animation")
local GameManager = require("Lua/game")
local UIObject = require("Lua/module/uiObject")
local FloatTip = require("Lua/module/floatTip")
local AudioPlayer = require("Lua/module/audio")
local DoorImage = require("Lua/resource").MainDoor

--- 正门
local MainDoor = {}

--- @param _parent Scene
function MainDoor.Get(_parent)
    --- @type Interactive
    local door =
        Interactive:new("MainDoor", DoorImage.Door, DoorImage.Door, _parent, Vector2(420, 730), Vector2(1305, -25), nil)
    local animation = Animation:new(door.obj, DoorImage.DoorShake, 0.1, true)
    local Maoyan = UIObject:new("Maoyan", DoorImage.Maoyan, _parent.obj.Parent, Vector2(1600, 900), Vector2.Zero)
    local maoyanAni = Animation:new(Maoyan.obj, DoorImage.MaoyanAni, 0.4, true)
    local aniPlayed = false
    local tip = FloatTip:new("爸爸他甚至都记错了我的生日！他凭什么……做我的英雄！", Maoyan.obj, Vector2(0, -325))
    tip:SetClickFunc(function()
        tip:SetVisible(false)
    end)
    local sound = AudioPlayer:new("Maoyan", DoorImage.MaoyanBGM, false)
    local count = 0
    door:SetFunc(
        function()
            if GameManager.MirrorChecked() then
                _parent:SetVisible(false)
                Maoyan:SetVisible(true)
                GameManager.StopDoorRing()
                if not aniPlayed then
                    maoyanAni:Play()
                    sound:Play()
                    aniPlayed = true
                    wait(2)
                    Maoyan:SetClickFunc(
                        function()
                            if count == 0 then
                                tip:SetText("刚刚那女人说了什么？")
                                tip:SetVisible(true)
                                count = 1
                            elseif count == 1 then
                                tip:SetText("爸爸记错了生日……？")
                                tip:SetVisible(true)
                                count = 2
                            elseif count == 2 then
                                tip:SetText("刚刚的人不见了……墙上好像写了什么？")
                                tip:SetVisible(true)
                                count = 3
                            else
                                Maoyan:SetVisible(false)
                                _parent:SetVisible(true)
                            end
                        end
                    )
                end
            else
                print("door shake")
                animation:Play()
                _parent:Tip("门打不开……", 5)
            end
        end
    )
    return door
end

return MainDoor
