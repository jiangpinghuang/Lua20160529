--[[
This is a simple neural network model(snnm) for understanding the process of neural networks in torch.
--]]
require "nn"

-- Neural Network.
-- create a simple neural network with one hidden layer.
mlp = nn.Sequential()
inputs = 2
outputs = 1
HUs = 20
mlp:add(nn.Linear(inputs, HUs))
mlp:add(nn.Tanh())
mlp:add(nn.Linear(HUs, outputs))

-- Loss Function.
-- choose the Mean Squared Error criterion.
criterion = nn.MSECriterion()

-- XOR neural network with 5000 epochs.
epochs = 5000
for i = 1, epochs do
  local input = torch.randn(2)
  print("input: ")
  print(input)
  local output = torch.Tensor(1)
  print("output: ")
  print(output)
  if input[1] * input[2] > 0 then
    output[1] = -1
  else
    output[1] = 1
  end

  criterion:forward(mlp:forward(input), output)

  mlp:zeroGradParameters()

  mlp:backward(input, criterion:backward(mlp.output, output))
  mlp:updateParameters(0.01)
end

-- test neural network.
x = torch.Tensor(2)
print('Using simple neural networks:')
x[1] = 0.5; x[2] = 0.5; print(mlp:forward(x))
x[1] = 0.5; x[2] = -0.5; print(mlp:forward(x))
x[1] = -0.5; x[2] = 0.5; print(mlp:forward(x))
x[1] = -0.5; x[2] = -0.5; print(mlp:forward(x))
x[1] = 1; x[2] = 1; print(mlp:forward(x))

