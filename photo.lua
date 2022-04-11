local UIObject = require("Lua/module/uiObject")
local Interactive = require("Lua/module/interactive")
local PhotoImage = require("Lua/resource").Photo
local GameManager = require("Lua/game")
local Animation = require("Lua/module/animation")

local Photo = {}

--- @param _parent Scene
function Photo.Get(_parent)
    local photo =
        Interactive:new("photo", PhotoImage.Photo, PhotoImage.Photo, _parent, Vector2(90, 100), Vector2(-1350, 40))
    local bigPhoto =
        UIObject:new("bigphoto", PhotoImage.PhotoInfo, _parent.obj.Parent, Vector2(1600, 900), Vector2.Zero)

    local tips = UIObject:new("tips", PhotoImage.Text, bigPhoto.obj, Vector2(1030, 250), Vector2(0, -325))
    tips:SetVisible(true)

    local tips1 = world:CreateObject("UiTextObject", "tips1", tips.obj)
    tips1.FontSize = 36
    tips1.Color = Color(255, 255, 255)

    bigPhoto:SetVisible(false)
    local animation = Animation:new(photo.obj, PhotoImage.PhotoAni, 0.2)
    photo:SetAnimation(animation)

    local count = 0
    bigPhoto:SetClickFunc(
        function()
            if count == 0 then
                tips1.Text = "428。这有什么意义吗？"
                count = 1
            else
                bigPhoto:SetVisible(false)
                _parent:SetVisible(true)
            end
        end
    )

    tips:SetClickFunc(
        function()
            if count == 0 then
                tips1.Text = "428。这有什么意义吗？"
                count = 1
            else
                bigPhoto:SetVisible(false)
                _parent:SetVisible(true)
            end
        end
    )


    photo:SetFunc(
        function()
            _parent:SetVisible(false)
            bigPhoto:SetVisible(true)
            tips1.Text = "这个男人总给我一种很熟悉的感觉……嗯？背面好像有字。"
            count = 0
        end
    )

    return photo
end
return Photo
