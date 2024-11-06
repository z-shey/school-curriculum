import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import torch
import torch.nn as nn
from torch.utils.data import DataLoader, TensorDataset
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import mean_squared_error, r2_score

import matplotlib

# 指定字体路径
matplotlib.rcParams['font.family'] = 'SimHei'  # 'SimHei' 是黑体的意思
matplotlib.rcParams['font.size'] = 12
matplotlib.rcParams['axes.unicode_minus'] = False  # 正确显示负号



# 设置随机种子
torch.manual_seed(42)

import pandas as pd

data = pd.read_excel("Out_55.xlsx", usecols=['平均销售单价', '种植成本/(元/亩)', '亩产量/斤'])

# 保存为CSV文件
data.to_csv('拟合数据.csv', index=False)


# 读取数据
data = pd.read_csv('拟合数据.csv')
# 提取自变量（销售价格和种植成本）和因变量（预期销售量）
X = data[['平均销售单价', '种植成本/(元/亩)']].values
Y = data['亩产量/斤'].values
# 标准化特征
scaler_X = StandardScaler()
scaler_Y = StandardScaler()
X = scaler_X.fit_transform(X)
Y = scaler_Y.fit_transform(Y.reshape(-1, 1)).flatten()
# 拆分数据集为训练集和测试集
X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size=0.2, random_state=42)
# 转换为PyTorch张量
X_train_tensor = torch.tensor(X_train, dtype=torch.float32)
Y_train_tensor = torch.tensor(Y_train, dtype=torch.float32).view(-1, 1)
X_test_tensor = torch.tensor(X_test, dtype=torch.float32)
Y_test_tensor = torch.tensor(Y_test, dtype=torch.float32).view(-1, 1)

# 创建数据加载器
train_dataset = TensorDataset(X_train_tensor, Y_train_tensor)
train_loader = DataLoader(train_dataset, batch_size=16, shuffle=True)


# 定义神经网络模型
class MLP(nn.Module):
    def __init__(self):
        super(MLP, self).__init__()
        self.hidden1 = nn.Linear(2, 64)
        self.hidden2 = nn.Linear(64, 32)
        self.output = nn.Linear(32, 1)

    def forward(self, x):
        x = torch.relu(self.hidden1(x))
        x = torch.relu(self.hidden2(x))
        x = self.output(x)
        return x


model = MLP()
# 定义损失函数和优化器
criterion = nn.MSELoss()
optimizer = torch.optim.Adam(model.parameters(), lr=0.01)
# 训练模型
epochs = 500
for epoch in range(epochs):
    model.train()
for X_batch, Y_batch in train_loader:
    optimizer.zero_grad()
    Y_pred = model(X_batch)
    loss = criterion(Y_pred, Y_batch)
    loss.backward()
    optimizer.step()
    # 打印训练进度
    if (epoch + 1) % 50 == 0:
        print(f"Epoch [{epoch + 1}/{epochs}], Loss: {loss.item():.4f}")
# 预测和评估
model.eval()
with torch.no_grad():
    Y_test_pred = model(X_test_tensor).numpy()
# 反标准化预测值
Y_test_pred = scaler_Y.inverse_transform(Y_test_pred)
Y_test_actual = scaler_Y.inverse_transform(Y_test_tensor.numpy())
# 评估模型
mse = mean_squared_error(Y_test_actual, Y_test_pred)
r2 = r2_score(Y_test_actual, Y_test_pred)
print(f"均方误差: {mse:.2f}")
print(f"R^2值: {r2:.2f}")
# 绘制实际值与预测值的散点图
plt.figure(figsize=(10, 6))
plt.scatter(Y_test_actual, Y_test_pred, color='blue', label='预测值 vs 实际值')
plt.plot([Y_test_actual.min(), Y_test_actual.max()], [Y_test_actual.min(), Y_test_actual.max()], color='red',
         linestyle='--',
         label='理想拟合线')
plt.xlabel('实际销售量')
plt.ylabel('预测销售量')
plt.title('实际值与预测值对比图（神经网络）')
plt.legend()
plt.grid(True)
plt.show()

#%%
