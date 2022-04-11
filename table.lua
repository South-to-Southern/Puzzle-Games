local Interactive = require("Lua/module/interactive")
local UIObject = require("Lua/module/uiObject")
local FloatTip = require("Lua/module/floatTip")
local Animation = require("Lua/module/animation")
local Resource = require("Lua/resource").RoomTable

local Table = {}

--- @param _parent Scene
function Table.Get(_parent)
    local table =
        Interactive:new("Table", Resource.Table, Resource.Table, _parent, Vector2(650, 190), Vector2(-160, -35))
    local tableAni = Animation:new(table.obj, Resource.TableAni, 0.3)
    table:SetAnimation(tableAni)

    local tableInfo =
        UIObject:new("tableInfo", Resource.TableInfo, _parent.obj.Parent, Vector2(1600, 900), Vector2.Zero)
    local newspaperAni = Animation:new(tableInfo.obj, Resource.NewspaperAni, 0.3)
    newspaperAni:Play()

    local newspaper = UIObject:new("newspaper", Resource.Newspaper, tableInfo.obj, Vector2(700, 800), Vector2(-250, 0))
    newspaper:SetVisible(true)

    local phone = UIObject:new("phone", Resource.Phone, tableInfo.obj, Vector2(330, 370), Vector2(-455, -125))
    phone:SetVisible(true)
    local phoneAni = Animation:new(phone.obj, Resource.PhoneAni, 0.3)
    phoneAni:Play()

    local drawPaper =
        UIObject:new("drawPaper", Resource.DrawPaper, tableInfo.obj, Vector2(490, 400), Vector2(315, -150))
    drawPaper:SetVisible(true)
    local drawPaperAni = Animation:new(drawPaper.obj, Resource.DrawPaperAni, 0.3)
    drawPaperAni:Play()

    local drawPaperBig =
        UIObject:new("drawPaperBig", Resource.DrawPaperBig, tableInfo.obj, Vector2(1600, 900), Vector2.Zero)

    local tip = FloatTip:new("", tableInfo.obj, Vector2(0, -325))

    tip:SetClickFunc(
        function()
            tip:SetVisible(false)
        end
    )

    local count = 0
    newspaper:SetClickFunc(
        function()
            if count == 0 then
                tip:SetText("x市英雄主题艺术画展将在明日举行，\n据悉此次画展将有一位年轻画家的作品初次参展，\n业内议论纷纷，年轻艺术家备受期待。")
            elseif count == 1 then
                tip:SetText("x市实验小学优秀作文展示《我的爸爸》\n我的爸爸是我的英雄，他总是能在我的危难时刻出现，\n保护我………")
            elseif count == 2 then
                tip:SetText("《悬案！无人的命案，相依为命的父女一夜间双双失踪》\n当警察发现时，案发现场空无一人，\n只有血迹代表着发生的一切。")
            end
            tip:SetVisible(true)
            count = (count + 1) % 3
        end
    )

    phone:SetClickFunc(
        function()
            tip:SetText("您好：\n您的作品已经入选参展，请务必本人携带作品\n在十二点之前送来参展地进行签约和展出。", "center")
            tip:SetVisible(true)
        end
    )

    drawPaper:SetClickFunc(
        function()
            tip:SetText("这是……拿去参展的画作？")
            drawPaperBig:SetVisible(true)
            tip:SetVisible(true)
        end
    )

    local clicked = false
    drawPaperBig:SetClickFunc(
        function()
            if clicked == true then
                drawPaperBig:SetVisible(false)
                tip:SetVisible(false)
                clicked = false
            else
                tip:SetText("感觉画面被分成了九个格子……")
                tip:SetVisible(true)
                clicked = true
            end
        end
    )

    table:SetFunc(
        function()
            _parent:SetVisible(false)
            tableInfo:SetVisible(true)
            tip:SetText("当日的报纸……和一部小灵通？")
            tip:SetVisible(true)
        end
    )

    tableInfo:SetClickFunc(
        function()
            tableInfo:SetVisible(false)
            _parent:SetVisible(true)
        end
    )

    return table
end

return Table
