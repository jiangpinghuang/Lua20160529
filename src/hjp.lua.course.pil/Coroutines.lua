co = coroutine.create(function () print("hi") end)
print(co)
print(coroutine.status(co))
coroutine.resume(co)
print(coroutine.status(co))

co = coroutine.create(function ()
        for i = 1, 10 do
          print("co", i)
          coroutine.yield()
        end
     end)
coroutine.resume(co)
print(coroutine.status(co))
coroutine.resume(co)
print(coroutine.status(co))
coroutine.resume(co)
print(coroutine.status(co))

co = coroutine.create(function (a, b, c)
        print("co", a, b, c + 2)
     end)
coroutine.resume(co, 1, 2, 3)

co = coroutine.create(function (a, b)
        coroutine.yield(a + b, a - b)
     end)
print(coroutine.resume(co, 20, 10))

co = coroutine.create(function (x)
        print("co1", x)
        print("co2", coroutine.yield())
     end)
coroutine.resume(co, "hi")
coroutine.resume(co, 4, 5)

co = coroutine.create(function ()
        return 6, 7
     end)
print(coroutine.resume(co))

function receive (prod)
  local status, value = coroutine.resume(prod)
  return value
end

function send (x)
  coroutine.yield(x)
end

function producer ()
  return coroutine.create(function () 
    while true do
      local x = io.read()
      send(x)
    end
  end)
end

function filter (prod)
  return coroutine.create(function ()
    for line = 1, math.huge do
      local x = receive(prod)
      x = string.format("%5d %s", line, x)
      send(x)
    end
  end)
end

function consumer (prod)
  while true do
    local x = receive(prod)
    io.write(x, "\n")
  end
end

function permgen(a, n)
  n = n or #a
  if n <= 1 then
    printResult(a)
  else
    for i = 1, n do
      a[n], a [i] = a[i], a[n]
      permgen(a, n - 1)
      a[n], a[i] = a[i], a[n]
    end
  end
end

function printResult (a)
  for i = 1, #a do
    io.write(a[i], " ")
  end
  io.write("\n")
end

permgen ({1, 2, 3, 4})

local socket = require "socket"
function download (host, file)
  local c = assert(socket.connnect(host, 80))
  local count = 0
  c:send("GET " .. file .. " HTTP/1.0\r\n\r\n")
  while true do
    local s, status = receive(c)
    count = count + #s
    if status == "closed" then break end
  end
  c:close()
  print(file, count)
end

threads = {}

function get (host, file)
  local co = coroutine.create(function ()
    download(host, file)
  end) 
  table.insert(threads, co)
end

function dispatch ()
  local i = 1
  while true do
    if threads[i] == nil then
      if threads[1] == nil then break end
      i = 1
    end
    local status, res = coroutine.resume(threads[i])
    if not res then
      table.remove(threads, i)
    else
      i = i + 1
    end
  end
end

function dispatch ()
  local i = 1
  local timeout = {}
  while true do
    if threads[i] == nil then
      if threads[1] == nil then break end
      i = 1
      timeout = {}
    end
    local status, res = coroutine.resume(threads[i])
    if not res then
      table.remove(threads, i)
    else
      i = i + 1
      timeout[#timeout + 1] = res
      if #timeout == #threads then
        socket.select(timeout)
      end
    end
  end
end

host = "www.w3.org"
get(host, "/TR/html401/html40.txt")
dispatch()
