import torch
import torch.nn as nn
import pandas as pd 
import random
import numpy as np 
import matplotlib.pyplot as plt
# ax + b = c 
# Generate some random linear equations
N = 10
x = torch.linspace(1, N, N)
a = torch.tensor([random.uniform(0.5, 1.5) for i in range(N)])
b = torch.tensor([random.uniform(0, 0.5) for i in range(N)])
c = a * x + b


df=pd.DataFrame({'x':x,'a':a,'b':b,'c':c})
features=['x','a','b']
labels=['c']

X = torch.tensor(df[features].values,dtype=torch.float32)
y=torch.tensor(df[labels].values,dtype=torch.float32)


class MyNeuralNetwork(nn.Module):
    def __init__(self,nfeatures):
        super(MyNeuralNetwork, self).__init__()
        self.layer1 = nn.Linear(nfeatures, 3)
        self.layer2 = nn.Linear(3, 1)

    def forward(self, x):
        x = torch.relu(self.layer1(x))
        x = self.layer2(x)
        return x

# Define the model
if 0:
    model = torch.nn.Linear(3, 1)
else:
    nfeatures=X.shape[1]
    nlabels=y.shape[1]
    model = MyNeuralNetwork(nfeatures=nfeatures) # 0.0991
# Define the loss function
loss_fn = torch.nn.MSELoss()

# Define the optimizer
optimizer = torch.optim.SGD(model.parameters(), lr=0.01)

# Train the model
num_epochs = 100000
for epoch in range(num_epochs):
    # Forward pass
    y_pred = model(X)

    # Compute loss
    loss = loss_fn(y_pred, y)

    # Backward pass
    optimizer.zero_grad()
    loss.backward()
    optimizer.step()

    # Print progress
    if (epoch+1) % 1000 == 0:
        pass
#        print(f"Epoch [{epoch+1}/{num_epochs}], Loss: {loss.item():.4f}")

# Print the learned weights
#print(f"Learned weights: {model.weight.detach().numpy()} , Learned bias: {model.bias.item():.4f}")
#print(f"Layer 1 learned weights: {model.layer1.weight.detach().numpy()} , Layer 1 learned bias: {model.layer1.bias.detach().numpy()}")
#print(f"Layer 2 learned weights: {model.layer2.weight.detach().numpy()} , Layer 2 learned bias: {model.layer2.bias.detach().numpy()}")




df2 = pd.DataFrame({'y': y.detach().numpy().flatten(), 'y_pred': y_pred.detach().numpy().flatten()})
df2['er']=df['c']-df2['y_pred']
df2['er2']=abs(df2['er']/df2['y'])*100
#
## Print the first few rows of the DataFrame
print(df2.head(len(df2)))



