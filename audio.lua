--- @class AudioPlayer
local AudioPlayer = class("AudioPlayer")

function AudioPlayer:initialize(_name, _ref, _loop, _fadeinout)
    --- @type AudioSource
    self.obj = world:CreateObject("AudioSource", _name, world.Local)
    self.obj.SoundClip = ResourceManager.GetSoundClip(_ref)
    self.obj.Loop = _loop
    if _fadeinout then
        -- self.obj:SetFadeVolume(100, 5)
        self.obj.FadeIn = 2
        self.obj.FadeOut = 1
    end
end

function AudioPlayer:Play()
    self.obj:Play()
end

function AudioPlayer:Pause()
    self.obj:Pause()
end

function AudioPlayer:Stop()
    self.obj:Stop()
end

function AudioPlayer:UnPause()
    self.obj:UnPause()
end

return AudioPlayer
