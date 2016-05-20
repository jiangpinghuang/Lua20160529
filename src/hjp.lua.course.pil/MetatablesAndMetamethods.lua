t = {}
print(getmetatable(t))

t1= {}
setmetatable(t, t1)
print(getmetatable(t) == t1)

--local mt = {}
--Set = {}
--function Set.new (l)
--  local set = {}
--  setmetatable(set, mt)
--  for _, v in ipairs(l) do set[v] = true end
--  return set
--end
--
--mt.__add = Set.union
--
--
--function Set.new (l)
--  local set = {}
--  for _, v in ipairs(l) do set[v] = true end
--  return set
--end
--
--function Set.union (a, b)
--  local res = Set.new{}
--  for k in pairs(a) do res[k] = true end
--  for k in pairs(b) do res[k] = true end
--  return res
--end
--
--function Set.intersection (a, b)
--  local res = Set.new{}
--  for k in pairs(a) do 
--    res[k] = b[k]
--  end
--  return res
--end
--
--function Set.tostring (set)
--  local l = {}
--  for e in pairs(set) do
--    l[#l + 1] = e
--  end
--  return "{" .. table.concat(1, ", ") .. "}"
--end
--
--function Set.print (s)
--  print(Set.tostring(s))
--end
--
--s1 = Set.new{10, 20, 30, 50}
--s2 = Set.new{30, 1}
--s3 = s1 + s2
--Set.print(s3)


t = {}
local _t = t
t = {}
local mt = {
  __index = function (t, k)
    print("*access to element " .. tostring(k))
    return _t[k]
  end,
  __newindex = function (t, k, v)
    print("*update of element " .. tostring(k).. " to " .. tostring(v))
    _t[k] = v
  end
}

setmetatable(t, mt)
t[2] = "hello"
print(t[2])


local index = {}
local mt = {
  __index = function (t, k)
    print("*access to element " .. tostring(k))
    return t[index][k]
  end,
  
  __newindex = function (t, k, v)
    print("*update of element " .. tostring(k) .. " to ".. tostring(v))
    t[index][k] = v
  end,
  __pairs = function (t)
        return function (t, k)
          return next(t[index], k)
        end, t
      end
}

function track (t)
  local proxy = {}
  proxy[index] = t
  setmetatable(proxy, mt)
  return proxy
end

function readOnly (t)
  local proxy = {}
  local mt = {
    __index = t, 
    __newindex = function (t, k, v)
      error("attempt to update a read-only table", 2)
    end
  }
  setmetatable(proxy, mt)
  return proxy
end

days = readOnly{"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"}
print(days[1])

