-- The Eight-Queen Puzzle
local N = 8

local function isplaceok (a, n, c)
  for i = 1, n - 1 do
    if (a[i] == c) or (a[i] - i == c - n) or (a[i] + i == c + n) then return false end
  end
  return true
end

local function printsolution (a)
  for i = 1, N do
    for j = 1, N do
      io.write(a[i] == j and "X" or "-", " ")
    end
    io.write("\n")
  end
  io.write("\n")
end

local function addqueen (a, n)
  if n > N then
    printsolution(a)
  else
    for c = 1, N do
      if isplaceok(a, n, c) then
        a[n] = c
        addqueen(a, n + 1)
      end
    end
  end
end

addqueen({}, 1)


-- Word-frequency program
--local function allwords ()
--  local auxwords = function ()
--    for line in io.lines() do
--      for word in string.gmatch(line, "%w+") do
--        coroutine.yield(word)
--      end
--    end
--  end
--  return coroutine.wrap(auxwords)
--end
--
--local counter = {}
--for w in allwords() do
--  counter[w] = (counter[w] or 0) + 1
--end
--
--local words = {}
--for w in pairs(counter) do
--  words[#words + 1] = w
--end
--
--table.sort(words, function(w1, w2)
--  return counter[w1] > counter[w2] or counter[w1] == counter[w2] and w1 < w2 end)
--  
--for i = 1, (tonumber(arg[1]) or 10) do
--  print(words[i], counter[words[i]])
--end


--Auxiliary definitions for the Markov program
function  allwords ()
  local line = io.read()
  local pos = 1
  return function ()
    while line do
      local s, e = string.find(line, "w+", pos)
      if s then 
        pos = e + 1
        return string.sub(line,s,e)
      else
        line = io.read()
        pos = 1
      end
    end
    return nil
  end
end

function prefix (w1, w2)
  return w1 .. " " .. w2
end

local statetab = {}

function insert (index, value)
  local list = statetab[index]
  if list == nil then
    statetab[index] = {value}
  else
    list[#list + 1] = value
  end
end

local N = 2
local MAXGEN = 10000
local NOWORD = "\n"

local w1, w2 = NOWORD, NOWORD
for w in allwords() do
  insert(prefix(w1, w2), w)
  w1 = w2; w2 = w;
end
insert(prefix(w1, w2), NOWORD)

w1 = NOWORD; w2 = NOWORD
for i = 1, MAXGEN do
  local list = statetab[prefix(w1, w2)]
  local r = math.random(#list)
  local nextword = list[r]
  if nextword == NOWORD then return end
  io.write(nextword, " ")
  w1 = w2; w2 = nextword
end