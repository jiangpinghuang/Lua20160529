require 'nn'

mlp = nn.Sequential()
mlp:add(nn.Linear(3,4))
mlp:add(nn.Tanh())
mlp:add(nn.Linear(4,2))
print(mlp:forward(torch.randn(3)))

--model = nn.Sequential()
--model:add(nn.Linear(10,20))
--model:add(nn.Linear(20,20))
--model:add(nn.Linear(20,30))
--model:remove(2)
--
--print(model)

model = nn.Sequential()
model:add(nn.Linear(10,20))
model:add(nn.Linear(20,30))
model:insert(nn.Linear(20,20),2)

print(model)

mlp = nn.Parallel(2,1);
mlp:add(nn.Linear(10,3));
mlp:add(nn.Linear(10,2))
print(mlp:forward(torch.randn(10,2)))


ii=torch.linspace(-2,2)
m=nn.HardTanh()
oo=m:forward(ii)
go=torch.ones(100)
gi=m:backward(ii,go)
gnuplot.plot({'f(x)',ii,oo,'+-'},{'df/dx',ii,gi,'+-'})
gnuplot.grid(true)