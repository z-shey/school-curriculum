import pandas as pd
import seaborn as sns
import os
from sklearn.preprocessing import MinMaxScaler

#读取附件信息
attachments1_path = '附件1.xlsx'
attachments2_path = '附件2.xlsx'

#读取附件1信息
attachments1_sheet1 = pd.read_excel(attachments1_path, sheet_name=0)
attachments1_sheet2 = pd.read_excel(attachments1_path, sheet_name=1)
#读取附件2信息
attachments2_sheet1 = pd.read_excel(attachments2_path, sheet_name=0)
attachments2_sheet2 = pd.read_excel(attachments2_path, sheet_name=1)

attachments2_sheet1=attachments2_sheet1.fillna(method='ffill')

# 合并两个数据框，按'作物编号'进行合并
merged_df = pd.merge(attachments2_sheet1, attachments2_sheet2, on='作物编号', how='inner')
# 删除重复命名的列，例如土地_x，土地_y
# 通过找出重复列并删除
# 合并数据
merged_df = pd.merge(attachments2_sheet1, attachments2_sheet2, on='作物编号', suffixes=('_x', '_y'))

# 处理重复列名，只保留'_x'后缀的列，并删除'_x'后缀
columns_to_keep = [col for col in merged_df.columns if col.endswith('_x')]
columns_to_keep = [col.replace('_x', '') for col in columns_to_keep]

# 保留'_x'后缀的列，并删除'_y'后缀的列
columns_to_drop = [col for col in merged_df.columns if col.endswith('_y')]

# 删除'_y'后缀的列
merged_df = merged_df.drop(columns=columns_to_drop)

# 重命名'_x'后缀的列
merged_df.columns = [col.replace('_x', '') for col in merged_df.columns]

# 添加销售量/斤列
if '亩产量/斤' in merged_df.columns and '销售单价/(元/斤)' in merged_df.columns:
    merged_df['销售量/斤'] = merged_df['亩产量/斤'] * merged_df['种植面积/亩']



merged_df.to_excel('merged_file_with_sales.xlsx', index=False)

sales_merged_df = merged_df.groupby('作物名称').agg({'销售量/斤': 'sum'}).reset_index()

sales_merged_df .to_excel('各农作物总销售量.xlsx', index=False)


import pandas as pd
import matplotlib.pyplot as plt
plt.rcParams['font.sans-serif'] = ['Microsoft YaHei']
plt.rcParams['axes.unicode_minus'] = False
# 读取合并后的数据
sales_merged_df = pd.read_excel('merged_file_with_sales.xlsx')

# 绘制柱状图（以作物名称为x轴，销售量/斤为y轴）
plt.figure(figsize=(12, 6))
plt.bar(sales_merged_df['作物名称'], sales_merged_df['销售量/斤'], color='skyblue')
plt.xticks(rotation=90)  # 旋转x轴标签以便于阅读
plt.title('各农作物销售量')
plt.xlabel('作物名称')
plt.ylabel('销售量/斤')
plt.tight_layout()
plt.savefig('2023年各农作物销售量.png')
plt.show()

# 绘制散点图（以亩产量/斤为x轴，销售量/斤为y轴）
plt.figure(figsize=(10, 6))
plt.scatter(sales_merged_df['亩产量/斤'], sales_merged_df['销售量/斤'], c='orange', edgecolor='k')
plt.title('亩产量与销售量的散点图')
plt.xlabel('亩产量/斤')
plt.ylabel('销售量/斤')
plt.grid(True)
plt.tight_layout()
plt.savefig('亩产量与销售量的散点图.png')
plt.show()

# 绘制折线图（以作物名称为x轴，销售量/斤为y轴，按作物名称排序）
plt.figure(figsize=(12, 6))
sales_merged_df_sorted = sales_merged_df.sort_values(by='作物名称')
plt.plot(sales_merged_df_sorted['作物名称'], sales_merged_df_sorted['销售量/斤'], marker='o', linestyle='-', color='green')
plt.xticks(rotation=90)  # 旋转x轴标签以便于阅读
plt.title('不同农作物的销售量折线图')
plt.xlabel('作物名称')
plt.ylabel('销售量/斤')
plt.grid(True)
plt.tight_layout()
plt.savefig('不同农作物的销售量折线图.png')
plt.show()

import numpy as np


def calculate_final_price(row):
    # 提取销售单价的最小值和最大值
    price_range = row['销售单价/(元/斤)'].split('-')
    min_price = float(price_range[0])
    max_price = float(price_range[1])

    # 计算销售单价的平均值
    avg_price = (min_price + max_price) / 2

    # 添加随机浮动（假设浮动范围为 ±10%）
    random_fluctuation = np.random.uniform(-0.1, 0.1) * avg_price

    # 计算最终价格
    final_price = avg_price + random_fluctuation

    return final_price


# 读取数据
df = merged_df

# 应用函数逐行计算
df['最终销售价格/(元/斤)'] = df.apply(calculate_final_price, axis=1)


df = df.groupby('作物名称').agg({'最终销售价格/(元/斤)': 'mean','销售量/斤': 'sum'}).reset_index()


df2=pd.read_excel('初始数据未进行计算单价.xlsx')


#  利用写好的滚动价格函数对作物的销售价格进行计算 从而消去区间价格
df2['加权销售价格/(元/斤)'] = df2.apply(calculate_final_price, axis=1)

# 进一步计算各作物的销量、成本、盈利情况
# 计算总销量、总成本和总盈利情况
df2['总销量'] = df2['种植面积/亩'] * df2['亩产量/斤']
df2['总成本'] = df2['种植成本/(元/亩)'] * df2['种植面积/亩']
df2['总产量'] = df2['总销量']


# 创建保存路径
def save_plot(filename):
    plt.savefig(filename, bbox_inches='tight')


# 绘制不同作物的总销量条形图
plt.figure(figsize=(12, 6))
plt.bar(df2['作物名称'], df2['总销量'], color='skyblue')
plt.xlabel('作物名称')
plt.ylabel('总销量')
plt.title('不同作物的总销量')
plt.xticks(rotation=45)
save_plot('total_sales_by_crop.png')

# 绘制不同作物的总成本条形图
plt.figure(figsize=(12, 6))
plt.bar(df2['作物名称'], df2['总成本'], color='orange')
plt.xlabel('作物名称')
plt.ylabel('总成本')
plt.title('不同作物的总成本')
plt.xticks(rotation=45)
save_plot('total_cost_by_crop.png')

# 绘制不同作物的种植面积条形图
plt.figure(figsize=(12, 6))
plt.bar(df2['作物名称'], df2['种植面积/亩'], color='lightcoral')
plt.xlabel('作物名称')
plt.ylabel('种植面积/亩')
plt.title('不同作物的种植面积')
plt.xticks(rotation=45)
save_plot('planting_area_by_crop.png')


# 计算不同作物类型的种植面积总和
crop_type_area = df2.groupby('作物类型')['种植面积/亩'].sum()

# 绘制种植面积图
plt.figure(figsize=(12, 6))
plt.bar(crop_type_area.index, crop_type_area.values, color='salmon')
plt.title('不同作物类型的种植面积')
plt.xlabel('作物类型')
plt.ylabel('种植面积/亩')
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig('crop_type_area.png')  # 保存图像
plt.show()



# 计算不同地块类型的总销量和总盈利总和
plot_type_sales = df2.groupby('地块类型')['总销量'].sum()


# 绘制地块类型的总销量图
plt.figure(figsize=(12, 6))
plt.bar(plot_type_sales.index, plot_type_sales.values, color='coral')
plt.title('不同地块类型的总销量')
plt.xlabel('地块类型')
plt.ylabel('总销量')
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig('plot_type_sales.png')  # 保存图像
plt.show()



corr = df2.select_dtypes(include=['float64', 'int64']).corr()

# 设置画布和大小
plt.figure(figsize=(14, 12))

# 绘制带有聚类的热力图
sns.clustermap(corr, annot=True, cmap='coolwarm', fmt='.2f', linewidths=0.5, linecolor='black', figsize=(14, 12))

# 设置标题
plt.title('相关系数热力图与聚类图', fontsize=16)

# 保存图像
plt.tight_layout()
plt.savefig('correlation_clustermap.png')

# 显示图像
plt.show()



# 创建画布和子图
fig, ax = plt.subplots(1, 2, figsize=(20, 10))

# 绘制热力图
sns.heatmap(corr, annot=True, cmap='coolwarm', fmt='.2f', linewidths=0.5, linecolor='black', ax=ax[0])
ax[0].set_title('相关系数热力图', fontsize=16)

# 绘制散点图
# 示例数据散点图
for column in corr.columns:
    for row in corr.index:
        if column != row:
            ax[1].scatter(df2[column], df2[row], alpha=0.5)
            ax[1].set_xlabel(column)
            ax[1].set_ylabel(row)
            ax[1].set_title('散点图', fontsize=16)

# 调整布局
plt.tight_layout()

# 保存图像
plt.savefig('correlation_heatmap_scatter.png')

# 显示图像
plt.show()


Data= pd.read_excel('逻辑化数据.xlsx')


# 应用函数逐行计算
Data['最终销售价格/(元/斤)'] = Data.apply(calculate_final_price, axis=1)



import numpy as np
df=Data
# 对作物类型进行编码，将每个唯一的作物类型转换为整数标签
df['作物类型'] = pd.factorize(df['作物类型'])[0]

# 初始化存储不同条件下行索引的列表
ls1 = []  # 条件：作物类型为平旱地且作物名称不为'水稻（2）'
ls2 = []  # 条件：作物名称为'水稻'
ls3 = []  # 条件：种植季次为'第一季'
ls4 = []  # 条件：种植季次为'第二季'
ls5 = []  # 条件：作物类型为“食用菌类”
ls6 = []  # 条件：地块类型为"普通大棚（5）"或"智慧大棚（6）"且作物类型不为“食用菌类”
ls7 = []  # 条件：找出必须为水浇地第二期种植的蔬菜

def classify_row(row):
    # 条件：作物类型为0且作物名称不为'水稻'
    if row['作物类型'] == 0 and row['作物名称'] != '水稻':
        ls1.append(row.name)
    # 条件：作物名称为'水稻'
    elif row['作物名称'] == '水稻':
        ls2.append(row.name)
    # 条件：地块类型为4或5且作物类型不为2
    elif (row['地块类型'] in [4, 5]) and row['作物类型'] != 2:
        ls6.append(row.name)
    # 条件：作物类型为2
    elif row['作物类型'] == 2:
        ls5.append(row.name)
    # 条件：种植季次为'第一季'
    elif row['种植季次'] == '第一季':
        ls3.append(row.name)
    # 条件：种植季次为'第二季'
    elif row['种植季次'] == '第二季':
        ls4.append(row.name)
    # 条件：作物编号为 "35、36、37" 中的任意一个
    if row['作物编号'] in [35, 36, 37]:
        ls7.append(row.name)

# 对每一行应用 classify_row 函数，进行条件判断
df.apply(classify_row, axis=1)

# 找出 '是否豆类' 列中值为'是'的行索引，并转换为列表
bean = df.index[df['是否豆类'] == '是'].tolist()



# 进行读取清洗好的数据表格
df1=pd.read_excel('附件1sheet1.xlsx')


def find_indices(lst, element):
    return [index for index, value in enumerate(lst) if value == element]


# 多余的作物需要花费的成本
def function(sales_min1, sales_min2, sales_min3):
    for i in sales_min.keys():
        total = 0
        index_ls = find_indices(land_types, i)

        total_product1 = sum(
            [yields[j] * areas[i] * x[i][j][o] * 0.25 for i in range(num_plots) for j in index_ls for o in range(2)])
        total_product2 = sum(
            [yields[j] * areas[i] * x[i][j][o] * 0.25 for i in range(num_plots) for j in index_ls for o in range(2, 4)])
        total_product3 = sum(
            [yields[j] * areas[i] * x[i][j][o] * 0.25 for i in range(num_plots) for j in index_ls for o in range(4, 6)])

        if total_product1 <= sales_min1[i]:
            pass
        else:
            total += (total_product - sales_min1[i]) * prices[index_ls[0]]
        if total_product2 <= sales_min2[i]:
            pass
        else:
            total += (total_product - sales_min2[i]) * prices[index_ls[0]]

        if total_product3 <= sales_min3[i]:
            pass
        else:
            total += (total_product - sales_min3[i]) * prices[index_ls[0]]
    return total

import pulp

# 进行模型的初始化
model = pulp.LpProblem("Land_Type_Optimization", pulp.LpMaximize)


num_plots = 54
num_crops = 125


land_types =  df['作物编号'].tolist()
 # 每个地块对应的地块类型
plot_type = df1['地块类型'].tolist()  # 本文中一共设定了6种类型 分别是0 1 2 3 4 5
#对应1. 平旱地、2. 梯田、3. 山坡地、4. 水浇地、5. 普通大棚、6. 智慧大棚 python中默认以0开始编号 故0是平旱地
plot_area = df1['地块面积/亩'].tolist()  # 每个地块的面积限制



# 定义变量 x[i][j][t]，表示在第 i 块地是否种植第 j 种作物，在第 t 个季节
# 变量 x 是一个三维的二进制决策变量字典，其中:
# - i 代表地块索引
# - j 代表作物索引
# - t 代表季节索引
# 这些变量用于表示每个地块是否在某个季节种植特定的作物
x = pulp.LpVariable.dicts(
    "planting_decision",                  # 变量的名字
    (range(num_plots), range(num_crops), range(6)),  # 变量的索引范围
    cat="Binary"                          # 变量的类别为二进制（0 或 1）
)
# 获取种植成本列表
cost_per_acre = df['种植成本/(元/亩)'].tolist()

# 创建一个包含重复成本列表的列表
cos = [cost_per_acre] * num_plots #种植成本



# 定义不同作物类型的增长率
growth_rates = {
    0: 0.003,  # 粮食增长率 0.3%
    1: 0.0365,  # 蔬菜增长率 3.65%
    2: 0.0719  # 菌类增长率 7.19%
}

# 创建一个空的字典以存储每种作物的最大销售量
sales_max = {}

# 遍历 df 中的每种作物编号
for crop_id, group in df.groupby('作物编号'):
    crop_type = group['作物类型'].iloc[0]  # 获取作物类型
    growth_rate = growth_rates.get(crop_type, 0)  # 根据作物类型获取增长率

    # 计算最大销售量
    current_sales = group['种植产量'].sum()
    max_sales = current_sales * (1 + growth_rate)

    # 将结果存入字典
    sales_max[crop_id] = max_sales

# 定义不同作物类型的增长率
growth_rates = {
    0: 0.003,  # 粮食增长率 0.3%
    1: 0.0365,  # 蔬菜增长率 3.65%
    2: 0.0719  # 菌类增长率 7.19%
}

# 定义随机数范围
random_range = (0, 0.03)  # 随机数范围可以根据实际情况调整

# 创建空字典以存储每种作物的最小销售量
sales_min = {}

# 遍历 df 中的每种作物编号
for crop_id, group in df.groupby('作物编号'):
    crop_type = group['作物类型'].iloc[0]  # 获取作物类型
    growth_rate = growth_rates.get(crop_type, 0)  # 根据作物类型获取增长率

    # 计算最大销售量
    current_sales = group['种植产量'].sum()
    max_sales = current_sales * (1 + growth_rate)

    # 计算最小销售量
    min_growth_rate = -growth_rate  # 增长率的负数
    random_adjustment = np.random.uniform(*random_range)  # 生成随机数
    min_sales = current_sales * (1 + min_growth_rate) + random_adjustment * current_sales

    # 将结果存入字典
    sales_min[crop_id] = min_sales
