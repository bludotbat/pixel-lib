local function lerpCol(amt, fr, to)
    return Color(Lerp(amt, fr.r, to.r), Lerp(amt, fr.g, to.g), Lerp(amt, fr.b, to.b), Lerp(amt, fr.a, to.a))
end

function _C:Copy()
    return Color(self.r, self.g, self.b, self.a)
end

function _C:Offset(off)
    return Color(self.r + off, self.g + off, self.b + off)
end

function _C:Lerp(amt, to)
    return lerpCol(amt, self, to)
end

function _C:__eq(to)
    return self.r == to.r and self.g == to.g and self.b == to.b and self.a == to.a
end