do
    local insert = table.insert
    local rad, sin, cos = math.rad, math.sin, math.cos

    function PIXEL.CreateCircle(x, y, ang, seg, pct, radius)
        local circle = {}

        insert(circle, {
            x = x,
            y = y
        })

        for i = 0, seg do
            local segAngle = rad(((i / seg) * -pct + ang))

            insert(circle, {
                x = x + sin(segAngle) * radius,
                y = y + cos(segAngle) * radius
            })
        end

        return circle
    end
end

local createCircle = PIXEL.CreateCircle
local drawPoly = surface.DrawPoly

function PIXEL.DrawCircleUncached(x, y, ang, seg, pct, radius)
    local test = createCircle(x, y, ang, seg, pct, radius)
    drawPoly(test)
end