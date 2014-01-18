#!/usr/bin/env lua

package.path = package.path .. ";lib/?.lua"
local T = require("tictaclib")
local play = require("play")

local function main(f1, f2)
    local p1, p2 = T.run(f1), T.run(f2)

    for xo, state, place_or_err, board in play(p1, p2) do
        if state == false then
            print (xo .. " error: " .. place_or_err)
        else
            local places = table.concat(place_or_err, "; ")
            print (xo .. " placed " .. "(" .. places .. ")")
            if state == "draw" then
                print ("draw")
            elseif state == "x" or state == "o" then
                print (state .. " won:")
                print (board)
            end
        end
    end
end

if arg and arg[0]:find("main.lua$") then
    if #arg ~= 2 then
        io.stderr:write("Usage: " .. arg[0] .. " player1.lua player2.lua\n")
        os.exit(1)
    else
        main(arg[1], arg[2])
    end
else
    return main
end
