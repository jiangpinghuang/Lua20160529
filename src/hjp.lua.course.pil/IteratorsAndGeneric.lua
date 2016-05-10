function values (t)
  local i = 0
  return function () i = i + 1; return t[i] end
end

t = {10, 20, 30}
iter = values(t)
while true do 
  local element = iter()
  if element == nil then break end
  print(element)
end

t = {10, 20, 30}
for element in values(t) do
  print(element)
end

function allwords ()
  local line = io.read()
  local pos = 1
  return function ()
    while line do 
      local s, e = string.find(line, "%w+", pos)
      if s then
        pos = e + 1
        return string.sub(line, s, e)
      else
        line = io.read()
        pos = 1
      end
    end
    return nil
  end
end

a = {"one", "two", "three"}
for i, v in ipairs(a) do
  print(i, v)
end

function iterator (state)
  while state.line do
    local s, e = string.find(state.line, "%w+", state.pos)
    if s then
      state.pos = e + 1
      return string.sub(state.line, s, e)
    else
      state.line = io.read()
      state.pos = 1
    end
  end
  return nil
end

function allwords (f)
  for line in io.lines() do
    for word in string.gmatch(line, "%w+") do
      f(word)
    end
  end
end

allwords(print)

--local count = 0
--allwords(function(w)
--  if w == "hello" then count = count + 1 end
--end)
--print(count)

local count = 0
for w in allwords() do
  if w == "hello" then count = count + 1 end
end
print(count)