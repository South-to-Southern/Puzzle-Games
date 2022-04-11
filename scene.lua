local UIObject = require("Lua/module/uiObject")
local FloatTip = require("Lua/module/floatTip")
local AudioPlayer = require("Lua/module/audio")

--- @class Scene:UIObject
local Scene = class("Scene", UIObject)

--- @param _name string
--- @param _ref string
--- @param _parent Canvas
--- @param _size Vector2
--- @param _enterPos Vector2
--- @param _bgm string
function Scene:initialize(_name, _ref, _parent, _size, _enterPos, _bgm)
    UIObject.initialize(self, _name, _ref, _parent.obj, _size, Vector2.Zero)
    print("new scene: " .. self.name)
    self.interactives = {}
    self.enterPos = _enterPos
    --- @type FloatTip
    self.tip = nil
    --- @type number
    self.tipTime = 0
    --- @type Player
    self.player = nil
    --- @type AudioPlayer
    self.bgm = AudioPlayer:new(_name .. "_bgm", _bgm, true, true)

    --- Update Interactive
    world.OnRenderStepped:Connect(
        function()
            for k, v in ipairs(self.interactives) do
                if self.player ~= nil and math.abs(self.player.obj.Offset.X - v.obj.Offset.X) <= math.max(200, v.obj.Size.X / 2 + 100) then
                    v:SetActive(true)
                else
                    v:SetActive(false)
                end
            end
        end
    )

    --- Update FloatTip
    world.OnRenderStepped:Connect(
        function()
            if self.tip ~= nil then
                self.tip.obj.Offset = Vector2(-self.obj.Offset.X, -325)
            end
        end
    )
end

--- 设置是否可见
--- @param _visible boolean
function Scene:SetVisible(_visible)
    if self.player ~= nil then
        self.player:EnableControl(_visible)
    end
    self.obj:SetActive(_visible)
    if _visible == true then
        -- self.bgm:UnPause()
    else
        -- self.bgm:Pause()
    end
end

--- @param _interactive Interactive
function Scene:AddInteractive(_interactive)
    table.insert(self.interactives, _interactive)
end

--- @param _interactive Interactive
function Scene:RemoveInteractive(_interactive)
    for k, v in ipairs(self.interactives) do
        if v == _interactive then
            table.remove(self.interactives, k)
        end
    end
end

--- @param _text string
--- @param _time number
function Scene:Tip(_text, _time)
    if self.tip == nil then
        print("----------------new tip")
        self.tip = FloatTip:new(_text, self.obj, Vector2(-self.obj.Offset.X, -325))
        self.tip:SetClickFunc(
            function()
                print("-------------------click")
                self.tip:SetVisible(false)
            end
        )
    end
    self.tip:SetText(_text)
    self.tip.obj:ToTop()
    self.tip:SetVisible(true)
    self.tipTime = Timer.GetTime() + _time
    if _time <= 0 then
        self.tipTime = Timer.GetTime() + 999
    end
    if _time > 0 then
        invoke(
            function()
                wait(_time)
                if Timer.GetTime() < self.tipTime then
                    return
                end
                print("-----------------time out")
                self.tip:SetVisible(false)
            end
        )
    end
end

function Scene:ClearTip()
    if self.tip ~= nil then
        self.tip:Destroy()
        self.tip = nil
    end
end

return Scene
