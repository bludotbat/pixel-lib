
_R = debug.getregistry()
_C = FindMetaTable("Color")
_P = FindMetaTable("Player")

PIXEL = PIXEL or {}
local curVersion = "1.0.0"

function PIXEL.loadDirectory(dir)
    local fil, fol = file.Find(dir .. "/*", "LUA")

    for k, v in ipairs(fil) do
        local dirs = dir .. "/" .. v

        if v:StartWith("cl_") then
            if SERVER then
                AddCSLuaFile(dirs)
            else
                include(dirs)
            end
        elseif v:StartWith("sh_") then
            AddCSLuaFile(dirs)
            include(dirs)
        else
            if SERVER then
                include(dirs)
            end
        end
    end

    for k, v in pairs(fol) do
        PIXEL.loadDirectory(dir .. "/" .. v)
    end
end

PIXEL.loadDirectory("pixellib")

PIXEL.Message("Checking for updates...", "Updater")
http.Fetch("https://docs.bluiscool.dev/curver.php", function(bod)
    if bod == curVersion then
        PIXEL.Message("No Updates - " .. bod, "Updater")
    else
        PIXEL.Message("Version " .. bod .. " is out! Download it at https://github.com/bludotbat/pixel-lib/", "Updater")
    end
end, function(err)
    PIXEL.Message("Failed to check for updates " .. err, "Updater")
end)

hook.Run("PIXEL.LIB.Loaded")
PIXEL.HasInit = true
PIXEL.Message("Loaded!", "Loader")