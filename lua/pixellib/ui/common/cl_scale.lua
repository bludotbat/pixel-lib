local scrh = ScrH
local scrw = ScrW

function PIXEL.ScaleH(s)
    return s * (scrh() / 1080)
end

function PIXEL.ScaleW(s)
    return s * (scrw() / 1920)
end

PIXEL.Scale = PIXEL.ScaleH