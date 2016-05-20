for n in pairs(_G) do print(n) end

function getfield (f)
  local v = _G
  for w in string.gmatch(f, "[%w_]+") do
    v = v[w]
  end
  return v
end

function setfield (f, v)
  local t = _G
  for w, d in string.gmatch(f, "([%w_]+)(%.?)") do
    if d == "." then
      t[w] = t[w] or {}
      t = t[w]
    else
      t[w] = v
    end
  end
end

setfield("t.x.y", 10)

print(t.x.y)
print(getfield("t.x.y"))


local declaredNames = {}

setmetatable(_G, {
  __newindex = function (t, n, v)
    if not declaredNames[n] then
      local w = debug.getinfo(2, "S").what
      if w ~= "main" and w ~= "C" then
        error("attempt to write to undeclared variable "..n, 2)
      end
      declaredNames[n] = true
    end
    rawset(t, n, v)
  end,
  
  __index = function (_, n)
    if not declaredNames[n] then
      error("attempt to read undeclared variable "..n, 2)
    else
      return nil
    end
  end,
})

local print, sin = print, math.sin
_ENV = nil
print(13)
print(sin(13))
print(math.cos(13))

a = 13
local a = 12
print(a)
--print(_ENV.a)

function factory (_ENV)
  return function ()
    return a
  end
end

f1 = factory{a = 6}
f2 = factory{a = 7}
print(f1())
print(f2())
