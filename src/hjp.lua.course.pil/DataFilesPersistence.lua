function quote (s)
  local n = -1
  for w in string.gmatch(s, "]=*]") do
    n = math.max(n, #w - 2)
  end
  
  local eq = string.rep("=", n + 1)
  return string.format(" [%s[\n%s]%s] ", eq, s, eq)
end 

function serialize (o)
  if type(o) == "number" then
    io.write(o)
  elseif type(o) == "string" then
    io.write(string.format("%q", o))
  elseif type(o) == "table" then
    io.write("{\n")
    for k, v in pairs(o) do
      io.write("   ", k, " = ")
      serialize(v)
      io.write(",\n")
    end
    io.write("}\n")
  else
    error("cannot serialize a " .. type(o))
  end
end

--io.write(" ["); serialize(k); io.write("] = ")
serialize{a = 12, b = 'Lua', key = 'another "one"'}


function basicSerialize (o)
  if type(o) == "number" then
    return tostring(o)
  else
    return string.format("%q", o)
  end
end

function save (name, value, saved)
  saved = saved or {}
  io.write(name, " = ")
  if type(value) == "number" or type(value) == "string" then
    io.write(basicSerialize(value), "\n")
  elseif type(value) == "table" then
    if saved[value] then
      io.write(saved[value], "\n")
    else
      saved[value] = name
      io.write("{}\n")
      for k, v in pairs(value) do
        k = basicSerialize(k)
        local fname = string.format("%s[%s]", name, k)
        save(fname, v, saved)
      end
    end
  else
    error("cannot save a " .. type(value))
  end
end

local t = {}
save("a", a, t)
save("b", b, t)