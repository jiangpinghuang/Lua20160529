--[[
Convolutional Neural Networks for modeling image using GPU.
--]]

require 'nn'
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

criterion = nn.ClassNLLCriterion()
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