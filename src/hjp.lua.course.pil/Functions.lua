-- chapter 05 functions
print(8*9, 9/8)
a = math.sin(3) + math.cos(10)
print(a)
print(os.date())

function f(a,b) print(a, b) end
f(3)
f(2,3)
f(4,5,6)

s, e = string.find("hello Lua users","Lua")
print(s, e)

function maximum(a)
  local mi = 1
  local m = a[mi]
  for i = 1, #a do
    if a[i] > m then
      mi = i; m = a[i]
    end
  end
  return m, mi
end

print(maximum({8,10,23,12,5}))

print(table.unpack{10,20,30})
a, b = table.unpack{10,20,30}
print(a, b)

print(string.find("hello","ll"))

function add(...)
  local s = 0
  for i, v in ipairs{...} do 
    s = s + v
  end
  return s
end

print(add(3,4,10,25,12))

function foo(a, b, c)
  print(a, b, c)
end

function foo(...)
  local a, b, c, d= ...
  print(a, b, c, d)
end

foo(2,3,4,11,23)

function id(...) return ... end
cd = id("abc", 12, "efg", "#")
print(cd)

function fwrite(fmt, ...)
  return io.write(string.format(fmt,...))
end


function nonils(...)
  local arg =  table.pack(...)
  for i=1, arg.n do
    if arg[i] == nil then return false end
  end
  return true
end

print(nonils(2,3,nil))
print(nonils(2,3))
print(nonils())
print(nonils(nil))

function Window(options)
  if type(options.title) ~= "string" then
    error("no title")
  elseif type(options.width) ~= "number" then
    error("no width")
  elseif type(options.height) ~= "number" then
    error("no height") 
  end
  _Window(options.title,
          options.x or 0,
          options.y or 0, 
          options.width, options.height,
          options.background or "white",
          options.border)
  end
  
  w = Window{x = 0, y = 0, width = 300, height = 200, title = "Lua", background = "blue", border = true}