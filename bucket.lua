local Interactive = require("Lua/module/interactive")
local Animation = require("Lua/module/animation")
local BucketImage = require("Lua/resource").Bucket
local GameManager = require("Lua/game")

local Bucket = {}

--- @param _parent Scene
function Bucket.Get(_parent)
    local bucket = Interactive:new("Bucket", BucketImage.Bucket, BucketImage.Bucket, _parent, Vector2(150, 120), Vector2(-470, -330))
    local animation = Animation:new(bucket.obj, BucketImage.BucketAni, 0.2)
    bucket:SetAnimation(animation)
    bucket:SetFunc(function()
        GameManager.GetBucket(bucket, _parent)
        _parent:Tip("拿到了【水桶】", 5)
    end)
    return bucket
end
return Bucket
