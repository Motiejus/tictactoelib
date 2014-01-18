#!/usr/bin/lua

local T = require("lib.tictaclib")
local play = require("lib.play")

local function main()
    local p1, p2 = T.run(arg[1]), T.run(arg[2])

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

main()
