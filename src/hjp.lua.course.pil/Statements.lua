--a = "hello" .. " world"
--print(a)
--
--a, b = 10, 20
--print(a)
--print(b)
--a, b = b,a
--print(a)
--print(b)
--
--a, b, c = 0, 1
--print(a, b, c)
--a, b = a+1, b+1, b+2
--print(a, b)
--a, b, c = 0
--print(a, b, c)
--
--a, b, c = 0, 0, 0
--print(a, b, c)
--
--x = 10
--local i = 1
--
--while i <= x do
--  local x = i*2
--  print(x)
--  i = i + 1
--end
--
--if i > 20 then
--  local x 
--  x = 20
--  print(x + 2)
--else
--  print(x)
--end
--print(x)
--
--do
--  local a2 = 2 * a
--  local d = (b^2 - 4 * a *c)^(1/2)
--  x1 = (-b + d)/a2
--  x2 = (-b - d)/a2
--end
--print(x1, x2)
--
--local a, b = 1, 10
--if a < b then
--  print(a)
--  local a
--  print(a)
--end
--print(a, b)
--
--print(10000)
  
--if a < 0 then a = 0 end
--
--if a < b then return a else return b end
--
--if op == "+" then
--  r = a + b
--elseif op == "-" then
--  r = a - b
--elseif op == "*" then
--  r = a*b
--elseif op == "/" then
--  r = a/b
--else
--  error("invalid operation.")
--end
--
--local i = 1
--while a[i] do
--  print(a[i])
--  i = i + 1
--end
--
----repeat 
----  line = io.read()
----until line ~= ""
----print(line)
--
--local sqr = x/2
--repeat
--  sqr = (sqr + x/sqr)/2
--  local error = math.abs(sqr^2 - x)
--until error < x/10000
--
--for i = 10, 1, -1 do print(i) end
--
----for i = 1, math.huge do 
----  if (0.3 * i^3 - 20*i^2 - 500 >= 0) then
----    print(i)
----    break
----  end
----end
--
--for i = 1, 10 do print(i) end
--
--local found = nil
--for i = 1, #a do
--  if a[i] < 0 then
--    found = i
--    break
--  end
--end
--print(found)

days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
revDays = {["Sunday"] = 1, ["Monday"] = 2, ["Tuesday"] = 3, ["Wednesday"] = 4, ["Thursday"] = 5, ["Friday"] = 6, ["Saturday"] = 7}
t = "Tuesday"
print("****************************")
print(revDays[t])
revDays = {}
for k, v in pairs(days) do
  revDays[v] = k
end
--
--local i = 1
--while a[i] do
--  if a[i] == v then return i end
--  i = i + 1
--end

--::s1:: do
--  local c = io.read()
--  if c == '0' then goto s2
--  elseif c == nil then print("ok"); return
--  else goto s1
--  end
--end
--
--::s2:: do
--  local c = io.read()
--  if c == '0' then goto s1
--  elseif c == nil then print("not ok"); return
--  else goto s2
--  end
--end
--
--goto s1

goto room1

::room1:: do
  local move = io.read()
  if move == "south" then goto room3
  elseif move == "east" then goto room2
  else
    print("invalid move")
    goto room1
  end
end

::room2:: do
  local move = io.read()
  if move == "south" then goto room4
  elseif move == "west" then goto room1
  else
    print("invalid move")
    goto room2
  end
end

::room3:: do
  local move = io.read()
  if move == "north" then goto room1
  elseif move == "east" then goto room4
  else
    print("invalid move")
    goto room3
  end
end

::room4:: do
  print("Congratulations, you won!")
end
