require 'nn'

--input = torch.randn(5,10)
--target = torch.IntTensor{20,24,27,10,12}
--gradOutput = torch.randn(5)
--root_id = 29
--input_size = 10
--hierarchy = {
--    [29] = torch.IntTensor{30,1,2}, 
--    [1]=torch.IntTensor{3,4,5}, 
--    [2]=torch.IntTensor{6,7,8}, 
--    [3]=torch.IntTensor{9,10,11},
--    [4]=torch.IntTensor{12,13,14}, 
--    [5]=torch.IntTensor{15,16,17},
--    [6]=torch.IntTensor{18,19,20}, 
--    [7]=torch.IntTensor{21,22,23},
--    [8]=torch.IntTensor{24,25,26,27,28}
--}
--smt = nn.SoftMaxTree(input_size, hierarchy, root_id)
--smt:forward{input, target}
--smt:backward({input, target}, gradOutput)

mlp = nn.Sequential()
linear = nn.Linear(50,100)
push = nn.PushTable(2)
pull = push:pull(2)
mlp:add(push)
mlp:add(nn.SelectTable(1))
mlp:add(linear)
mlp:add(pull)
mlp:add(smt) --smt is a SoftMaxTree instance
mlp:forward{input, target} -- input and target are defined above

mlp:backward({input, target}, gradOutput) -- so is gradOutput