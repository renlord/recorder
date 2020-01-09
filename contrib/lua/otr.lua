package.path = package.path .. ";/lua/?.lua"
local gotify

local function tprint (tbl, indent)
  if not indent then indent = 0 end
  for k, v in pairs(tbl) do
    formatting = string.rep("  ", indent) .. k .. ": "
    if type(v) == "table" then
      print(formatting)
      tprint(v, indent+1)
    else
      print(formatting .. tostring(v))
    end
  end
end

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
        print(topic.." : ".._type.." : "..tprint(data, nil))
        m = "User "..data['tid'].." "..data['event'].." "..data['desc'].."."
        gotify.push_message("geofence", m)
    else
        print(topic .. " : " ..tprint(data, nil))
    end
end

function otr_exit()
    print("LUA: good bye\n")
end
