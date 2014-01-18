--[[
Example player implementation

A file must return a function which:
1. takes 4 arguments:
1.1. xo ("x" or "o")
1.2. board (3x3x3x3 table)
1.3. x1 (number 1..3 or nil, which board to use, row)
1.4. y1 (number 1..3 or nil, which board to use, col)

board table is indexable like this: [big row][big col][small row][small col]

For example, board[1][3][2][2] means
1. pick a 3x3 board at first row, third column
2. middle point in that small board (row 2, col 2)

Large and small boards are printable:

    print (board) -- prints full board (3x3x3x3)
    print (board[2][2]) -- prints central board (3x3)

small board object also has helper functions:

    board[x][y]:state()

which return either:
* nil (noone won, slots available)
* "x" or "o" (x or o won)
* "draw"
--]]


-- Places a move on a small board
local function move_small(sboard)
    for x = 1, 3 do
        for y = 1, 3 do
            if sboard[x][y] == nil then
                return x, y
            end
        end
    end
end


-- Places a move on a big board
local function move(xo, board, x1, y1)
    local x2, y2
    if x1 ~= nil then
        x2, y2 = move_small(board[x1][y1])
        return x1, y1, x2, y2
    else
        for row = 1, 3 do
            for col = 1, 3 do

                -- If there are slots on board[row][col]
                -- (see above for state method)
                if board[row][col]:state() == nil then
                    -- loop until empty slot found
                    while x2 == nil and y2 == nil do
                        x2, y2 = move_small(board[row][col])
                    end
                    return row, col, x2, y2
                end
            end
        end
    end
end

return move
