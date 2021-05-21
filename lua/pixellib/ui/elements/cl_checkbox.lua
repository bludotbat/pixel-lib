local PANEL = {}
AccessorFunc(PANEL, "r_text", "Text", FORCE_STRING)
AccessorFunc(PANEL, "r_checked", "Checked", FORCE_BOOL)
AccessorFunc(PANEL, "r_disabled", "Disabled", FORCE_BOOL)
AccessorFunc(PANEL, "r_isClicking", "IsClicked", FORCE_BOOL)
local font = PIXEL.GetFont(20)

function PANEL:Init()
    self.Colors = {}
    self:SetText("Checkbox")
    self:SetChecked(true)
    self.CheckElement = vgui.Create("PIXEL.Button", self)
    self.CheckElement:SetWide(PIXEL.Scale(25))

    self.CheckElement.DoClick = function(s)
        self:SetChecked(not self:GetChecked())
    end

    self.CheckElement.DoColorLerps = function(s)
        local frameTime = FrameTime() * 15

        if self:GetChecked() then
            if s:IsHovered() then
                self.CheckElement.Colors.Current = self.CheckElement.Colors.Current:Lerp(frameTime, s.Colors.HoveredChecked)
            end

            self.CheckElement.Colors.Checkmark = self.CheckElement.Colors.Checkmark:Lerp(frameTime, color_white)
            self.CheckElement.Colors.Current = self.CheckElement.Colors.Current:Lerp(frameTime, s.Colors.Checked)

            return
        end

        self.CheckElement.Colors.Checkmark = self.CheckElement.Colors.Checkmark:Lerp(frameTime, color_transparent)

        if s:IsHovered() then
            self.CheckElement.Colors.Current = self.CheckElement.Colors.Current:Lerp(frameTime, s.Colors.Normal)
        else
            self.CheckElement.Colors.Current = self.CheckElement.Colors.Current:Lerp(frameTime, s.Colors.Hovered)
        end
    end

    self.CheckElement.PaintOver = function(s, w, h)
        surface.SetDrawColor(s.Colors.Checkmark)
        PIXEL.DrawImgur(h * 0.10, w * 0.10, w * 0.90, h * 0.90, "9cg7YRt")
    end

    self.CheckElement.Colors.Current = PIXEL.Colors.Accents.Primary:Copy()
    self.CheckElement.Colors.Normal = PIXEL.Colors.Accents.Primary:Copy()
    self.CheckElement.Colors.Hovered = PIXEL.Colors.Accents.Primary:Offset(25)
    self.CheckElement.Colors.Checked = PIXEL.Colors.Accents.Positive:Offset(0)
    self.CheckElement.Colors.HoveredChecked = self.CheckElement.Colors.Checked:Offset(25)
    self.CheckElement.Colors.CurrentChecked = self.CheckElement.Colors.Checked:Copy()
    self.CheckElement.Colors.Checkmark = color_white
    self.CheckElement.Colors.Text = PIXEL.Colors.PrimaryText
    self.CheckElement.Colors.Disabled = PIXEL.Colors.DisabledText
end

function PANEL:PerformLayout()
    local w = PIXEL.GetTextSize(self:GetText(), font)
    self:SetWide(PIXEL.Scale(30) + w)
end

function PANEL:Paint(_, h)
    local w = PIXEL.Scale(30)
    PIXEL.DrawText(self:GetText(), font, w, h * 0.05, PIXEL.Colors.PrimaryText)
end

vgui.Register("PIXEL.Checkbox", PANEL, "Panel")