local Resource = require("Lua/resource")

local GameManager = {}

local gameStage = 1

function GameManager.Start()
end

local draw

function GameManager.SetDraw(_draw)
    draw = _draw
end

local mirrorChecked = false

function GameManager.CheckMirror()
    mirrorChecked = true
end

function GameManager.MirrorChecked()
    return mirrorChecked
end

local bucketGot = false
local canvasGot = false
local pigmentGot = false

--- @param _scene Scene
local function updateScene1Texture(_scene)
    if bucketGot == true and canvasGot == true then
        _scene:UpdateTexture(Resource.Scene1.Empty)
    elseif bucketGot == true and canvasGot == false then
        _scene:UpdateTexture(Resource.Scene1.NoBucket)
    elseif bucketGot == false and canvasGot == true then
        _scene:UpdateTexture(Resource.Scene1.NoCanvas)
    else
        _scene:UpdateTexture(Resource.Scene1.All)
    end
end

--- @param _bucket Interactive
--- @param _scene Scene
function GameManager.GetBucket(_bucket, _scene)
    _bucket:SetActive(false)
    _scene:RemoveInteractive(_bucket)
    _bucket.obj:Destroy()
    bucketGot = true
    updateScene1Texture(_scene)
    print("get bucket!")
end

--- @param _canvas Interactive
--- @param _scene Scene
function GameManager.GetCanvas(_canvas, _scene)
    _canvas:SetActive(false)
    _scene:RemoveInteractive(_canvas)
    _canvas.obj:Destroy()
    canvasGot = true
    updateScene1Texture(_scene)
    _scene:AddInteractive(draw)
    print("get canvas!")
end

function GameManager.GetPigment()
    pigmentGot = true
end

function GameManager.ItemGot(_item)
    if _item == "Bucket" then
        return bucketGot
    elseif _item == "Canvas" then
        return canvasGot
    elseif _item == "Pigment" then
        return pigmentGot
    end
end

local bucketPlaced = false
local canvasPlaced = false
local pigmentPlaced = false

function GameManager.ItemPlaced(_item)
    if _item == "Bucket" then
        return bucketPlaced
    elseif _item == "Canvas" then
        return canvasPlaced
    elseif _item == "Pigment" then
        return pigmentPlaced
    end
end

--- @param _item string
function GameManager.PlaceItem(_item)
    if _item == "Bucket" then
        bucketPlaced = true
    elseif _item == "Canvas" then
        canvasPlaced = true
    elseif _item == "Pigment" then
        pigmentPlaced = true
    end
    GameManager.CallFunc("UpdateEasel")
end

function GameManager.CheckEasel()
    return bucketPlaced and canvasPlaced and pigmentPlaced
end

local funcTable = {}

--- @param _name string
--- @param _func function
function GameManager.RegisterFunc(_name, _func)
    funcTable[_name] = _func
end

--- @param _name string
function GameManager.CallFunc(_name, ...)
    if funcTable[_name] ~= nil then
        funcTable[_name](...)
    end
end

local doorRing = nil

function GameManager.SetDoorRing(_ring)
    doorRing = _ring
end

function GameManager.StopDoorRing()
    if doorRing ~= nil then
        doorRing:Stop()
    end
end

return GameManager
