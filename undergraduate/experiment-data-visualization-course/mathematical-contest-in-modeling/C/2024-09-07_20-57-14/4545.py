import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error

# 创建数据
data = {
    '亩产量': [400, 500, 400, 350, 415, 800, 1000, 400, 630, 525, 110, 3000],
    '种植成本': [400, 400, 350, 350, 350, 450, 500, 360, 400, 360, 350, 1000],
    '销售单价':
        [
        (np.mean([float(x.split('-')[0]), float(x.split('-')[1])]) for x in ['2.50-4.00', '6.50-8.50', '7.50-9.00', '6.00-8.00', '6.00-7.50', '3.00-4.00', '2.50-3.50', '6.00-7.50', '5.50-6.50', '6.50-8.50', '30.00-50.00', '1.00-2.00'])]
}


# 转换销售单价生成器表达式为列表
data['销售单价'] = [x for x in data['销售单价']]

# 转换为DataFrame
df = pd.DataFrame(data)

# 定义自变量和因变量
X = df[['种植成本', '销售单价']]
y = df['亩产量']

# 划分训练集和测试集
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# 创建线性回归模型
model = LinearRegression()

# 训练模型
model.fit(X_train, y_train)

# 预测测试集
y_pred = model.predict(X_test)

# 计算均方误差
mse = mean_squared_error(y_test, y_pred)
print("均方误差:", mse)

# 打印模型参数
print("模型系数:", model.coef_)
print("模型截距:", model.intercept_)