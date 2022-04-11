local UIObject = require("Lua/module/uiObject")
local Background = require("Lua/resource").FloatTip.Background

--- @class FloatTip:UIObject
local FloatTip = class("FloatTip", UIObject)

--- @param _text string
--- @param _parent Object
--- @param _pos Vector2
function FloatTip:initialize(_text, _parent, _pos)
    UIObject.initialize(self, "float tip", Background, _parent, Vector2(1030, 250), _pos)
    self.obj:SetActive(true)
    --- @type UiTextObject
    self.text = world:CreateObject("UiTextObject", "text", self.obj)
    self.text.FontSize = 36
    self.text.Color = Color(255, 255, 255)
    self.text.Text = _text
end

--- @param _text string
--- @param _align string
function FloatTip:SetText(_text, _align)
    self.text.Text = _text
    if _align == "left" then
        self.text.XAlignment = Enum.XAlignment.Left
        self.text.Offset = Vector2(-470,0)
    elseif _align == "right" then
        self.text.XAlignment = Enum.XAlignment.Right
        self.text.Offset = Vector2(470,0)
    else
        self.text.XAlignment = Enum.XAlignment.Center
        self.text.Offset = Vector2(0,0)
    end
end

--- @param _color Color
function FloatTip:SetColor(_color)
    self.text.Color = _color
end

function FloatTip:Destroy()
    self.obj:Destroy()
end

return FloatTip
