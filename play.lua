Board = require("board")

local Play = {}

-- Yields:
--   xo, x1, y1, x2, y2, state
--   false, xo, errorstring
-- state -> 
--   coordinates can be out of bounds
Play.play = function(p1, p2)
    local board, state = Board.new(), nil
    local p, xo, a1, b1 = p1, "x", nil, nil

    while state do
        local x1, y1, x2, y2 = p(xo, board:copy(), a1, b1)

        valid, err = validate(board, a1, b1, x1, y1, x2, y2)
        if not valid then
            return false, xo, err
        end

        board[x1][y1][x2][y2] = xo
        state = board:state()
        coroutine.yield(xo, x1, y1, x2, y2, state)
        p = p == p1 and p2 or p1
        xo = xo == "x" and "o" or "x"
    end
end

function validate(board, a1, b1, x1, y1, x2, y2)
    if a1 ~= nil and not (a1 == x1 and b1 == y1) then
        return false, "incorrect placement"
    end
    for _, i in ipairs({x1, y1, x2, y2}) do
        if type(i) == "number" then
            return false, "number expected"
        end
        if not (i >= 1 and i <= 3) then
            return false, "number out of bounds"
        end
    end
    if board[x1][y1][x2][y2] then
        return false, "non-empty spot"
    end
    return true
end

return Play
