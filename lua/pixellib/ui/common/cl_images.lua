local cached = {}

if not file.IsDir("pixel_lib", "DATA") then
    file.CreateDir("pixel_lib")
end

function PIXEL.ImgurDL(id)
    if cached[id] then return cached[id] end

    if file.Exists("pixel_lib/" .. id .. ".png", "DATA") then
        cached[id] = Material("../data/pixel_lib/" .. id .. ".png", "noclamp mips")

        return cached[id]
    end

    cached[id] = true

    http.Fetch("https://i.imgur.com/" .. id .. ".png", function(bod)
        file.Write("pixel_lib/" .. id .. ".png", bod)
        cached[id] = Material("../data/pixel_lib/" .. id .. ".png", "noclamp mips")
    end, function(err)
        PIXEL.Message("Imgur", "Invalid Material (" .. err .. ")")
    end)

    return cached[id]
end

function PIXEL.DrawImgurRotated(x, y, w, h, id, rot)
    local mat = PIXEL.ImgurDL(id)

    if mat == true then
        local _min = math.min(w, h)
        surface.SetDrawColor(color_white)
        surface.SetMaterial(cached["w6aUF4y"])
        surface.DrawTexturedRectRotated(x + w / 2, y + h / 2, _min, _min, (CurTime() * 10) % 360)

        return
    end

    surface.SetMaterial(cached[id])
    surface.DrawTexturedRectRotated(x + w / 2, y + h / 2, w, h, rot)
end

function PIXEL.DrawImgur(x, y, w, h, id)
    PIXEL.DrawImgurRotated(x, y, w, h, id, 0)
end

PIXEL.ImgurDL("w6aUF4y")