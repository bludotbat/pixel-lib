local SetFont = PIXEL.SetFont
local GetTextSize = PIXEL.GetTextSize
local SetTextPos = surface.SetTextPos
local SetTextColor = surface.SetTextColor
local DrawText = surface.DrawText
local Either = Either

function PIXEL.DrawText(text, font, x, y, col, xal, yal)
    if not text then return end
    xal = xal or 0
    yal = yal or 0
    SetFont(font)
    local w, h = GetTextSize(text, font)

    if xal ~= 0 then
        x = Either(xal == 1, x - w / 2, x - w)
    end

    if yal ~= 0 then
        y = Either(yal == 1, y - h / 2, y - h)
    end

    SetTextPos(x, y)
    SetTextColor(col.r, col.g, col.b, col.a)
    DrawText(text)

    return w, h
end

local subuwu = string.sub

function PIXEL.CroppedText(text, font, width)
    local w = GetTextSize(text, font)
    if w < width then return text end
    local safety = 0
    local postText = text

    while true do
        if safety >= 100 then
            ErrorNoHaltWithStack("YOU FUCKED UP MORON, STOP CAUSING STACK OVERFLOWS")

            return ""
        end

        safety = safety + 1
        postText = subuwu(postText, 1, #postText - 1)
        w, h = GetTextSize(postText, font)
        if w <= width then break end
    end

    return subuwu(postText, 1, #postText - 3) .. "..."
end

PIXEL.WrappedText = (DarkRP or {
    textWrap = function() end
}).textWrap

PIXEL.DrawAlignedText = draw.SimpleText
-- PIXEL.DrawText = draw.SimpleText