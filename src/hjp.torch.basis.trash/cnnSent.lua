require 'torch'
require 'nn'
require 'nngraph'

local ModelBuilder = torch.class('ModelBuilder')
print(ModelBuilder)

local input = nn.Identity()()
print("Input:")
print(input)