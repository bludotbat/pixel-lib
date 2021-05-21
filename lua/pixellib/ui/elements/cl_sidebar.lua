local PANEL = {}
AccessorFunc(PANEL, "r_icon", "Icon")
AccessorFunc(PANEL, "r_text", "Text")
AccessorFunc(PANEL, "r_color", "Color")
AccessorFunc(PANEL, "r_activebtn", "Active")

function PANEL:Init()
    self:SetColor(PIXEL.Colors.Accents.Primary)
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(PIXEL.Colors.SecondaryText)
    PIXEL.DrawImgur(10, 10, h - 20, h - 20, "C9Sm90a")
    PIXEL.DrawText(self:GetText(), self:GetFont(), h, h / 2, PIXEL.Colors.SecondaryText, 0, 1)
end

function PANEL:SetText(text, ww, hh)
    self.r_text = text
end

function PANEL:PerformLayout(w, h)
    self.r_text = PIXEL.CroppedText(self:GetText(), self:GetFont(), w - h)
end

vgui.Register("PIXEL.Sidebar.Button", PANEL, "PIXEL.Button")
local PANEL = {}

function PANEL:Init()
    self.Items = {}
    self:MakeControls()
end

function PANEL:MakeControls()
    self.Controls = vgui.Create("Panel", self)
    self.Controls.Collapse = vgui.Create("PIXEL.Button", self.Controls)
    self.Controls.Collapse.Rot = 180
    self.Controls.Collapse:SetPos(0, 0)
    self.Controls.Collapse:SetHideBG(true)

    self.Controls.Collapse.PaintOver = function(s, w, h)
        surface.SetDrawColor(color_white)
        PIXEL.DrawImgurRotated(h / 2 - 12, 10, w - 24, h - 24, "NAbsUIS", s.Rot)
    end

    self.Controls.Collapse.DoClick = function(s)
        if self.Collapsed then
            self.Collapsed = false
        else
            self.Collapsed = true
        end
    end

    self.Controls.Collapse.Think = function(s)
        if self.Collapsed then
            s.Rot = Lerp(FrameTime() * 10, s.Rot, 0)
        else
            s.Rot = Lerp(FrameTime() * 10, s.Rot, 180)
        end
    end
end

function PANEL:Think()
    local w = self:GetWide()

    if self.Collapsed and w > 51 then
        self:SetWide(w - 3.5)
    elseif not self.Collapsed and w < 200 then
        self:SetWide(w + 3.5)
    end
end

function PANEL:PerformLayout(w, h)
    local s50 = PIXEL.Scale(50)
    local s10 = PIXEL.Scale(10)
    local s200 = PIXEL.Scale(200)
    self.Controls:SetPos(0, 0)
    self.Controls:SetSize(s50, s50)
    self.Controls.Collapse:SetSize(s50, s50)

    for index, v in pairs(self.Items) do
        if IsValid(v) then
            v:SetPos(0, index * (s50))
            v:SetSize(s200, s50)
        end
    end
end

function PANEL:Paint(w, h)
    PIXEL.DrawRoundedBoxEx(PIXEL.Scale(6), 0, 0, w, h, PIXEL.Colors.Header, false, false, true, fals)
end

function PANEL:AddButton(name, icon, color, func)
    local p = vgui.Create("PIXEL.Sidebar.Button", self)
    p:SetText(name or "Invalid")
    p:SetIcon(icon)
    p:SetColor(color or PIXEL.Colors.Accents.Primary)

    p.DoClick = function(...)
        self:SetActive(p)
        func(...)
    end

    self.Items[#self.Items + 1] = p
    self:PerformLayout(self:GetSize())
end

vgui.Register("PIXEL.Sidebar", PANEL, "Panel")
PIXEL.SidebarLoaded = true
hook.Run("PIXEL.LoadSidebarPanel")