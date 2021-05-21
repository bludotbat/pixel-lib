local font = PIXEL.GetFont(22)
local PANEL = {}
AccessorFunc(PANEL, "r_activebtn", "Active") -- Internal

function PANEL:Init()
    self.barX = 0
    self.barW = 100
    self.curCol = Color(0, 0, 255)
end

function PANEL:AddButton(name, color, func)
    local p = vgui.Create("PIXEL.Button", self)
    p:Dock(LEFT)
    p:SetText(name)
    p:SizeToText(20)
    p:ClearColors()
    p:SetFont(font)
    p.Color = color or PIXEL.Colors.Accents.Primary

    p.DoClick = function(s)
        if self:GetActive() == s then return end
        self:SetActive(s)
        func(s)
    end

    if not self.buttonList then
        self.buttonList = {}
        self.buttonList[name] = p
        self:SetActive(p)
        self.curCol = p.Color
        self.barW = p:GetWide()

        return p, true
    end

    return p, false
end

function PANEL:GetButton(name)
    return (self.buttonList or {})[name]
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(PIXEL.Colors.Header)
    surface.DrawRect(0, 0, w, h)
    local active = self:GetActive()
    if not active then return end

    if active:GetX() ~= self.barX or active:GetWide() ~= self.barW or active.Color ~= self.curCol then
        local ft = FrameTime() * 4
        self.barX = Lerp(ft, self.barX, active:GetX())
        self.barW = Lerp(ft, self.barW, active:GetWide())
        self.curCol = self.curCol:Lerp(ft, active.Color)
    end

    surface.SetDrawColor(self.curCol)
    surface.DrawRect(self.barX + 2, h - 4, self.barW - 4, 2)
end

vgui.Register("PIXEL.Navbar", PANEL, "Panel")