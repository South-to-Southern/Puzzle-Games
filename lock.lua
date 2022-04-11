local UIObject = require("Lua/module/uiObject")
local InterActive = require("Lua/module/interactive")
local Animation = require("Lua/module/animation")
local AudioPlayer = require("Lua/module/audio")
local GameManager = require("Lua/game")
local lockImage = require("Lua/resource").RoomDoor

--卧室门锁

local doorlock = {}

--- @param _parent Scene
function doorlock.Get(_parent)
    local roomdoor =
        InterActive:new("roomdoor", lockImage.Door, lockImage.Door, _parent, Vector2(420, 720), Vector2(-795, -30))

    local doorOpenAni = Animation(roomdoor.obj, lockImage.DoorOpen, 0.5, true)
    
    local biglock = UIObject:new("biglock", lockImage.Lock, _parent.obj.Parent, Vector2(1600, 900), Vector2.Zero)
    biglock:SetVisible(false)

    local numbers = {}

    local buttonPressSound = AudioPlayer:new("buttonPress", lockImage.ButtonPressSound, false)

    numbers[1] = UIObject:new("number1", lockImage.LockNumbers[1], biglock.obj, Vector2(30, 50), Vector2(-115, 15))
    numbers[2] = UIObject:new("number2", lockImage.LockNumbers[2], biglock.obj, Vector2(30, 50), Vector2(-25, 15))
    numbers[3] = UIObject:new("number3", lockImage.LockNumbers[3], biglock.obj, Vector2(30, 50), Vector2(65, 15))
    numbers[4] = UIObject:new("number4", lockImage.LockNumbers[4], biglock.obj, Vector2(30, 50), Vector2(-115, -65))
    numbers[5] = UIObject:new("number5", lockImage.LockNumbers[5], biglock.obj, Vector2(30, 50), Vector2(-25, -65))
    numbers[6] = UIObject:new("number6", lockImage.LockNumbers[6], biglock.obj, Vector2(30, 50), Vector2(65, -65))
    numbers[7] = UIObject:new("number7", lockImage.LockNumbers[7], biglock.obj, Vector2(30, 50), Vector2(-115, -145))
    numbers[8] = UIObject:new("number8", lockImage.LockNumbers[8], biglock.obj, Vector2(30, 50), Vector2(-25, -145))
    numbers[9] = UIObject:new("number9", lockImage.LockNumbers[9], biglock.obj, Vector2(30, 50), Vector2(65, -145))

    local tips = UIObject:new("tips", lockImage.Text, biglock.obj, Vector2(1030, 250), Vector2(-35, 325))
    local tips1 = world:CreateObject("UiTextObject", "tips1", tips.obj)

    local confirm =
        UIObject:new("confirm", lockImage.ButtonConfirm, biglock.obj, Vector2(190, 150), Vector2(245, 5))

    local clear = UIObject:new("clear", lockImage.ButtonClear, biglock.obj, Vector2(190, 150), Vector2(245, -145))

    local back = UIObject:new("back", lockImage.Back, biglock.obj, Vector2(390, 140), Vector2(-25, -380))

    local answer = UIObject:new("answer", lockImage.Answer, biglock.obj, Vector2(270, 80), Vector2(-25, 110))
    local answer1 = world:CreateObject("UiTextObject", "answer1", answer.obj)

    answer1.FontSize = 36
    tips1.FontSize = 36
    tips1.Color = Color(255, 255, 255)

    tips:SetVisible(true)
    clear:SetVisible(true)
    back:SetVisible(true)
    confirm:SetVisible(true)
    answer:SetVisible(true)

    local unlocked = false
    local result = 0
    local function clickNumber(_number)
        return function(_res)
            if _res > 99 then
                return _res
            end
            return _res * 10 + _number
        end
    end

    local function setResult(_res)
        result = _res
        answer1.Text = string.format("%03d", result)
    end

    for i, v in ipairs(numbers) do
        v:SetVisible(true)
        local calcFunc = clickNumber(i)
        v:SetClickFunc(
            function()
                buttonPressSound:Play()
                setResult(calcFunc(result))
            end
        )
    end

    confirm:SetClickFunc(
        function()
            if result == 523 then
                tips1.Text = "门开了"
                unlocked = true
                wait(0.2)
                ----enter next room
                biglock:SetVisible(false)
                _parent:SetVisible(true)
                doorOpenAni:Play()
                _parent.player:EnableControl(false)
                wait(2)
                roomdoor:UpdateTexture(lockImage.Door)
                GameManager.CallFunc("EnterBedRoom")
                print("-----------------------EnterScene 2!!!!!!!!!!!!!!---------------------")
            else
                setResult(0)
                tips1.Text = "看来密码不对，再找找看吧。"
            end
        end
    )
    clear:SetClickFunc(
        function()
            tips1.Text = "需要密码才能进去吗……？"
            setResult(0)
        end
    )
    back:SetClickFunc(
        function()
            biglock:SetVisible(false)
            _parent:SetVisible(true)
        end
    )
    roomdoor:SetFunc(
        function()
            if unlocked == true then
                GameManager.CallFunc("EnterBedRoom")
                return
            end
            setResult(0)
            tips1.Text = "需要密码才能进去吗……？"
            biglock:SetVisible(true)
            _parent:SetVisible(false)
        end
    )
    return roomdoor
end
return doorlock
