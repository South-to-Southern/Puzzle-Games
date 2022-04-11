--- @class Animation
local Animation = class("Animation")

--- @param _obj UiImageObject
--- @param _t table
--- @param _dt number
--- @param _once boolean
function Animation:initialize(_obj, _t, _dt, _once)
    self.obj = _obj
    self.t = _t
    self.once = _once
    self.dt = _dt
    self.tickNow = 0
    self.playing = false
end

function Animation:tickNext()
    if #(self.t) == self.tickNow then
        if self.once == true then
            self:Stop()
            return
        end
        self.tickNow = 1
    else
        self.tickNow = self.tickNow + 1
    end
    self.obj.Texture = ResourceManager.GetTexture(self.t[self.tickNow])
end

function Animation:Play()
    if self.playing == true then
        return
    end
    self.playing = true
    self.tickNow = 0
    local tt = self.dt
    local function tickFunc(_dt)
        if self.playing == false then
            world.OnRenderStepped:Disconnect(tickFunc)
        end
        tt = tt + _dt
        if tt >= self.dt then
            self:tickNext()
            tt = 0
        end
    end
    world.OnRenderStepped:Connect(tickFunc)
end

function Animation:Stop()
    self.playing = false
end

return Animation
