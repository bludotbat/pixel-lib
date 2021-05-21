--Overheads
local start3d2d, end3d2d = cam.Start3D2D, cam.End3D2D
local disableclipping = DisableClipping
local setDrawColor = surface.SetDrawColor
local overheadFont = PIXEL.GetFontUnscaled(100)
local localPly

function PIXEL.ShouldDrawUI(ent)
    if not IsValid(localPly) then localPly = LocalPlayer() end
    if localPly:GetPos():DistToSqr(ent:GetPos()) < 200000 then return true end
end

function PIXEL.DrawOverheadEx(ent, text, image, angle, pos, scale)
    scale = scale or 0.04

    if not angle then
        local CalcPos = (pos - localPly:GetPos())
        angle = Angle(0, CalcPos:Angle()[2] - 90, 90)
    else
        angle = ent:LocalToWorldAngles(angle)
    end

    local w, h = PIXEL.GetTextSize(text, overheadFont)
    w, h = w + 60, h + 8
    local x, y = -(w / 2), -h

    local oldClipping = disableclipping(true)
    start3d2d(pos, angle, scale)
    if not image then
        PIXEL.DrawRoundedBox(12, x, y, w, h, PIXEL.Colors.Accents.Primary)
        PIXEL.DrawText(text, overheadFont, 0, y + 1, PIXEL.Colors.PrimaryText, TEXT_ALIGN_CENTER)
    else
        PIXEL.DrawRoundedBox(12, x, y, h, h, PIXEL.Colors.Accents.Primary)
        PIXEL.DrawRoundedBoxEx(12, x + h - 12, y + (h - 10), w - 10, 10, PIXEL.Colors.Accents.Primary, false, false, false, true)
        PIXEL.DrawText(text, overheadFont, 95, y - 2, PIXEL.Colors.PrimaryText, TEXT_ALIGN_CENTER)

        setDrawColor(color_white)
        PIXEL.DrawImgur(x + 10, y + 10, h - 20, h - 20, image)
    end
    end3d2d()
    disableclipping(oldClipping)
end

function PIXEL.DrawEntOverhead(ent, text, image, angle, pos, scale)
    if not PIXEL.ShouldDrawUI(ent) then return end

    PIXEL.DrawOverheadEx(ent, text, image, angle, Either(pos, ent:LocalToWorld(pos), Vector(0, 0, ent:OBBMaxs()[3] + 2)), scale)
end

local noEye = Vector(0, 0, 72)
local eyeOffset = Vector(0, 0, 7)
function PIXEL.DrawNPCOverhead(ent, text, image, angle, pos, scale)
    if not PIXEL.ShouldDrawUI(ent) then return end

    local eyeLookup = ent:LookupAttachment("eyes")
    if eyeLookup then
        local eyes = ent:GetAttachment(eyeLookup)
        if eyes then
            local calcPos = eyes.Pos
            calcPos:Add(pos or eyeOffset)
            PIXEL.DrawOverheadEx(ent, text, image, angle, calcPos, scale)
            return
        end
    end

    PIXEL.DrawOverheadEx(ent, text, image, ent:GetPos() + noEye, angle, scale)
end