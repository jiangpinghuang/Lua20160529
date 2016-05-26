--[[
Getting started!!!
--]]
-- define a global variable and display.
a = "hello"
print(a)

-- define a table and assign value to variable and display it.
b = {}
b[1] = a
print(b)

b[2] = 30
print(b)

-- the # operator is the length operator in Lua.
for i=1, #b do
  print(b[i])
end

-- construct a 5 by 3 matrix, uninitialized.
a = torch.Tensor(5, 3)
print(a)
a = torch.rand(5, 3)
print(a)

b = torch.rand(3, 4)
print(b)

-- matrix-matrix multiplication: syntax 1.
print(a*b)
-- matrix-matrix multiplication: syntax 2.
print(torch.mm(a, b))
-- matrix-matrix multiplication: syntax 3.
c = torch.Tensor(5, 4)
-- store the result of a by b in c.
c:mm(a, b)
print(c)

-- CUDA Tensors. Tensors can be moved onto GPU using the :cuda() function.
require 'cutorch'
a = a:cuda()
b = b:cuda()
c = c:cuda()
-- done on GPU.
c:mm(a, b)
print(c)

function addTensors(a, b)
  return a+b
end

-- add two tensors, note that the columns and rows of tensor.
a = torch.ones(5, 2)
print(a)
b = torch.Tensor(5, 2):fill(4)
print(b)
print(addTensors(a, b))
c = torch.ones(2, 5)
print(c)
print(addTensors(a, c))

--[[
Neural Networks. Modules are the bricks used to build neural networks. 
Each are themselves neural networks, but can be combined with other 
networks using containers to create complex neural networks.

It is a simple feed-forward network.
It takes the input, feeds it through several layers one after the other, 
and then finally gives the output.

Such a network container is nn.Sequential which feeds the input through 
several layers.
--]]
require 'nn'

net = nn.Sequential()
-- 1 input image channel, 6 output channels, 5x5 convolution kernel.
net:add(nn.SpatialConvolution(1, 6, 5, 5))
-- non-linearity.
net:add(nn.ReLU())
-- A max-pooling operation that looks at 2x2 windows and finds the max.
net:add(nn.SpatialMaxPooling(2, 2, 2, 2))
net:add(nn.SpatialConvolution(6, 16, 5, 5))
-- non-linearity.
net:add(nn.ReLU())
net:add(nn.SpatialMaxPooling(2, 2, 2, 2))
-- reshapes from a 3D tensor of 16x5x5 into 1D tensor of 16*5*5.
net:add(nn.View(16*13*13))
-- fully connected layer (matrix multiplication between input and weights).
net:add(nn.Linear(16*13*13, 120))
-- non-linearity. 
net:add(nn.ReLU())
net:add(nn.Linear(120, 84))
-- non-linearity.
net:add(nn.ReLU())
-- 10 is the number of outputs of the network (in this case, 10 digits).
net:add(nn.Linear(84, 10))
-- converts the output to a log-probability. Useful for classification problems.
net:add(nn.LogSoftMax())
print('LeNet5\n' .. net:__tostring())

--[[
Every neural network module in torch has automatic differentiation. It has a :
forward(input) function that computes the output for a given input, flowing the 
input through the network. and it has a :backward(input, gradient) function that 
will differentiate each neuron in the network w.r.t. the gradient that is passed 
in. This is done via the chain rule.
--]]

-- Given a matrix for input and print a output following the chain rule.
for i = 1, 2 do
  input = torch.rand(1, 64, 64)
  --print(input)
  output = net:forward(input)
  print(output)
end

--zero the internal gradient buffers of the network (will come to this later)
net:zeroGradParameters()
gradInput = net:backward(input, torch.rand(10))
print(#gradInput)

--[[
Criterion: Defining a loss function.
When you want a model to learn to do something, you give it feedback on how 
well it is doing. This function that computes an objective measure of the 
model's performance is called a loss function.

A typical loss function takes in the model's output and the groundtruth and 
computes a value that quantifies the model's performance.

The model then corrects itself to have a smaller loss.

In torch, loss functions are implemented just like neural network modules, and 
have automatic differentiation.
They have two functions - forward(input, target), backward(input, target).
--]]
-- a negative log-likelihood criterion for multi-class classification.
criterion = nn.ClassNLLCriterion()
-- let's say the groundtruth was class number: 3.
criterion:forward(output, 3)
gradients = criterion:backward(output, 3)
gradInput = net:backward(input, gradients)

-- learn 3 2*2 kernels.
m = nn.SpatialConvolution(1, 3, 2, 2)
-- initially, the weights are randomly initialized.
print(m.weight)
-- The operation in a convolution layer is: output = convolution(input, weight) + bias.
print(m.bias)

--[[
A example for image classification with neural networks.
--]]
require 'paths'
trainset = torch.load('/home/hjp/Workshop/Model/corpus/cifar/torch/cifar10-train.t7')
testset = torch.load('/home/hjp/Workshop/Model/corpus/cifar/torch/cifar10-test.t7')
classes = {'airplane', 'automobile', 'bird', 'cat', 'deer', 'dog', 'frog', 'horse', 'ship', 'truck'}

print(trainset)
print(#trainset.data)
print(classes[trainset.label[100]])

setmetatable(trainset,
    {__index = function(t, i)
                  return {t.data[i], t.label[i]}
                end}
);
trainset.data = trainset.data:double()

function trainset:size()
  return self.data:size(1)          -- note that the spelling colon(:) and dot(.).
end

print(trainset:size())
print(trainset[33])
redChannel = trainset.data[{ {}, {1}, {}, {} }]
print(#redChannel)

mean = {}
stdv = {}
for i = 1, 3 do
  mean[i] = trainset.data[{ {}, {i}, {}, {} }]:mean()
  print('Channel ' .. i .. ', Mean: ' .. mean[i])
  trainset.data[{ {}, {i}, {}, {} }]:add(-mean[i])
  stdv[i] = trainset.data[{ {}, {i}, {}, {}}]:std()
  print('Channel ' .. i .. ', Standard Deviation: ' .. stdv[i])
  trainset.data[{ {}, {i}, {}, {} }]:div(stdv[i])
end

cnn = nn.Sequential()
cnn:add(nn.SpatialConvolution(3, 6, 5, 5))
cnn:add(nn.ReLU())
cnn:add(nn.SpatialMaxPooling(2, 2, 2, 2))
cnn:add(nn.SpatialConvolution(6, 16, 5, 5))
cnn:add(nn.ReLU())
cnn:add(nn.SpatialMaxPooling(2, 2, 2, 2))
cnn:add(nn.View(16*5*5))
cnn:add(nn.Linear(16*5*5, 120))
cnn:add(nn.ReLU())
cnn:add(nn.Linear(120, 84))
cnn:add(nn.ReLU())
cnn:add(nn.Linear(84, 10))
cnn:add(nn.LogSoftMax())

timer = torch.Timer()

criterion = nn.ClassNLLCriterion()

trainer = nn.StochasticGradient(cnn, criterion)
trainer.learningRate = 0.001
trainer.maxIteration = 5
trainer:train(trainset)
print(classes[testset.label[100]])

testset.data = testset.data:double()
for i = 1, 3 do
  testset.data[{ {}, {i}, {}, {}}]:add(-mean[i]) 
  testset.data[{ {}, {i}, {}, {}}]:div(stdv[i])
end

horse = testset.data[100]
print(horse:mean(), horse:std())
print(classes[testset.label[100]])
predicted = cnn:forward(testset.data[100])
print(predicted:exp())
for i = 1, predicted:size(1) do
  print(classes[i], predicted[i])
end

correct = 0
for i = 1, 10000 do
  local groundtruth = testset.label[i]
  local prediction = cnn:forward(testset.data[i])
  local confidences, indices = torch.sort(prediction, true)
  if groundtruth == indices[1] then
    correct = correct + 1
  end
end

print(correct, 100 * correct / 10000 .. ' % ')
class_performance = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
for i = 1, 10000 do
  local groundtruth = testset.label[i]
  local prediction = cnn:forward(testset.data[i])
  local confidences, indices = torch.sort(prediction, true)
  if groundtruth == indices[1] then
    class_performance[groundtruth] = class_performance[groundtruth] + 1
  end
end

for i = 1, #classes do
  print(classes[i], 100 * class_performance[i]/1000 .. ' %')
end

print('Timer elapsed for CPU: ' .. timer:time().real .. ' seconds')

timerGPU = torch.Timer()
--[[
Neural Networks on GPUs using CUDA.
--]]
require 'cunn'
cnn = cnn:cuda()
criterion = criterion:cuda()
trainset.data = trainset.data:cuda()
trainset.label = trainset.label:cuda()

trainer = nn.StochasticGradient(cnn, criterion)
trainer.learningRate = 0.001
trainer.maxIteration = 5
trainer:train(trainset)
print("train in cuda!")
print(classes[testset.label[100]])

testset.data = testset.data:cuda()
for i = 1, 3 do
  testset.data[{ {}, {i}, {}, {}}]:add(-mean[i]) 
  testset.data[{ {}, {i}, {}, {}}]:div(stdv[i])
end

horse = testset.data[100]
print(horse:mean(), horse:std())
print(classes[testset.label[100]])
predicted = cnn:forward(testset.data[100])
print(predicted:exp())
for i = 1, predicted:size(1) do
  print(classes[i], predicted[i])
end

correct = 0
for i = 1, 10000 do
  local groundtruth = testset.label[i]
  local prediction = cnn:forward(testset.data[i])
  local confidences, indices = torch.sort(prediction, true)
  if groundtruth == indices[1] then
    correct = correct + 1
  end
end

print(correct, 100 * correct / 10000 .. ' % ')
class_performance = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
for i = 1, 10000 do
  local groundtruth = testset.label[i]
  local prediction = cnn:forward(testset.data[i])
  local confidences, indices = torch.sort(prediction, true)
  if groundtruth == indices[1] then
    class_performance[groundtruth] = class_performance[groundtruth] + 1
  end
end

for i = 1, #classes do
  print(classes[i], 100 * class_performance[i]/1000 .. ' %')
end

print('Timer elapsed for GPU: ' .. timerGPU:time().real .. ' seconds')