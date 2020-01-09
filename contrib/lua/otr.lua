package.path = package.path .. ";/lua/?.lua"
local gotify

function otr_init()
    local status, _gotify = pcall(require, "gotify")
    if(status) then
        gotify = _gotify
    else
        print("Gotify Module loading failed")
    end
end

function otr_transition(topic, _type, data)
    if (gotify) then
        gotify.push_message("geofence", data)
    else
        print(topic .. " : " .. data)
    end
end

function otr_exit()
    print("LUA: good bye\n")
end
