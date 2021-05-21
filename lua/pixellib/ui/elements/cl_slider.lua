local PANEL = {}
AccessorFunc(PANEL, "r_bgcol", "BGCol")

function PANEL:Init()
    self:SetBGCol(Color(255, 87, 57))
    self.xP = false
    self.Color = Color(255, 0, 0)
end

function PANEL:GetPercentage(num)
    return (self.xP / self:GetWide()) * num
end

function PANEL:SetPercentage(num)
    self.xP = num * self:GetWide()
end

function PANEL:OnMousePressed(m)
    self.r_isClicking = m
    self:MouseCapture(true)
    self:SetCursor("sizewe")
    self:OnCursorMoved(self:CursorPos())
end

function PANEL:OnMouseReleased()
    if not self.r_isClicking then return end
    self:MouseCapture(false)
    self:SetCursor("none")
    self:OnCursorMoved(self:CursorPos())
end

function PANEL:OnCursorMoved(x, y)
    if not input.IsMouseDown(MOUSE_LEFT) then return end
    if not self:GetIsClicked() then return end
    local w, h = self:GetSize()
    self.xP = math.Clamp(x, 0, w)
    self:OnValueChanged(self.xP)
end

function PANEL:OnValueChanged()
end

function PANEL:Think()
end

function PANEL:Paint(w, h)
    self.xP = self.xP or h / 2
    PIXEL.DrawRoundedBox(4, 0, h / 4, w, h / 2, self:GetBGCol())
    draw.NoTexture()
    surface.SetDrawColor(color_white)
    local op = DisableClipping(true)
    PIXEL.DrawCircleUncached(self.xP, h / 2, 180, 32, 370, h / 2)
    DisableClipping(op)
    PIXEL.DrawRoundedBox(4, self.xP, h / 4, w - self.xP, h / 2, color_white)
end

vgui.Register("PIXEL.Slider", PANEL, "PIXEL.Button")