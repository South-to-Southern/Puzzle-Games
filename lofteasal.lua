local UIObject = require("Lua/module/uiObject")
local Animation = require("Lua/module/animation")
local FloatTip = require("Lua/module/floatTip")
local AudioPlayer = require("Lua/module/audio")
local EasalImage = require("Lua/resource").Lofteasal
local InterActive = require("Lua/module/interactive")


local easal = {}

--- @param _parent Scene
function easal.Get(_parent)
    
	local Easal = InterActive:new("Easal",EasalImage.Cloth,EasalImage.Cloth,_parent,Vector2(670,770),Vector2(850,-80))
	local Easal1 = InterActive:new("Easal1",EasalImage.Cloth,EasalImage.Cloth,_parent,Vector2(670,770),Vector2(850,-80))
	local Easal2 = InterActive:new("Easal2",EasalImage.Lofteasalstand,EasalImage.Lofteasalstand,_parent,Vector2(670,770),Vector2(850,-80))
	local Easal3 = InterActive:new("Easal3",EasalImage.Lofteasallose,EasalImage.Lofteasallose,_parent,Vector2(670,770),Vector2(850,-80))
 	local animation = Animation:new(Easal.obj, EasalImage.ClothshakeAni, 0.2)
    Easal:SetAnimation(animation)
	local animation1 = Animation:new(Easal1.obj, EasalImage.ClothdownAni, 0.2)
    local animation2 = Animation:new(Easal2.obj, EasalImage.LofteasaldownAni, 0.2)
	
	Easal1:SetVisible(false)
	Easal2:SetVisible(false)
	Easal3:SetVisible(false)
	
	local tip1 = FloatTip:new("", _parent.obj, Vector2(850, 300))
		tip1:SetVisible(false)
	tip1:SetClickFunc(
        function()
            tip1:SetVisible(false)
        end
    )
	
	Easal:SetFunc(function()
	        _parent:RemoveInteractive(Easal)
			Easal:SetVisible(false)
			tip1:SetText("你又没有天赋，成天搞这些不正经的事做什么，就不能听爸爸的话好好学习吗？")
			tip1:SetVisible(true)			  
			Easal1:SetVisible(true)
            animation1:Play()
            
			wait(1.0)
			Easal1:SetVisible(false)		
	        Easal2:SetVisible(true)	        
			
			Easal2:SetClickFunc(function()
			   animation2:Play()
			   wait(1.4)
			   Easal2:SetVisible(false)
			   tip1:SetVisible(false)
			   Easal3:SetVisible(true)
			end)
	end)
	return Easal
end
return easal