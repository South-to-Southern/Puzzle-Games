local UIObject = require("Lua/module/uiObject")
local Animation = require("Lua/module/animation")
local FloatTip = require("Lua/module/floatTip")
local AudioPlayer = require("Lua/module/audio")
---<<<<<<< HEAD
local drawerImage = require("Lua/resource").Drawer
local InterActive = require("Lua/module/interactive")
---=======
local GameManager = require("Lua/game")
local Resource = require("Lua/resource").Drawer
local FloatTip = require("Lua/module/floatTip")

--书柜抽屉
--->>>>>>> origin/dev_s2

local drawer = {}

--- @param _parent Scene
function drawer.Get(_parent)
    local bookdrawer =
        InterActive:new(
        "bookdrawer",
        Resource.Bookshelf,
        Resource.Bookshelf,
        _parent,
        Vector2(370, 220),
        Vector2(420, -270)
    )
    local animation = Animation:new(bookdrawer.obj, Resource.BookshelfAni, 0.3)
    bookdrawer:SetAnimation(animation)

    local lock = UIObject:new("lock", Resource.Lock, _parent.obj.Parent, Vector2(1600, 900), Vector2.Zero)

    local drawer = UIObject:new("drawer", Resource.Drawer, _parent.obj.Parent, Vector2(1600, 900), Vector2.Zero)
    local drawerAni = Animation:new(drawer.obj, Resource.DrawerAni, 0.2)
    drawerAni:Play()

    local buttonPressSound = AudioPlayer:new("buttonPress", Resource.ButtonPressSound, false)

    local blocks = {}
    blocks[1] = UIObject:new("b1", Resource.WhiteBlock, lock.obj, Vector2(270, 240), Vector2(-285, 260))
    blocks[2] = UIObject:new("b2", Resource.WhiteBlock, lock.obj, Vector2(270, 240), Vector2(5, 260))
    blocks[3] = UIObject:new("b3", Resource.WhiteBlock, lock.obj, Vector2(270, 240), Vector2(295, 260))
    blocks[4] = UIObject:new("b4", Resource.WhiteBlock, lock.obj, Vector2(270, 240), Vector2(-280, 0))
    blocks[5] = UIObject:new("b5", Resource.WhiteBlock, lock.obj, Vector2(270, 240), Vector2(5, 0))
    blocks[6] = UIObject:new("b6", Resource.WhiteBlock, lock.obj, Vector2(270, 240), Vector2(295, 0))
    blocks[7] = UIObject:new("b7", Resource.WhiteBlock, lock.obj, Vector2(270, 240), Vector2(-280, -260))
    blocks[8] = UIObject:new("b8", Resource.WhiteBlock, lock.obj, Vector2(270, 240), Vector2(5, -260))
    blocks[9] = UIObject:new("b9", Resource.WhiteBlock, lock.obj, Vector2(270, 240), Vector2(295, -260))

    local confirm = UIObject:new("confirm", Resource.ButtonConfirm, lock.obj, Vector2(190, 150), Vector2(635, 0))

    local tip1 = FloatTip:new("", lock.obj, Vector2(0, 325))
    local tip2 = FloatTip:new("", drawer.obj, Vector2(0, 325))

    confirm:SetVisible(true)

    tip1:SetClickFunc(
        function()
            tip1:SetVisible(false)
        end
    )

    tip2:SetClickFunc(
        function()
            tip2:SetVisible(false)
        end
    )

    local sum = 0
    local pressed = {0, 0, 0, 0, 0, 0, 0, 0, 0}
    local pow = {1, 2, 4, 8, 16, 32, 64, 128, 256}
    local unlocked = false

    for i, v in ipairs(blocks) do
        v:SetVisible(true)
        v:SetClickFunc(
            function()
                buttonPressSound:Play()
                if pressed[i] == 0 then
                    blocks[i]:UpdateTexture(Resource.BlackBlock)
                    pressed[i] = 1
                    sum = sum + pow[i]
                elseif pressed[i] == 1 then
                    blocks[i]:UpdateTexture(Resource.WhiteBlock)
                    pressed[i] = 0
                    sum = sum - pow[i]
                end
            end
        )
    end

    local picked = false
    drawer:SetClickFunc(
        function()
            if picked == false then
                GameManager.GetPigment()
                tip2:SetText("拿到了【颜料】")
                tip2:SetVisible(true)
                drawerAni:Stop()
                drawer:UpdateTexture(Resource.EmptyDrawer)
                picked = true
            else
                drawer:SetVisible(false)
                _parent:SetVisible(true)
                tip2:SetVisible(false)
            end
        end
    )

    lock:SetClickFunc(function()
        lock:SetVisible(false)
        _parent:SetVisible(true)
    end)

    confirm:SetClickFunc(
        function()
            if sum == 439 then
                tip2:SetText("抽屉开了")
                tip2:SetVisible(true)
                unlocked = true
                lock:SetVisible(false)
                drawer:SetVisible(true)
            else
                tip1:SetText("好像不太对……")
                tip1:SetVisible(true)
            end
        end
    )

    bookdrawer:SetFunc(
        function()
            _parent:SetVisible(false)
            if unlocked == false then
                lock:SetVisible(true)
                tip1:SetText("黑白格子……？好像可以根据见过的黑白印象来填色？")
                tip1:SetVisible(true)
            else
                drawer:SetVisible(true)
            end
        end
    )
    return bookdrawer
end
return drawer
