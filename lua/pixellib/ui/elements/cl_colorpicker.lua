local PANEL = {}

function PANEL:Init()
    self.R = vgui.Create("PIXEL.Slider", self)
    self.R:Dock(TOP)
    self.R:SetTall(30)
    self.R:SetBGCol(PIXEL.Colors.Accents.Negative)
    self.G = vgui.Create("PIXEL.Slider", self)
    self.G:Dock(TOP)
    self.G:DockMargin(0, 10, 0, 0)
    self.G:SetTall(30)
    self.G:SetBGCol(PIXEL.Colors.Accents.Positive)
    self.B = vgui.Create("PIXEL.Slider", self)
    self.B:Dock(TOP)
    self.B:DockMargin(0, 10, 0, 0)
    self.B:SetTall(30)
    self.B:SetBGCol(PIXEL.Colors.Accents.Primary)
    self.R.OnValueChanged = self.OnValueChanged
    self.G.OnValueChanged = self.OnValueChanged
    self.B.OnValueChanged = self.OnValueChanged
end

function PANEL:GetColor()
    return Color(self.R:GetPercentage(255), self.G:GetPercentage(255), self.B:GetPercentage(255))
end

function PANEL:OnValueChanged(val)
    self:GetParent():OnColorChanged(self:GetParent():GetColor())
end

function PANEL:OnColorChanged(col)
end

function PANEL:SetColor(col)
    self.R:SetPercentage(col.r / 255)
    self.G:SetPercentage(col.g / 255)
    self.B:SetPercentage(col.b / 255)
end

vgui.Register("PIXEL.ColorPicker", PANEL, "Panel")