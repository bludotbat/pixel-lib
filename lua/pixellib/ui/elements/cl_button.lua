local font = PIXEL.GetFont(24)
local PANEL = {}
AccessorFunc(PANEL, "r_isClicking", "IsClicked", FORCE_BOOL)
AccessorFunc(PANEL, "r_disabled", "Disabled", FORCE_BOOL)
AccessorFunc(PANEL, "r_text", "Text")
AccessorFunc(PANEL, "r_image", "Image")
AccessorFunc(PANEL, "r_font", "Font")
AccessorFunc(PANEL, "r_hidebg", "HideBG")

function PANEL:Init()
    self:SetFont(font)
    self:SetText(false)
    self:SetImage("")
    self:SetCursor("hand")
    self.Colors = {}
    self.Colors.Current = PIXEL.Colors.Accents.Primary:Copy()
    self.Colors.Normal = PIXEL.Colors.Accents.Primary:Copy()
    self.Colors.Hovered = PIXEL.Colors.Accents.Primary:Offset(25)
    self.Colors.Clicked = PIXEL.Colors.Accents.Primary:Offset(0)
    self.Colors.Text = PIXEL.Colors.PrimaryText
    self.Colors.Disabled = PIXEL.Colors.DisabledText
end

function PANEL:ClearColors()
    self.Colors.Current = PIXEL.Colors.Transparent
    self.Colors.Normal = PIXEL.Colors.Transparent
    self.Colors.Hovered = PIXEL.Colors.Transparent
    self.Colors.Clicked = PIXEL.Colors.Transparent
    self.Colors.Disabled = PIXEL.Colors.Transparentx
    self.Colors.Text = PIXEL.Colors.PrimaryText
end

function PANEL:Paint(w, h)
    self:DoColorLerps()

    if self:GetImage() ~= "" then
        surface.SetDrawColor(self.Colors.Current)
        PIXEL.DrawImgur(0, 0, w, h, self:GetImage())

        return
    end

    if not self:GetHideBG() then
        PIXEL.DrawRoundedBox(PIXEL.Scale(6), 0, 0, w, h, self.Colors.Current)
    end

    if self:GetText() then
        PIXEL.DrawText(self:GetText(), self:GetFont(), w / 2, h / 2, self.Colors.Text, 1, 1)
    end
end

function PANEL:DoColorLerps()
    if self:IsHovered() then
        self.Colors.Current = self.Colors.Current:Lerp(FrameTime() * 10, self.Colors.Hovered)

        return
    end

    if self:GetDisabled() then
        self.Colors.Current = self.Colors.Current:Lerp(FrameTime() * 10, self.Colors.Disabled)

        return
    end

    if self:GetIsClicked() then
        self.Colors.Current = self.Colors.Current:Lerp(FrameTime() * 10, self.Colors.Clicked)

        return
    end

    self.Colors.Current = self.Colors.Current:Lerp(FrameTime() * 10, self.Colors.Normal)
end

function PANEL:Think()
    if self.r_isClicking and not self:IsHovered() then
        self.r_isClicking = false
    end
end

function PANEL:OnMousePressed(m)
    self.r_isClicking = m
end

function PANEL:OnMouseReleased()
    if not self.r_isClicking then return end

    if self.r_isClicking == MOUSE_LEFT then
        if not self.DoClick then return end
        self:DoClick()
    else
        if not self.DoRightClick then return end
        self:DoRightClick()
    end
end

function PANEL:SizeToText(pad)
    self:SetWide(PIXEL.GetTextSize(self:GetText(), self:GetFont()) + (pad or 10))
end

function PANEL:DoClick()
end

function PANEL:DoRightClick()
end

vgui.Register("PIXEL.Button", PANEL, "Panel")