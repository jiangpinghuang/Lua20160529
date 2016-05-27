require 'nn'
require 'nngraph'

h1 = nn.Linear(20, 10)()
h2 = nn.Linear(10, 1)(nn.Tanh()(nn.Linear(10, 10)(nn.Tanh()(h1))))
mlp = nn.gModule({h1}, {h2})

x = torch.rand(20)
dx = torch.rand(1)
mlp:updateOutput(x)
mlp:updateGradInput(x, dx)
mlp:accGradParameters(x, dx)

-- draw graph (the forward graph, '.fg')
graph.dot(mlp.fg, 'MLP')

--m = nn.Sequential()
--m:add(nn.SplitTable(1))
--m:add(nn.ParallelTable():add(nn.Linear(10, 20)):add(nn.Linear(10, 30)))
--input = nn.Identity()()
--print(input)
--input1, input2 = m(input):split(2)
--m3 = nn.JoinTable(1)({input1, input2})
--
--g = nn.gModule({input}, {m3})
--
--indata = torch.rand(2, 10)
--gdata = torch.rand(50)
--g:forward(indata)
--g:backward(indata, gdata)
--
--graph.dot(g.fg, 'Forward Graph')
--graph.dot(g.bg, 'Backward Graph')