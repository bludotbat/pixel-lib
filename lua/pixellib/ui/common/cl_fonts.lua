local fonts = {}
local fontsScaled = {}
local scaledFontData = {}
local fontName = "Open Sans Semibold"

function PIXEL.GetFontUnscaled(size, weight)
    weight = weight or 500
    local fontstr = "PIXELLIB:" .. size .. "-" .. weight
    if fonts[fontstr] then return fontstr end

    surface.CreateFont(fontstr, {
        font = fontName,
        size = size,
        weight = weight,
        extended = true,
        antialias = true
    })

    fonts[fontstr] = true

    return fontstr
end

function PIXEL.GetFont(size, weight)
    weight = weight or 500
    local fontstr = "PIXELLIB:" .. size .. "-" .. weight .. "S"
    if fontsScaled[fontstr] then return fontstr end

    surface.CreateFont(fontstr, {
        font = fontName,
        size = PIXEL.Scale(size),
        weight = weight,
        extended = true,
        antialias = true
    })

    fontsScaled[fontstr] = true

    scaledFontData[fontstr] = {
        sz = size,
        wg = weight
    }

    return fontstr
end

local getTextSize = surface.GetTextSize
local setFont = surface.SetFont

function PIXEL.GetTextSize(text, font)
    setFont(font)

    return getTextSize(text)
end

PIXEL.SetFont = setFont
hook.Add("OnScreenSizeChanged", "PIXEL.LIB.ReScaleFonts", function()
    fontsScaled = {}

    for k, v in ipairs(scaledFontData) do
        PIXEL.GetFont(v.sz, v.wg)
    end
end)