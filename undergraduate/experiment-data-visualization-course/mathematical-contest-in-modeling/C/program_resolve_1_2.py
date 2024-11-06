import numpy as np
import os
import pandas as pd
from datetime import datetime

# 粒子群算法的参数
w = 0.5  # 惯性权重
c1 = 1.5  # 个体学习因子
c2 = 1.5  # 社会学习因子
num_particles = 30  # 粒子数量
max_iter = 100  # 最大迭代次数

# 问题参数（以你的符号定义）
num_years = 7  # 从2024到2030年
num_crops = 41  # 作物种类数
num_plots = 54  # TODO 地块数量
num_seasons = 2  # 季节数量

# 读取附件2.xlsx中的数据
file_path = './附件2.xlsx'

# 读取销售价格（p）、种植成本（c）、亩产量（q）等数据
data_stats = pd.read_excel(file_path, sheet_name='2023年统计的相关数据')

# 将数据转换为字符串，以防止非字符串类型导致错误
data_stats['销售单价/(元/斤)'] = data_stats['销售单价/(元/斤)'].astype(str)

# 获取作物的销售价格（p），使用区间的平均值
p = data_stats['销售单价/(元/斤)'].apply(
    lambda x: (float(x.split('-')[0]) + float(x.split('-')[1])) / 2 if '-' in x else float(x)).values

# 获取作物的种植成本（c）
c = data_stats['种植成本/(元/亩)'].values

# 获取作物的亩产量（q），将产量从‘斤’转换为‘千克’
q = (data_stats['亩产量/斤'].values / 2).astype(float)  # 1斤 = 0.5千克

# 读取2023年农作物种植情况，假设其为预期销售量（D）
data_crop_situation = pd.read_excel(file_path, sheet_name='2023年的农作物种植情况')

# 计算预期销售量 D：使用种植面积/亩 乘以 对应作物的亩产量（q）
D = (data_crop_situation['种植面积/亩'].values * q[data_crop_situation['作物编号'].values - 1])
# 输出目标函数2定义和参数读取部分

# 初始化
particles = np.random.rand(num_particles, num_crops, num_plots, num_seasons, num_years)  # 粒子的位置
velocities = np.random.rand(num_particles, num_crops, num_plots, num_seasons, num_years)  # 粒子的速度
p_best = np.copy(particles)  # 每个粒子的最佳位置
g_best = np.copy(particles[0])  # 全局最佳位置
best_fitness_over_time = []


# 确保x是0.1的倍数
def ensure_tenth_multiples(x):
    return np.round(x * 10) / 10


# 目标函数1
def objective_function2(x):
    Z2 = 0
    for t in range(num_years):
        for k in range(num_seasons):
            for i in range(num_crops):
                y_ikt = np.sum(x[i, :, k, t]) * q[i]
                Z2 += p[i] * min(y_ikt, D[i]) + (0.5 * p[i]) * min(y_ikt - D[i], 0) - c[i] * np.sum(x[i, :, k, t])
    return Z2


# 粒子群算法主函数
def pso():
    global g_best, p_best, best_fitness_over_time
    for iter in range(max_iter):
        for n in range(num_particles):
            fitness = objective_function2(particles[n])
            p_best_fitness = objective_function2(p_best[n])
            g_best_fitness = objective_function2(g_best)
            # 更新个体最佳位置
            if fitness > p_best_fitness:  # 改为最大化
                p_best[n] = particles[n]
            # 更新全局最佳位置
            if fitness > g_best_fitness:  # 改为最大化
                g_best = particles[n]
            # 更新粒子的速度和位置
            velocities[n] = w * velocities[n] + c1 * np.random.rand() * (
                    p_best[n] - particles[n]) + c2 * np.random.rand() * (g_best - particles[n])
            particles[n] += velocities[n]

            # 非负性约束：强制所有位置为非负
            particles[n] = np.maximum(particles[n], 0)
            # 强制x为0.1的倍数
            particles[n] = ensure_tenth_multiples(particles[n])
        # 记录每次迭代后的全局最佳适应度
        best_fitness_over_time.append(g_best_fitness)
        print("Iteration " + str(iter) + str(-g_best_fitness))
    return g_best


# 运行粒子群算法
best_solution = pso()
best_value = objective_function2(best_solution)  # 计算最优解对应的目标函数值

# 创建文件夹，命名为当前日期+时间
folder_name = datetime.now().strftime('%Y-%m-%d_%H-%M-%S')
os.makedirs(folder_name, exist_ok=True)

# 输出x解空间矩阵到多个文件
for t in range(num_years):
    for k in range(num_seasons):
        df = pd.DataFrame(best_solution[:, :, k, t], columns=[f"P_{j + 1}" for j in range(num_plots)],
                          index=[f"C_{i + 1}" for i in range(num_crops)])
        # file_name = f"{folder_name}/{2024 + t}_Season_{k + 1}.csv"
        file_name = f"{folder_name}/{2024 + t}_Season_{k + 1}.xlsx"

        if k == 1:
            df = df.drop(df.columns[0:26], axis=1)

        df_transposed = df.T

        # df_transposed.to_csv(file_name)
        df_transposed.to_excel(file_name, index=False, engine='openpyxl')
