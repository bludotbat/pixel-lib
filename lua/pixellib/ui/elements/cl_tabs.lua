local PANEL = {}
AccessorFunc(PANEL, "r_activesheet", "ActiveSheet")
AccessorFunc(PANEL, "r_animtime", "AnimTime")

function PANEL:Init()
    self:SetAnimTime(0.2)
    self.Navbar = vgui.Create("PIXEL.Navbar", self)
    self.Navbar:Dock(TOP)
    self.Navbar:SetTall(PIXEL.Scale(50))
    self.Canvas = vgui.Create("Panel", self)
    self.Canvas:Dock(FILL)

    self.Canvas.PerformLayout = function(s, w, h)
        if not self:GetActiveSheet() then return end
        self:GetActiveSheet():SetSize(w, h)
    end
end

function PANEL:SheetChanged(sheet)
end

function PANEL:AddTab(name, color, callback)
    local sheet = vgui.Create("Panel", self.Canvas)
    sheet:SetVisible(false)
    sheet:SetSize(0, 0)

    local btn, isFirst = self.Navbar:AddButton(name, color, function(...)
        if sheet == self:GetActiveSheet() then return end
        self:SetActiveTab(sheet)
        callback(...)
        self:SheetChanged(sheet)
    end)

    sheet.button = btn

    if isFirst then
        self:SetActiveSheet(sheet)
        sheet:SetVisible(true)
        sheet:SetSize(self:GetExpectedSheetSize())
    end

    return sheet, btn
end

function PANEL:GetExpectedSheetSize()
    local w, h = self:GetSize()

    return w, h - self.Navbar:GetTall()
end

function PANEL:SetActiveTab(sheet)
    local act = self:GetActiveSheet()

    if act then
        act:AlphaTo(0, self:GetAnimTime(), 0, function()
            act:SetVisible(false)
            act:SetSize(0)
            self:SetActiveSheet(sheet)
            sheet:SetVisible(true)
            sheet:SetSize(self:GetExpectedSheetSize())
            sheet:SetAlpha(0)
            sheet:AlphaTo(255, self:GetAnimTime(), 0)
        end)
    else
        self:SetActiveSheet(sheet)
    end
end

function PANEL:PerformLayout()
    if not IsValid(self:GetActiveSheet()) then return end
    self:GetActiveSheet():SetSize(self:GetExpectedSheetSize())
end

vgui.Register("PIXEL.Tabs", PANEL, "Panel")