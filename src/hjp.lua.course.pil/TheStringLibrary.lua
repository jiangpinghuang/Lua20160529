s = "[in brackets]"
print(s:sub(2, -2))
print(s)

s = s:sub(2, -2)
print(s)

print(string.char(97))
i = 99
print(string.char(i, i+1, i+2))
print(string.byte("abc"))
print(string.byte("abc", 2))
print(string.byte("abc", -1))
print(string.byte("abc", 1, 2))

print(string.format("pi = %.4f", math.pi))
d = 5; m = 11; y = 1990
print(string.format("%02d/%02d/%04d", d, m, y))
tag, title = "h1", "a title"
print(string.format("<%s>%s</%s>", tag, title, tag))

s = "hello world"
i, j = string.find(s,"hello")
print(i, j)
print(string.sub(s,i,j))
print(string.find(s,"world"))
i, j = string.find(s,"l")
print(i, j)
print(string.find(s, "lll"))

local t = {}
local i = 0
while true do
  i = string.find(s, "\n", i+1)
  if i == nil then break end
  t[#t + 1] = i
end

print(string.match("hello world", "hello"))

date = "Today is 26/5/2016"
d = string.match(date, "%d+/%d+/%d+")
print(d)

s = string.gsub("Lua is cute","cute", "great")
print(s)
s = string.gsub("all lii", "l", "x")
print(s)
s = string.gsub("Lua is great","Sol","Sun")
print(s)

s = string.gsub("all lii", "l", "x", 1)
print(s)
s = string.gsub("all lii", "l", "x", 2)
print(s)

str = "hello world"
count = select(2, string.gsub(str, " ", " "))
print(count)

words = {}
for w in string.gmatch(s,"%a+") do
  words[#words + 1] = w
end

function search (modname, path)
  modname = string.gsub(modname, "%.", "/")
  for c in string.gmatch(path, "[^;]+") do
    local fname = string.gsub(c, "?",modname)
    local f = io.open(fname)
    if f then
      f:close()
      return fname
    end
  end
  return nil
end

s = "Deadline is 30/05/1999, firm"
date = "%d%d/%d%d/%d%d%d%d"
print(string.sub(s, string.find(s, date)))
print(string.gsub("hello, up-down!","%A", "."))

print(string.gsub("one, and two; and three", "%a+", "word"))
print(string.match("the number 1298 is even", "%d+"))

test = "int x; /* x */ int y; /* y */"
print(string.match(test, "/%*.*%*/"))
print(string.gsub(test, "/%*.-%*/",""))

s = "a (enclosed (in) parentheses) line"
print(string.gsub(s, "%b()", ""))

s = "the anthem is the theme"
print(s:gsub("%f[%w]the%f[%W]","one"))

pair = "name = Anna"
key, value = string.match(pair, "(%a+)%s*=%s*(%a+)")
print(key, value)

date = "Today is 26/05/2016"
d, m, y = string.match(date, "(%d+)/(%d+)/(%d+)")
print(d, m, y)
s = [[then he said: "it's all right"!]]
q, quotedPart = string.match(s,"([\"'])(.-)%1")
print(quotedPart)
print(q)
p = "%[(=*)%[(.-)%]%1%]"
s = "a = [=[[[ something ]] ]==] ]=]; print(a)"
print(string.match(s, p))

print(string.gsub("hello Lua!","%a", "%o-%0"))

function expand (s)
  return (string.gsub(s, "$(%w+)", _G))
end

name = "Lua"; status = "great"
print(expand("$name is $status, isn't it?"))

function unescape (s)
  s = string.gsub(s, "+", " ")
  s = string.gsub(s,"%%(%x%x)", function (h)
        return string.char(tonumber(h, 16))
      end)
  return s
end

print(unescape("a%2Bb+%3D+c"))

local a = {}
a[#a + 1] = "Nadaan"
a[#a + 1] = "acao"
a[#a + 1] = "Abcde"
local l = table.concat(a, ";")
print(l)

-- Exercise 21.1
function split(str, delim)
  local result = {}
  for w in string.gmatch(str,"%S+") do
    table.insert(result, w)
  end
  return result
end

local t = split("a whole new world", " ")
print(t)