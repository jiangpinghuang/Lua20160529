a = {}
for i = -5, 500000 do
  a[i] = 0
end
print(#a)

squares = {1, 4, 9, 16, 25, 36}
print(#squares)

M = 20
N = 30
mt = {}
for i = 1, N do
  mt[i] = {}
  for j = 1, M do
    mt[i][j] = 0
  end
end
print(#mt[15])

nt = {}
for i = 1, M do
  for j = 1, N do
    nt[(i - 1) * N + j] = (i - 1) * N + j
  end
end
print(#nt)


--List = {}
--function List.new ()
--  return {first = 0, last = -1}
--end
--
--function List.pushfirst (list, value)
--  local first = list.first - 1
--  list.first = first
--  list[first] = value
--end
--
--function List.pushlast (list, value)
--  local last = list.last + 1
--  list.last = last
--  list[last] = value
--end
--
--function List.popfirst (list)
--  local first = list.first
--  if first > list.last then error("list is empty") end
--  local value = list[first]
--  list[first] = nil
--  list.first = first + 1
--  return value
--end
--
--function List.poplast (list)
--  local last = list.last
--  if list.first > last then error("list is empty") end
--  local value = list[last]
--  list[last] = nil
--  list.last = last - 1
--  return value
--end
--
--local buff = ""
--for line in io.lines() do
--  buff = buff .. line .. "\n"
--end
--
--local t = {}
--for line in io.lines() do
--  t[#t + 1] = line .. "\n"
--end
--local s = table.concat(t)
--
--local t = {}
--for line in io.lines() do
--  t[#t + 1] = line
--end
--s = table.concat(t, "\n") .. "\n"
--
--t[#t + 1] = ""
--s = table.concat(t, "\n")

local function name2node (graph, name)
  local node = graph[name]
  if not node then
    node = {name = name, adj = {}}
    graph[name] = node
  end
  return node
end

function readgraph ()
  local graph = {}
  for line in io.lines() do
    local namefrom, nameto = string.match(line, "(%S+)%s+(%S+)")
    local from = name2node(graph, namefrom)
    local to = name2node(graph, nameto)
    from.adj[to] = true
  end
  return graph
end

function findpath(curr, to, path, visited)
  path = path or {}
  visited = visited or {}
  if visited[curr] then
    return nil
  end
  visited[curr] = true
  path[#path + 1] = curr
  if curr == to then
    return path
  end
  for node in pairs(curr.adj) do
    local p = findpath(node, to, path, visited)
    if p then return p end
  end
  path[#path] = nil
end

function printpath (path)
  for i = 1, #path do
    print(path[i].name)
  end
end

g = readgraph()
a = name2node(g, "a")
b = name2node(g, "b")
p = findpath(a, b)
if p then printpath(p) end
