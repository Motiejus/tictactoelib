
-- Places a move. Returns 4 numbers: x1, y1, x2, y2
-- where (x1, y1) is position on big board, x2, y2 - on small board.
-- Input: xo - "x" | "o" - player's side
local function move(xo, board, x1, y1)
    if x1 ~= nil then
        x2, y2 = move_small(board[x1][y1])
        return x1, y1, x2, y2
    else
        for row = 1, 3 do
            for col = 1, 3 do
                x2, y2 = move_small(board[row][col])
                if x2 ~= nil then
                    return x1, y1, x2, y2
                end
            end
        end
    end
end

-- Place a move on a small board
local function move_small(sboard)
    for row = 1, 3 do
        for col = 1, 3 do
            if sboard[row][col] == nil then
                return row, col
            end
        end
    end
end

return move
