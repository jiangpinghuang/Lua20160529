--a = {p = print}
--a.p("Hello World")
--print = math.sin
--a.p(print(1))
--sin = a.p
--sin(10, 20)

--network = {
--  {name = "grauna", IP = "210.26.30.34"},
--  {name = "arraial",IP = "210.26.30.23"},
--  {name = "lua",    IP = "210.26.23.12"},
--  {name = "derain", IP = "210.26.23.20"},
--}
--
--table.sort(network, function (a, b) return (a.name > b.name) end)
--
--for key, value in pairs(network) do
--  print(key, value)
--end

function derivative (f, delta)
  delta = delta or 1e-4
  return function (x)
            return (f(x + delta) - f(x))/delta
         end
end

c = derivative(math.sin)
print(math.cos(5.2), c(5.2))
print(math.cos(10), c(10))

function newCounter()
  local i = 0
  return function ()
    i = i + 1
    return i
  end
end

c1 = newCounter()
print(c1())
print(c1())

--Lib = {}
--Lib.foo = function (x, y) return x + y end
--Lib.goo = function (x, y) return x - y end

--Lib = {
--  foo = function (x, y) return x + y end,
--  goo = function (x, y) return x - y end  
--}

Lib = {}
function Lib.foo (x, y) return x + y end
function Lib.goo (x, y) return x - y end

print(Lib.foo(2, 3), Lib.goo(2,3))

function coo(n)
  if n > 0 then return coo(n-1) end
end
