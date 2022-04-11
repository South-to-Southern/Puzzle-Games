--- 对UiImageObject的封装
--- @class UIObject
local UIObject = class("UIObject")

--- @param _name string 节点树上的名字
--- @param _ref string 图片资源路径
--- @param _parent Object 父节点
--- @param _size Vector2
--- @param _offset Vector2 相对于父节点的偏移
function UIObject:initialize(_name, _ref, _parent, _size, _offset)
    self.name = _name
    --- @type UiImageObject
    self.obj = world:CreateObject("UiImageObject", _name, _parent)
    self:UpdateTexture(_ref)
    self.obj.Size = _size
    self.obj.Offset = _offset
    self.obj:SetActive(false)
    self.clickable = false
    self.func = nil
    self.clickFunc = function()
        if self.func and self.clickable == true and Input.GetPressKeyData(Enum.KeyCode.Mouse0) == Enum.KeyState.KeyStatePress then
            self.func()
        end
    end
    self.enterFunc = function()
        self.clickable = true
    end
    self.leaveFunc = function()
        self.clickable = false
    end
end

--- 设置是否可见
--- @param _visible boolean
function UIObject:SetVisible(_visible)
    self.obj:SetActive(_visible)
end

--- @param _func function
function UIObject:SetClickFunc(_func)
    self.func = _func
    if self.obj.OnEnter:HasConnected(self.enterFunc) == false then
        self.obj.OnEnter:Connect(self.enterFunc)
    end
    if self.obj.OnLeave:HasConnected(self.leaveFunc) == false then
        self.obj.OnLeave:Connect(self.leaveFunc)
    end
    if Input.OnKeyDown:HasConnected(self.clickFunc) == false then
        Input.OnKeyDown:Connect(self.clickFunc)
    end
end

function UIObject:UpdateTexture(_texture)
    self.obj.Texture = ResourceManager.GetTexture(_texture)
end

return UIObject
