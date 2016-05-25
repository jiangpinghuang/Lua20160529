a = torch.FloatTensor(2,3)
print(a)
print(a:fill(1))

print(a:uniform(0,1))

b=a:transpose(1,2)
print(b)

b[{1,2}]=1
print(b)
print(a)

print(a:storage())

print(unpack(a:stride():totable()))
print(unpack(b:stride():totable()))

print(a:isContiguous(), b:isContiguous())

print(b[{1,1}],b[{1,1}],b[{2,1}])

print(b:storage())

c = b:clone()
print(c:isContiguous())

d = b.new()
d:resize(b:size())
d:copy(b)
print(d:isContiguous())

batchSize, inputSize, outputSize = 4, 2, 3
input = torch.FloatTensor(batchSize, inputSize):uniform(0,1)
weight = torch.FloatTensor(outputSize, inputSize):uniform(0,1)
output = torch.FloatTensor()

require 'nn'
module = nn.Sequential()
module:add(nn.Linear(2, 1))
module:add(nn.Sigmoid())

criterion = nn.BCECriterion()

inputs = torch.Tensor(10,2):uniform(-1,1)
targets = torch.Tensor(10):random(0,1)

--require 'dpnn'
--function trainEpoch(module, criterion, inputs, targets)
--  for i = 1, inputs:size(1) do
--    local idx = math.random(1, inputs:size(1))
--    local input, target = inputs[idx], targets:narrow(1, idx, 1)
--    local output = module:forward(input)
--    local loss = criterion:forward(output, target)
--    local gradOutput = criterion:backward(output, target)
--    module:zeroGradParameters()
--    local gradInput = module:backward(input, gradOutput)
--    module:updateGradParameters(0.9)
--    module:updateParameters(0.1)
--  end
--end
--
--for i = 1, 100 do
--  trainEpoch(module, criterion, inputs, targets)
--end
--
--require 'dp'
--ds = dp.Mnist()
--
--trainInputs = ds:get('train', 'inputs', 'bchw')
--trainTargets = ds:get('train', 'targets', 'b')
--validInputs = ds:get('valid', 'inputs', 'bchw')
--validTargets = ds:get('valid', 'targets', 'b')
--
--module = nn.Sequential()
--
