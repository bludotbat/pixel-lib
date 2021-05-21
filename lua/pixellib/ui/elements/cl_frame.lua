local titleFont = PIXEL.GetFont(25)
local PANEL = {}
AccessorFunc(PANEL, "r_text", "Title", FORCE_STRING)
AccessorFunc(PANEL, "r_image", "Image", FORCE_STRING)
AccessorFunc(PANEL, "r_istopandside", "HasTopbarAndSidebar")

function PANEL:Init()
    self:SetTitle("PIXEL Lib")
    self:SetImage("")
    self.Topbar = vgui.Create("Panel", self)
    self.Topbar:Dock(TOP)
    self.Topbar:SetTall(PIXEL.Scale(30))
    self.CloseBtn = vgui.Create("PIXEL.Button", self.Topbar)
    self.CloseBtn:Dock(RIGHT)
    self.CloseBtn:SetWide(PIXEL.Scale(16))
    self.CloseBtn:DockMargin(0, PIXEL.Scale(7), PIXEL.Scale(7), PIXEL.Scale(7))
    self.CloseBtn:SetImage("ijhNGV8")
    self.CloseBtn.Colors.Current = PIXEL.Colors.Accents.Negative:Copy()
    self.CloseBtn.Colors.Normal = PIXEL.Colors.Accents.Negative:Copy()
    self.CloseBtn.Colors.Hovered = color_white:Offset(-60)

    self.CloseBtn.DoClick = function()
        self:Remove()
    end

    self.Topbar.Paint = function(s, w, h)
        local s6 = PIXEL.Scale(6)
        PIXEL.DrawRoundedBoxEx(PIXEL.Scale(s6), 0, 0, w, h, PIXEL.Colors.Header, true, true)

        if self:GetImage() == "" then
            PIXEL.DrawText(self:GetTitle(), titleFont, PIXEL.Scale(s6), PIXEL.Scale(2), PIXEL.Colors.PrimaryText, 0, 0)
        else
            local s7 = PIXEL.Scale(7)
            local s16 = PIXEL.Scale(16)
            surface.SetDrawColor(color_white)
            PIXEL.DrawImgur(s7, s7, s16, s16, self:GetImage())
            PIXEL.DrawText(self:GetTitle(), titleFont, PIXEL.Scale(s6) + PIXEL.Scale(24), PIXEL.Scale(2), PIXEL.Colors.PrimaryText, 0, 0)
        end
    end
end

function PANEL:CreateSidebar()
    self.Sidebar = vgui.Create("PIXEL.Sidebar", self)
    self.Sidebar:Dock(LEFT)
    self.Sidebar:SetWide(PIXEL.Scale(200))

    return self.Sidebar
end

function PANEL:CreateLegacySidebar()
    self.Sidebar = vgui.Create("PIXEL.Legacy.Sidebar", self)
    self.Sidebar:Dock(LEFT)
    self.Sidebar:SetWide(PIXEL.Scale(200))

    return self.Sidebar
end

function PANEL:Paint(w, h)
    local s6 = PIXEL.Scale(6)
    PIXEL.DrawRoundedBox(s6, 0, 0, w, h, PIXEL.Colors.Background)
end

vgui.Register("PIXEL.Frame", PANEL, "EditablePanel")