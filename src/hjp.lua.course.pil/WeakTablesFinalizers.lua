a = {}
b = {__mode = "k"}
setmetatable(a, b)
key = {}
a[key] = 1
key = {}
a[key] = 2
collectgarbage()
for k, v in pairs(a) do print(v) end

local results = {}
function mem_loadstring (s)
  local res = results[c]
  if res == nil then
    res = assert(load(s))
    results[s] = res
  end
  return res
end

local defaults = {}
setmetatable(defaults, {__mode = "k"})
local mt = {__index = function (t) return defaults[t] end}
function setDefault (t, d)
  defaults[t] = d
  setmetatable(t, mt)
end

local metas = {}
setmetatable(metas, {__mode = "v"})
function setDefault (t, d)
  local mt = metas[d]
  if mt == nil then
    mt = {__index = function () return d end}
    metas[d] = mt
  end
  setmetatable(t, mt)
end


function factory (o)
  return function () return o end
end

do 
  local mem = {}
  setmetatable(mem, {__mode = "k"})
  function factory (o)
    local res = mem[o]
    if not res then
      res = function () return o end
      mem[o] = res
    end
    return res
  end
end

mt = {__gc = function (o) print(o[1]) end}
list = nil
for i = 1, 3 do
  list = setmetatable({i, link = list}, mt)
end
list = nil
collectgarbage()

wk = setmetatable({}, {__mode = "k"})
wv = setmetatable({}, {__mode = "v"})

o = {}
wv[1] = o; wk[o] = 10
setmetatable(o, {__gc = function (o)
  print(wk[o], wv[1])
end})

o = nil; collectgarbage()