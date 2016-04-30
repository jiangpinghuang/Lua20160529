a = 11
b = 3
print(a % b)

c = a - math.floor(a / b) * b
print(c)

x = math.pi
print(x - x%0.01)

local tolerance = 10
function isturnback(angle)
  angle = angle % 360
  return (math.abs(angle - 100) < tolerance)
end

print(isturnback(105))

a = {}; a.x = 1; a.y = 0
b = {}; b.x = 1; b.y = 0
c = a
print(a)
print(b)
print(c)

print(4 and 5)
print(nil and 13)
print(false and 13)
print(4 or 5)
print(false or 5)


y = 4
v = 5
if not k then k =v end
print(k)

print((y > v) and y or v)

print(not nil)
print(not false)
print(not 0)
print(not not 1)
print(not not nil)

print("Hello " .. "World")
print(10 .. 01)         -- will delete the prefix zero.
print(3000 .. 00001)

a = "Hello"
print(a .. " World")
print(a)

print(a[#a])

m = {}
m[1] = 1
m[2] = nil
m[3] = 1
m[4] = 1

print(m[1])
print(m[2])
print(m[4])

m[1000] = 10
print(m[1000])
print(m[888])
print(m[1111])
print(#m)

x = 3
print(5+x^2*8)

days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
print(days[4])
a = {x = 10, y = 20}
print(a.x)
print(a.y)

w = {x = 0, y = 0, label = "console"}
x = {math.sin(0), math.sin(1), math.sin(2)}
w[1]="another field"
x.f = w
print(w["x"])
print(w[1])
print(x.f[1])
w.x = nil

polyline = {color = "blue",
  thickness = 2,
  npoints = 3,
  {x = 0, y = 0},
  {x = -10, y = 0},
  {x = -10, y = 1},
  {x = 0, y = 1}}
  
print(polyline.color)
print(polyline[2].x)
print(polyline[4].y)

opnames = {["+"] = "add", ["-"] = "sub", ["*"] = "mul", ["/"] = "div"}
i = 20; s = "-"
a = {[i+0]=s, [i+1]=s..s, [i+2] = s..s..s}
print(opnames[s])
print(a[22])

a = {[1]="red", [2]="green", [3]="blue",}
c = {x= 10, y = 45; "one", "two", "three"}
print(a[1])
print(c.x)
print(c[1])

for i = -10, 10 do
  print(i, i % 3)
end

sunday = "monday"; monday = "sunday"
t = {sunday = "monday", [sunday] = "monday"}
print(t.sunday, t[sunday], t[t.sunday])
print(monday)
print(sunday)
print(t.sunday, t[sunday], t[t.sunday], t[monday])

