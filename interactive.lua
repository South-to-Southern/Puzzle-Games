--- @type UIObject
local UIObject = require("Lua/module/uiObject")

--- @class Interactive:UIObject
local Interactive = class("Interactive", UIObject)

--- @param _name string
--- @param _ref string
--- @param _ref_active string
--- @param _parent UIObject
--- @param _size Vector2
--- @param _offset Vector2
--- @param _func function
function Interactive:initialize(_name, _ref, _ref_active, _parent, _size, _offset, _func)
    UIObject.initialize(self, _name, _ref, _parent.obj, _size, _offset)
    self.ref = _ref
    self.ref_active = _ref_active
    self:SetFunc(_func)
    self.interactive = true
    self.pos = _offset
    self:SetVisible(true)
    self:SetActive(false)
end

function Interactive:SetFunc(_func)
    local func = function()
        if self.interactive == true then
            _func()
        end
    end
    UIObject.SetClickFunc(self, func)
end

--- @param _active boolean
function Interactive:SetActive(_active)
    if self.interactive == _active then
        return
    end
    if _active == true then
        self:SetVisible(true)
        self:UpdateTexture(self.ref_active)
        if self.ani ~= nil then
            self.ani:Play()
        end
    else
        if self.ref == "" then
            self:SetVisible(false)
        end
        self:UpdateTexture(self.ref)
        if self.ani ~= nil then
            self.ani:Stop()
        end
    end
    self.interactive = _active
end

function Interactive:CallFunc()
    self.func()
end

--- @param _ani Animation
function Interactive:SetAnimation(_ani)
    self.ani = _ani
end

return Interactive
