import pandas as pd
import numpy as np
from pulp import LpMaximize, LpProblem, LpVariable, lpSum

# 1. 读取 Excel 文件中的数据
df_land = pd.read_excel('./附件1.xlsx')  # 附件 1，地块信息
df_crops = pd.read_excel('./附件2.xlsx')  # 附件 2，2023 年农作物种植数据
df_crops_2 = pd.read_excel('./Out_55.xlsx')
df_crops_3 = pd.read_excel('./result.xlsx', sheet_name="总产量")

# 2. 清理列名，防止因列名中有空格等字符引起错误
df_land.columns = df_land.columns.str.strip()  # 清除列名中的多余空格
df_crops.columns = df_crops.columns.str.strip()

# 3. 提取必要的数据
land_area = df_land['地块面积/亩'].values  # 各地块的面积
crop_names = df_crops['作物名称'].values  # 作物名称


new_year = 2025
# 以下使用假设数据，你需要根据实际数据进行调整
# crop_prices = np.random.uniform(10, 20, len(crop_names))  # 作物的价格，假设为随机值
crop_prices = list(df_crops_2["平均销售单价"])
# crop_costs = np.random.uniform(100, 200, len(crop_names))  # 作物种植成本
crop_costs = list(df_crops_2["种植成本/(元/亩)"])  # 作物种植成本

crop_yield = np.random.uniform(300, 500, len(crop_names))  # 作物的亩产量
# crop_yield = list(df_crops_3["2025年1季产量（斤）"])   # 作物的亩产量,

crop_sales = np.random.uniform(1000, 5000, len(crop_names))  # 作物的预期销售量
# crop_sales = list(df_crops_3["2024年1季产量（斤）"])  # 作物的预期销售量, 总产量




n_land = len(land_area)  # 地块数量
n_crops = len(crop_names)  # 作物数量
years = range(2024, new_year)  # 2024-2030 年

# 4. 创建优化问题
prob = LpProblem("Optimal_Crop_Plan", LpMaximize)

# 5. 定义决策变量
# x[i, j, t] 表示在第 t 年地块 i 上种植作物 j 的面积
x = LpVariable.dicts("x", ((i, j, t) for i in range(n_land) for j in range(n_crops) for t in years), lowBound=0,
                     cat='Continuous')

# 定义辅助变量 P[i, j, t] 表示实际销售的作物数量，必须小于或等于预期销售量和实际产量
P = LpVariable.dicts("P", ((i, j, t) for i in range(n_land) for j in range(n_crops) for t in years), lowBound=0,
                     cat='Continuous')

# 定义二元变量 z[i, j, t]，表示第 t 年在地块 i 上是否种植作物 j
z = LpVariable.dicts("z", ((i, j, t) for i in range(n_land) for j in range(n_crops) for t in years), 0, 1, cat='Binary')

# 6. 目标函数：最大化收益
objective = lpSum(
    P[i, j, t] * crop_prices[j] - x[i, j, t] * crop_costs[j]
    for i in range(n_land) for j in range(n_crops) for t in years
)

prob += objective  # 将目标函数加入问题

# 7. 添加约束条件
# (1) 地块面积限制
for i in range(n_land):
    for t in years:
        prob += lpSum(x[i, j, t] for j in range(n_crops)) <= land_area[i]  # 每块地的总种植面积不能超过该地块的面积

# (2) P[i, j, t] 受两方面限制：
# a. 不能超过预期销售量
# b. 不能超过实际产量（x[i, j, t] * crop_yield[j]）
for i in range(n_land):
    for j in range(n_crops):
        for t in years:
            prob += P[i, j, t] <= crop_sales[j]  # 不超过预期销售量
        prob += P[i, j, t] <= x[i, j, t] * crop_yield[j]  # 不超过实际产量

# (3) 不重茬约束：同一地块不能连续两年种植相同作物
# 通过二元变量 z[i, j, t] 实现不重茬
for i in range(n_land):
    for j in range(n_crops):
        for t in range(2025, new_year):  # 从 2025 年开始，检查前一年的种植情况
            prob += z[i, j, t] + z[i, j, t - 1] <= 1  # 如果 t 年种植作物 j，则 t-1 年不能种植同一作物

# (4) 确保 z[i, j, t] 与 x[i, j, t] 一致
for i in range(n_land):
    for j in range(n_crops):
        for t in years:
            # 如果种植作物 j 的面积大于 0，则 z[i, j, t] 为 1，否则为 0
            prob += x[i, j, t] <= z[i, j, t] * land_area[i]
            prob += x[i, j, t] >= z[i, j, t] * 0.01  # 小于 0.01 认为没种植

# (5) 豆类作物三年内必须种植一次
for i in range(n_land):
    for t in range(2024, new_year, 3):  # 每三年检查一次
        prob += lpSum(z[i, j, t + k] for j in range(n_crops) if '豆类' in crop_names[j] for k in range(3)) >= 1

# 8. 求解模型
prob.solve()

# 9. 输出结果
for i in range(n_land):
    for j in range(n_crops):
        for t in years:
            #  表示在第 t 年地块 i 上种植作物 j 的面积
            if x[i, j, t].varValue > 0:
                print(f"地块{i + 1}, 作物: {crop_names[j]}, 年份: {t}, 面积: {x[i, j, t].varValue}亩")
