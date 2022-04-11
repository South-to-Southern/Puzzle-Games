local UIObject = require("Lua/module/uiObject")
local Animation = require("Lua/module/animation")
local FloatTip = require("Lua/module/floatTip")
local AudioPlayer = require("Lua/module/audio")
local Resource = require("Lua/resource").Loft
local InterActive = require("Lua/module/interactive")

local Loft = {}

--- @param _parent Scene
function Loft.Get(_parent)
      local loft = InterActive:new(
	  "loft",Resource.Background1,Resource.Background1,_parent,Vector2(3610,260),Vector2(-750,-320))
	  return loft
end
return Loft