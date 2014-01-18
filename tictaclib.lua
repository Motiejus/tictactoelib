local T = {}

local function shallow_copy(tbl)
    local new_tbl = {}
    for k, v in pairs(math) do
        new_tbl[k] = v
    end
    return new_tbl
end

local env = {
    print=print, -- disable on prod

    tostring=tostring, unpack=unpack, next=next, assert=assert,
    tonumber=tonumber, pairs=pairs, pcall=pcall, type=type, select=select,
    ipairs=ipairs, _VERSION=_VERSION, error=error,

    math=shallow_copy(math), table=shallow_copy(table),
    coroutine=shallow_copy(coroutine)
}

T.run = function(filename)
    local user_function, message = loadfile(filename)
    if not user_function then return nil, message end
    setfenv(user_function, env)
    local err, fun = pcall(user_function)
    assert(err, "bad user function")
    return fun
end

T.StringBuffer = function()
    local ret = {}
    local bfr_mt = {
        __concat = function(self, x) table.insert(self, x); return self end,
        __tostring = function(self) return table.concat(self, "") end
    }
    setmetatable(ret, bfr_mt)
    return ret
end

return T
