local PANEL = {}
AccessorFunc(PANEL, "r_icon", "Icon")
AccessorFunc(PANEL, "r_text_leg", "Text")

function PANEL:Init()
    self.Colors.Normal = Color(55, 55, 55)
    self.Colors.Hovered = self.Colors.Normal:Offset(10)
    self.Colors.Current = self.Colors.Normal
end

function PANEL:CreateHeaderImage(img)
    self.Header = vgui.Create("Panel", self)
    self.Header:Dock(TOP)

    self.Header.Paint = function(s, w, h)
        surface.SetDrawColor(color_white)
        PIXEL.DrawImgur(10, 10, w - 20, h - 20, img)
    end
end

function PANEL:PerformLayout(w, h)
    if IsValid(self.Header) then
        self.Header:SetTall(wide)
    end

    self.r_text_leg = PIXEL.CroppedText(self:GetText(), self:GetFont(), w - h)
end

function PANEL:Paint(w, h)
    self:DoColorLerps()
    PIXEL.DrawRoundedBox(PIXEL.Scale(6), 0, 0, w, h, self.Colors.Current)
    surface.SetDrawColor(PIXEL.Colors.PrimaryText)
    PIXEL.DrawText(self:GetText(), self:GetFont(), h, h / 2, color_white, 0, 1)
    PIXEL.DrawImgur(10, 10, h - 20, h - 20, "C9Sm90a")
end

vgui.Register("PIXEL.Legacy.Sidebar.Button", PANEL, "PIXEL.Sidebar.Button")
PANEL = {}
PANEL.PerformLayout = function() end

function PANEL:Init()
    self.Controls:Remove()
end

function PANEL:AddItem(name, icon, func)
    local p = vgui.Create("PIXEL.Legacy.Sidebar.Button", self)
    p:Dock(TOP)
    p:DockMargin(5, 5, 5, 0)
    p:SetTall(PIXEL.Scale(50))
    p:SetText(name or "Invalid")
    p:SetIcon(icon)
    p.Func = func or print

    p.DoClick = function(s, ...)
        s.Func(s, ...)
    end

    self.Items[#self.Items + 1] = p
    self:PerformLayout(self:GetSize())
end

if PIXEL.SidebarLoaded then
    vgui.Register("PIXEL.Legacy.Sidebar", PANEL, "PIXEL.Sidebar")
end

hook.Add("PIXEL.LoadSidebarPanel", "PIXEL.LIB.LoadLegacySidebar", function()
    vgui.Register("PIXEL.Legacy.Sidebar", PANEL, "PIXEL.Sidebar")
end)