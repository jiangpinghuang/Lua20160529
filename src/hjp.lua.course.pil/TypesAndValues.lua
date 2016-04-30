print(type("Hello World"))
print(type(10.4*3))
print(type(print))
print(type(type))
print(type(true))
print(type(nil))
print(type(type(X)))

print(type(a))
a = 10
print(type(a))
a = "a string!!"
print(type(a))
a = print
a(type(a))
print(type(a))

print(0xff)
print(0x1A3)
print(0x0.2)
print(0x1p-1)
print(0xa.bp2)

a = "one string"
b = string.gsub(a,"one","another")
print(a)
print(b)

a = "hello"
print(#a)
print(#"good\0bye")

a = "a line"
b = 'another line'
print(a)
print(b)
print("\a")

print("one line\nnext\n\"in quotes\", 'in quotes'")
print('a backslash inside quotes: \'\\\'')
print("a simpler way: '\\'")

print("10" + 1)
print("10 + 1")
print("-5.3e-10"*"2")

print(10 .. 20)

line = io.read()
n = tonumber(line)
if n == nil then
  error(line .. " is not a valid number")
else
  print(n*2)
end

print(tostring(10) == "10")
print(10 .. "" == "10")

a = {}
k = "x"
a[k] = 10
a[20] = "great"
print(a["x"])
k = 20
print(a[k])
a["x"] = a["x"] + 1
print(a["x"])

a = {}
a["x"] = 10
b = a
print(b["x"])
b["x"]=20
print(a["x"])
a = nil
b = nil

a = {}
for i = 1, 1000 do a[i] = i * 2 end
print(a[9])
a["x"] = 10
print(a["x"])
print(a["y"])

a = {}
x = "y"
a[x] = 10
print(a[x])
print(a.x)
print(a.y)

a = {}
for i = 1, 10 do
  a[i] = io.read()
end

-- For sequences, lua offers the length operator '#'. 
-- It returns the last index, or the length, of the sequence.
for i = 1, #a do      
  print(a[i])
end

i = 10; j = "10"; j = "+10"
a = {}
a[i] = "one value"
a[j] = "another value"
a[k] = "yet another value"
print(a[i])
print(a[j])
print(a[k])
print(a[tonumber(j)])
print(a[tonumber(k4)])

-- Exercises
print(type(nil) == nil)
print(type(nil))

print(0x12)

a = {}; a.a = a
print(a.a.a.a)

