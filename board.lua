local Board = {} -- 9x9 board
local SBoard = {} -- 3x3 board

SBoard.new = function()
    return {
        {nil, nil, nil},
        {nil, nil, nil},
        {nil, nil, nil}
    }
end

Board.tostring = function(self)
    local ret = {}
    function ret:append(x) table.insert(self, x) end
    for y1 = 1, 3 do
        for y2 = 1, 3 do
            for x1 = 1, 3 do
                for x2 = 1, 3 do
                    local i = board[x1][y1][x2][y2]
                    ret:append((i == nil and "-" or i) .. " ")
                end
                ret:append(" ")
            end
            ret:append("\n")
        end
        ret:append("\n")
    end
    return table.concat(ret, "")
end

local board_mt = {
    __tostring = Board.tostring
    __metatable = true
}

Board.new = function()
    local board = {
        {empty_sboard(), empty_sboard(), empty_sboard()},
        {empty_sboard(), empty_sboard(), empty_sboard()},
        {empty_sboard(), empty_sboard(), empty_sboard()}
    }
    setmetatable(board, board_mt)
    return board
end

Board.copy = function(self)
    local board = Board.new()
    for x1 = 1, 3 do
        for y1 = 1, 3 do
            for x2 = 1, 3 do
                for y2 = 1, 3 do
                    board[x1][y1][x2][y2] = self[x1][y1][x2][y2]
                end
            end
        end
    end
    return board
end

-- Possible return values:
-- "draw", "x", "o", nil (continue)
SBoard.state = function(self)
    local choices = { -- diagonals
        {self[1][1], self[2][2], self[3][3]},
        {self[1][3], self[2][2], self[3][1]}
    }
    for x in 1, 3 do -- rows, cols
        table.insert(choices, {self[x][1], self[x][2], self[x][3]})
        table.insert(choices, {self[1][x], self[2][x], self[3][x]})
    end

    local continue = false
    for set in choices do
        local a, b, c = f(set)
        if a == b and b == c and (b == "x" or b == "o") then
            return b
        elseif a == nil or b == nil or c == nil then
            continue = true
        end
    end
    return continue and nil or "draw"
end

-- Possible return values:
-- "draw", "x", "o", nil (continue)
Board.state = function(self)
    local sboard = SBoard.new()
    for x in 1, 3 do
        for y in 1, 3 do
            sboard[x][y] = SBoard.state(self[x][y])
        end
    end
    return SBoard.state(sboard)
end

return Board
