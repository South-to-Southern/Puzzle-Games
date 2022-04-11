local App = {}

local Canvas = require("Lua/module/canvas")
local Player = require("Lua/module/player")
local GameManager = require("Lua/game")
local scene3 = require("Lua/scenes/scene3/scene3")
local scene2 = require("Lua/scenes/scene2/scene2")

function App:Init()
    --- Init Camera
    world.CurrentCamera = world.Local.MainCamera

    --- @type Canvas
    self.canvas = Canvas:new()

    --- @type table
    self.scenes = {}

    --- @type string
    self.currentScene = ""
end

function App:InitScene()
    local s1 = scene3:Get("s3", self.canvas)
    local s2 = scene2:Get("s2", self.canvas)

    self.scenes["s1"] = s1
    self.scenes["s2"] = s2

	
    GameManager.RegisterFunc("EnterLivingRoom", function()
        self:ChangeScene("s1")
    end)
    GameManager.RegisterFunc("EnterBedRoom", function()
        self:ChangeScene("s2")
    end)
end

function App:InitPlayer()
    self.player = Player:new(self.canvas)
end

function App:ChangeScene(_name) 
    self.player:EnterScene(self.scenes[_name])
    self.currentScene = _name
end

function App:Run()
    self:Init()
    self:InitScene()
    self:InitPlayer()
---<<<<<<< HEAD
    GameManager.CallFunc("EnterBedRoom")
---=======
    print("start!")
    GameManager.CallFunc("EnterLivingRoom")
--->>>>>>> origin/dev_s2
    -- wait(2)
    -- self:ChangeScene("s2")
    -- self.player:EnterScene(self.scenes["s2"])
end

return App
