local UIObject = require("Lua/module/uiObject")
local Animation = require("Lua/module/animation")
local FloatTip = require("Lua/module/floatTip")
local AudioPlayer = require("Lua/module/audio")
local Resource = require("Lua/resource").Paint

local Paint = {}

--- @param _parent Scene
function Paint.Get(_parent)
    local paint = UIObject:new("Paint", Resource.Paint, _parent.obj.Parent, Vector2(1600, 900), Vector2(0, 0))
    local pallete = UIObject:new("Pallete", Resource.Pallete, paint.obj, Vector2(410, 260), Vector2(-545, -320))
    pallete:SetVisible(true)
    local palleteAni = Animation:new(pallete.obj, Resource.PalleteAni, 0.3)
    palleteAni:Play()
    local door = UIObject:new("Door", Resource.Door, paint.obj, Vector2(150, 200), Vector2(380, 320))
    local tip = FloatTip:new("", paint.obj, Vector2(0, -325))
    tip:SetClickFunc(
        function()
            tip:SetVisible(false)
        end
    )
    tip:SetVisible(false)
    local paintSound = AudioPlayer:new("PaintSound", Resource.PaintSound, false)
    paint.bgm1 = AudioPlayer:new("bgm1", Resource.Bgm1, true, true)
    paint.bgm2 = AudioPlayer:new("bgm2", Resource.Bgm2, true, true)
    paint.bgm3 = AudioPlayer:new("bgm3", Resource.Bgm3, true, true)

    paintSound.obj.Volume = 30
    paint.bgm1.obj.Volume = 20
    paint.bgm2.obj.Volume = 50
    paint.bgm3.obj.Volume = 50

    local paintAnis = {}
    for i = 1, 9 do
        paintAnis[i] = Animation:new(paint.obj, Resource.Stages[i].PaintAni, 0.4, true)
    end

    local doorOpenAni = Animation:new(paint.obj, Resource.DoorOpenAni, 0.4, true)
    local doorAni = Animation:new(paint.obj, Resource.DoorAni, 0.3)

    local stage, count, goal = 1, 0, 0
    local palleteEnabled = true

    local squares, animations, aniPerStage, clicked = {}, {}, {}, {}
    for i = 1, 3 do
        squares[i] = UIObject:new("Square" .. i, Resource.SquareAni[1][1][1], paint.obj, Vector2(120, 120), Vector2(0, 0))
        animations[i] = Animation:new(squares[i].obj, Resource.SquareAni[1][1], 0.3, false)
        aniPerStage[i] = Animation:new(squares[i].obj, Resource.SquareAni[1][2], 0.1, true)

        squares[i]:SetClickFunc(
            function()
                if clicked[i] then
                    return
                end
                clicked[i] = true
                paintSound:Play()
                wait(0.3)
                animations[i]:Stop()
                aniPerStage[i]:Play()
                count = count + 1
                if count == goal then
                    wait(1)
                    for i = 1, 3 do
                        squares[i]:SetVisible(false)
                        clicked[i] = false
                    end
                    paintAnis[stage]:Play()
                    tip:SetText(Resource.Tips[stage])
                    tip:SetVisible(true)
                    stage = stage + 1
                    count = 0
                    palleteEnabled = true
                    pallete:SetVisible(true)
                    if stage == 4 then
                        pallete:SetVisible(false)
                        wait(1)
                        paint:SetClickFunc(
                            function()
                                paint:UpdateTexture(Resource.Paints[1])
                                pallete:SetVisible(true)
                                paint:SetClickFunc(nil)
                                tip:SetText(Resource.Tips[10])
                                tip:SetVisible(true)
                            end
                        )
                    elseif stage == 7 then
                        pallete:SetVisible(false)
                        wait(1)
                        paint:SetClickFunc(
                            function()
                                paint:UpdateTexture(Resource.Paints[2])
                                pallete:SetVisible(true)
                                paint:SetClickFunc()
                                tip:SetText(Resource.Tips[11])
                                tip:SetVisible(true)
                            end
                        )
                    elseif stage == 10 then
                        pallete:SetVisible(false)
                        wait(1)
                        paint:SetClickFunc(
                            function()
                                doorOpenAni:Play()
                                tip:SetText(Resource.Tips[12])
                                tip:SetVisible(true)
                                wait(1)
                                doorAni:Play()
                                door:SetVisible(true)
                                door:SetClickFunc(
                                    function()
                                        paint:SetVisible(false)
                                        paint.bgm3:Stop()
                                        print("进入阁楼")
                                    end
                                )
                            end
                        )
                    end
                end
            end
        )
    end

    squares[1].obj.Offset = Vector2(-300, 300)
    squares[2].obj.Offset = Vector2(300, 300)
    squares[3].obj.Offset = Vector2(0, 0)

    pallete:SetClickFunc(
        function()
            if palleteEnabled then
                pallete:SetVisible(false)
                paint:UpdateTexture(Resource.Stages[stage].Paint)
                print("stage " .. stage)
                palleteEnabled = false
                goal = 0
                for i, v in ipairs(Resource.DrawPos[stage]) do
                    goal = goal + 1
                    squares[i].obj.Offset = v
                    squares[i]:SetVisible(true)
                    animations[i].t = Resource.SquareAni[stage][1]
                    aniPerStage[i].t = Resource.SquareAni[stage][2]
                    animations[i]:Play()
                end
                if stage == 4 then
                    paint.bgm1:Stop()
                    paint.bgm2:Play()
                elseif stage == 7 then
                    paint.bgm2:Stop()
                    paint.bgm3:Play()
                end
            end
        end
    )

    return paint
end

return Paint
