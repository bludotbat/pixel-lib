local blurPassesCvar = CreateClientConVar("pixel_blur_passes", "4", true, false, "Amount of passes to draw blur with. 0 to disable blur entirely.", 0, 15)
local blurPassesNum = blurPassesCvar:GetInt()

cvars.AddChangeCallback("pixel_blur_passes", function(_, _, passes)
    blurPassesNum = math.floor(tonumber(passes) + 0.05)
end)

local blurMat = Material("pp/blurscreen")
local scrW, scrH = ScrW, ScrH

function PIXEL.DrawBlur(panel, localX, localY, w, h)
    if blurPassesNum == 0 then return end
    local x, y = panel:LocalToScreen(localX, localY)
    local scrw, scrh = scrW(), scrH()
    surface.SetMaterial(blurMat)
    surface.SetDrawColor(255, 255, 255)

    for i = 0, blurPassesNum do
        blurMat:SetFloat("$blur", i * .33)
        blurMat:Recompute()
    end

    render.UpdateScreenEffectTexture()
    surface.DrawTexturedRect(x * -1, y * -1, scrw, scrh)
end