local UIObject = require("Lua/module/uiObject")
local Animation = require("Lua/module/animation")
local FloatTip = require("Lua/module/floatTip")
local AudioPlayer = require("Lua/module/audio")
local ToyImage = require("Lua/resource").Toy
local InterActive = require("Lua/module/interactive")


local toy = {}

--- @param _parent Scene
function toy.Get(_parent)
    
	local Toy = InterActive:new("toy",ToyImage.Cloth,ToyImage.Cloth,_parent,Vector2(640,640),Vector2(-1000,-155))
	local Toy1 = InterActive:new("toy1",ToyImage.Cloth,ToyImage.Cloth,_parent,Vector2(640,640),Vector2(-1000,-155))
	local Toy2 = InterActive:new("toy2",ToyImage.Toystand,ToyImage.Toystand,_parent,Vector2(640,640),Vector2(-1000,-155))
	
	local animation = Animation:new(Toy.obj, ToyImage.ClothshakeAni, 0.2)
    Toy:SetAnimation(animation)
	local animation1 = Animation:new(Toy1.obj, ToyImage.ClothdownAni, 0.2)
    local animation2 = Animation:new(Toy2.obj, ToyImage.ToyrunAni, 0.2)
	
	Toy1:SetVisible(false)
	Toy2:SetVisible(false)
	
	local tip1 = FloatTip:new("", _parent.obj, Vector2(-1000, 300))
				tip1:SetVisible(false)
	tip1:SetClickFunc(
        function()
            tip1:SetVisible(false)
        end
    )
	
	Toy:SetFunc(function()
	        _parent:RemoveInteractive(Toy)
			Toy:SetVisible(false)
			tip1:SetText("你都这么大了还玩这种小孩子的玩具，应该像所有懂事的女孩一样多做做家务")
			tip1:SetVisible(true)			  
			Toy1:SetVisible(true)
            animation1:Play()
            wait(1.2)
			
			Toy1:SetVisible(false)		
	        Toy2:SetVisible(true)	        
			
			Toy2:SetClickFunc(function()
			   animation2:Play()
			   wait(0.8)
			   Toy2:SetVisible(false)
			   tip1:SetVisible(false)
			end)
	end)
	return Toy
end
return toy