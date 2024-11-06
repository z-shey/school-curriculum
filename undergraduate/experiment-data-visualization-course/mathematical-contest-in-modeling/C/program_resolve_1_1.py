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

A_j = [80, 55, 35, 72, 68, 55, 60, 46, 40, 28, 25, 86, 55, 44, 50, 25, 60, 45, 35, 20, 15, 13, 15, 18, 27, 20, 15, 15,
       10, 10, 14, 14, 6, 6, 10, 10, 12, 12, 22, 20, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6,
       0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.3, 0.3, 0.6, 0.6, 0.6, 0.3, 0.3, 0.3, 0.3,
       0.3, 0.3, 0.3, 0.3, 0.6, 0.3, 0.3, 0.6, 0.3, 0.3]
plot_types = ["平旱地", "梯田", "山坡地", "水浇地", "普通大棚", "智慧大棚"]  # TODO
T_5 = "普通大棚"  # TODO
T_6 = "智慧大棚"  # TODO

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

# 计算预期销售量 D：使用种植面积/亩    乘以      对应作物的亩产量（q）
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
def objective_function1(x):
    Z1 = 0
    for t in range(num_years):
        for k in range(num_seasons):
            for i in range(num_crops):
                y_ikt = np.sum(x[i, :, k, t]) * q[i]
                Z1 += p[i] * min(y_ikt, D[i]) - c[i] * np.sum(x[i, :, k, t])
    return Z1




# 施加约束的函数
def apply_constraints(particles):
    for n in range(num_particles):
        for j in range(num_plots):
            # 地块种植面积不超过总面积
            for k in range(num_seasons):
                for t in range(num_years):
                    if np.sum(particles[n][:, j, k, t]) > A_j[j]:
                        particles[n][:, j, k, t] *= A_j[j] / np.sum(particles[n][:, j, k, t])



            # # 地块类型与作物类型的适应性约束
            for i in range(num_crops):
                for k in range(num_seasons): # k=0 1 k=1 2
                    for t in range(num_years):
                        if plot_types[j] in [T_5] and    k == 2     and i in [35, 36, 37]:  # 普通大棚限制
                            particles[n][i, j, k, t] = 0
                        if plot_types[j] in [T_6] and i in [35, 36, 37]:  # 智慧大棚限制
                            particles[n][i, j, k, t] = 0


            # 禁止重茬种植约束
            for i in range(num_crops):
                for k in range(num_seasons):
                    for t in range(num_years - 1):
                        if particles[n][i, j, k, t] > 0:
                            particles[n][i, j, k, t + 1] = 0
            # 豆类作物种植频率限制
            for t in range(num_years - 2):
                if np.sum(particles[n][i, j, :, t:t + 3]) < A_j[j]:
                    particles[n][i, j, :, t:t + 3] = A_j[j] / 3
            # # 作物种植集中度约束
            # for i in range(num_crops):
            #     for k in range(num_seasons):
            #         for t in range(num_years):
            #             if particles[n][i, j, k, t] < 0.1 and particles[n][i, j, k, t] > 0:
            #                 particles[n][i, j, k, t] = 0.1
            # # 种植面积为0.1的倍数的约束
            # for i in range(num_crops):
            #     for k in range(num_seasons):
            #         for t in range(num_years):
            #             particles[n][i, j, k, t] = ensure_tenth_multiples(particles[n][i, j, k, t])



# 粒子群算法主函数
def pso():
    global g_best, p_best, best_fitness_over_time
    for iter in range(max_iter):
        for n in range(num_particles):
            fitness = objective_function1(particles[n])
            p_best_fitness = objective_function1(p_best[n])
            g_best_fitness = objective_function1(g_best)
            # 更新个体最佳位置
            if fitness > p_best_fitness:  # 改为最大化
                p_best[n] = particles[n]
            # 更新全局最佳位置
            if fitness > g_best_fitness:  # 改为最大化
                g_best = particles[n]
            # 更新粒子的速度和位置
            velocities[n] = w * velocities[n] + c1 * np.random.rand() * (p_best[n] - particles[n]) + c2 * np.random.rand() * (g_best - particles[n])
            particles[n] += velocities[n]

            # 应用约束
            for n in range(num_particles):
                for j in range(num_plots):
                    # 地块种植面积不超过总面积
                    for k in range(num_seasons):
                        for t in range(num_years):
                            if np.sum(particles[n][:, j, k, t]) > A_j[j]:
                                particles[n][:, j, k, t] *= A_j[j] / np.sum(particles[n][:, j, k, t])
                    # 禁止重茬种植约束
                    for i in range(num_crops):
                        for k in range(num_seasons):
                            for t in range(num_years - 1):
                                if particles[n][i, j, k, t] > 0:
                                    particles[n][i, j, k, t + 1] = 0
                    # 豆类作物种植频率限制
                    for t in range(num_years - 2):
                        if np.sum(particles[n][i, j, :, t:t + 3]) < A_j[j]:
                            particles[n][i, j, :, t:t + 3] = A_j[j] / 3
                    # 作物种植集中度约束
                    for i in range(num_crops):
                        for k in range(num_seasons):
                            for t in range(num_years):
                                if particles[n][i, j, k, t] < 0.1 and particles[n][i, j, k, t] > 0:
                                    particles[n][i, j, k, t] = 0.1
                    # 种植面积为0.1的倍数的约束
                    for i in range(num_crops):
                        for k in range(num_seasons):
                            for t in range(num_years):
                                particles[n][i, j, k, t] = ensure_tenth_multiples(particles[n][i, j, k, t])

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
best_value = objective_function1(best_solution)  # 计算最优解对应的目标函数值

# 创建文件夹，命名为当前日期+时间
folder_name = datetime.now().strftime('%Y-%m-%d_%H-%M-%S')
os.makedirs(folder_name, exist_ok=True)

# # 输出x解空间矩阵到多个文件
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
