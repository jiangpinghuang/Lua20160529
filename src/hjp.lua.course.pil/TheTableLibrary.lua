--t = {}
--for line in io.lines() do
--  table.insert(t, line)
--end
--print(#t)

lines = {
  luaH_set = 10,
  luaH_get = 24,
  luaH_present = 48,
}

a = {}
for n in pairs(lines) do a[#a+1] = n  end
table.sort(a)
for _, n in ipairs(a) do print(n) end


function pairsByKeys (t, f)
  local a= {}
  for n in pairs(t) do a[#a + 1] = n end
  table.sort(a, f)
  local i = 0
  return function ()
    i = i + 1
    return a[i], t[a[i]]
  end
end

for name, line in pairsByKeys(lines) do
  print(name, line)
end

function rconcat (l)
  if type(l) ~= "table" then return l end
  local res = {}
  for i = 1, #l do 
    res[i] = rconcat(l[i])
  end
  return table.concat(res)
end

print(rconcat{{"a", {" nice"}}, " and", {{" long"}, {" list"}}})
print(rconcat({{{"a", "b"}, {"c"}}, "d", {}, {"e"}}, ";"))
