print("Hello World!")

function fact(n)
  if n == 0 then
    return 1
  else
    return n * fact(n-1)
  end
end

print("Enter a number:")
num = io.read("*n")
if num < 0 then
  print("Error input, the number must more or equal 0, enter again:")
  num = io.read("*n")
end
print(fact(num))

function norm(x, y)
  return (x^2 + y^2)^0.5
end

function twice(x)
  return 2 * x
end

--[[
print(10)
--]]

---[[
print(20)
--]]

print(b)
b = 10
print(b)

b = nil
print(b)

print("Hi, Jiangping Huang!")

