f = load("i = i + 1")
i = 0
f(); print(i)
f(); print(i)

f = function () i = i + 1 end
i = 0
f(); print(i)
f(); print(i)

i = 32
local i = 0
f = load("i = i + 1; print(i)")
g = function () i = i + 1; print(i) end
f()
g()

--print "enter your expression: "
--local l = io.read()
--local func = assert(load("return " .. l))
--print("the value of your expression is " .. func())
--
--print "enter function to be plotted (with variable 'x'):"
--local l1 = io.read()
--local f1 = assert(load("return " .. l1))
--for i = 1, 20 do
--  x = i
--  print(string.rep("*", f1()))
--end

f = load("local a = 10; print(a + 20)")
f()

--print "enter function to be plotted (with variable 'x'):"
--local l = io.read()
--local f = assert(load("local x = ...; return " .. l))
--for i = 1, 20 do 
--  print(string.rep("*", f(i)))
--end

--print "enter a number: "
--n = io.read("*n")
--if not n then error("invalid input!") end

--print "enter a number: "
--n = assert(io.read("*n"), "invalid input!")

--n = io.read()
--assert(tonumber(n), "invalid input: " ..n.. " is not a number!")
--
--file = assert(io.open("nofile","r"))

local status, err = pcall(function () error({code = 121}) end)
print(err.code)

--local status, err = pcall(function () a = "a" + 1 end)
--print(err)

--local status, err = pcall(function () error("my error") end)
--print(err)
--
---- Exercise 8.3
--function stringrep_5 (s)
--  local r = ""
--  r = r .. s
--  s = s .. s
--  s = s .. s
--  r = r .. s
--  print(r)
--  return r
--end
--
--str = io.read()
--print(str)
--print(stringrep_5(str))
--
--
--function stringrep (s, n)
--  local r = ""
--  if n > 0 then 
--    while n > 1 do
--      if n % 2 ~= 0 then r = r .. s end
--      s = s .. s
--      n = math.floor(n / 2)
--    end
--    r = r .. s
--  end
--  return r
--end
--
--print "enter a string:"
--s = io.read()
--print "enter a number:"
--n = io.read("*n")
--
--print(stringrep(s, n))

for i = 1, 100000 do
  print "fuck you!!!!"
  print "doctor PhD is a terrible life!!!"
end