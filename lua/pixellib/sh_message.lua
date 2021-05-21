function PIXEL.Message(msg, namespace)
    if not namespace then
        print("[PIXEL] " .. msg)

        return
    end

    print("[PIXEL / " .. namespace .. "] " .. msg)
end