local UIObject = require("Lua/module/uiObject")
local Animation = require("Lua/module/animation")
local FloatTip = require("Lua/module/floatTip")
local AudioPlayer = require("Lua/module/audio")
local HangerImage = require("Lua/resource").Hanger
local InterActive = require("Lua/module/interactive")


local hanger = {}

--- @param _parent Scene
function hanger.Get(_parent)
    
	local Hanger = InterActive:new("hanger",HangerImage.Cloth,HangerImage.Cloth,_parent,Vector2(1010,730),Vector2(-200,-80))
	local Hanger1 = InterActive:new("hanger1",HangerImage.Cloth,HangerImage.Cloth,_parent,Vector2(1010,730),Vector2(-200,-80))
	local Hanger2 = InterActive:new("Hanger2",HangerImage.Hangerstand,HangerImage.Hangerstand,_parent,Vector2(1010,730),Vector2(-200,-80))
	local Hanger3 = InterActive:new("Hanger3",HangerImage.Hangerlose,HangerImage.Hangerlose,_parent,Vector2(1010,730),Vector2(-200,-80))
 	local animation = Animation:new(Hanger.obj, HangerImage.ClothshakeAni, 0.2)
    Hanger:SetAnimation(animation)
	local animation1 = Animation:new(Hanger1.obj, HangerImage.ClothdownAni, 0.2)
    local animation2 = Animation:new(Hanger2.obj, HangerImage.HangerAni, 0.2)
	
	Hanger1:SetVisible(false)
	Hanger2:SetVisible(false)
	Hanger3:SetVisible(false)
	
	local tip1 = FloatTip:new("", _parent.obj, Vector2(200, 300))
		tip1:SetVisible(false)
	tip1:SetClickFunc(
        function()
            tip1:SetVisible(false)
        end
    )
	
	Hanger:SetFunc(function()
	        _parent:RemoveInteractive(Hanger)
			Hanger:SetVisible(false)
			tip1:SetText("才多大就这么爱臭美？穿得再漂亮也没用，看看你长那样吧，再打扮也没用。")
			tip1:SetVisible(true)			  
			Hanger1:SetVisible(true)
            animation1:Play()
            wait(1.4)
			
			Hanger1:SetVisible(false)		
	        Hanger2:SetVisible(true)	        
			
			Hanger2:SetClickFunc(function()
			   animation2:Play()
			   wait(1.2)
			   Hanger2:SetVisible(false)
			   tip1:SetVisible(false)
			   Hanger3:SetVisible(true)
			end)
	end)
	return Hanger
end
return hanger