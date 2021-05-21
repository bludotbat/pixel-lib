
local hsv = HSVToColor
local c = Color

PIXEL.Colors = {}
PIXEL.Colors.Accents = {}

PIXEL.Colors.Background = c(22, 22, 22)
PIXEL.Colors.Header = c(28, 28, 28)

PIXEL.Colors.Text = color_white
PIXEL.Colors.PrimaryText = PIXEL.Colors.Text
PIXEL.Colors.SecondaryText = c(220, 220, 220)
PIXEL.Colors.DisabledText = c(40, 40, 40)

PIXEL.Colors.Accents.Primary = c(47, 128, 200)
PIXEL.Colors.Accents.Disabled = c(180, 180, 180)
PIXEL.Colors.Accents.Positive = c(66, 134, 50)
PIXEL.Colors.Accents.Negative = c(164, 50, 50)

PIXEL.Colors.Transparent = color_transparent

PIXEL.Colors.Rainbow = Color(255, 0, 0)

local sv = 0.9
local rainbowHue = 0
hook.Add("Think", "PIXEL.LIB.RainbowColor", function()
    rainbowHue = (rainbowHue % 360) + 0.2
    PIXEL.Colors.Rainbow = hsv(rainbowHue, sv, sv)
end)