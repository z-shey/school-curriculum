import numpy as np
import pandas as pd
from pulp import *

data1 = pd.read_excel('附件1.xlsx')
data2 = pd.read_excel('附件2.xlsx')

data1.columns = data1.columns.str.strip()
data2.columns = data2.columns.str.strip()

plots = data1['地块名称'].unique()
crops = data2['作物名称'].unique()

yield_per_mu = data2.set_index('作物名称')['种植面积/亩'].to_dict()
planting_cost = {}
expected_sales = {}
price_per_unit = {}
land_area = data1.set_index('地块名称')['地块面积/亩'].to_dict()
def simulate_uncertainty(base_value, percentage_range):
    return base_value * np.random.uniform(1 - percentage_range, 1 + percentage_range)
def optimize_planting(yield_per_mu, planting_cost, expected_sales, price_per_unit):
    model = LpProblem("Crop_Planning", LpMaximize)
    plant_area = LpVariable.dicts("Plant_Area", ((year, plot, crop) for year in range(2024, 2031) for plot in plots for crop in crops), lowBound=0, cat='Continuous')
    sales_amount = LpVariable.dicts("Sales_Amount", ((year, plot, crop) for year in range(2024, 2031) for plot in plots for crop in crops), lowBound=0, cat='Continuous')
    model += lpSum([ (sales_amount[(year, plot, crop)] * simulate_uncertainty(price_per_unit.get(crop, 0), 0.05) - plant_area[ (year, plot, crop)] * simulate_uncertainty(planting_cost.get(crop, 0), 0.05)) for year in range(2024, 2031) for plot in plots for crop in crops])
    for year in range(2024, 2031):
        for plot in plots:
            model += lpSum([plant_area[(year, plot, crop)] for crop in crops]) <= land_area[plot]
    for year in range(2025, 2031):
        for plot in plots:
            for crop in crops:
                model += plant_area[(year, plot, crop)] + plant_area[(year - 1, plot, crop)] <= 1

    bean_crops = ['大豆', '绿豆']  # eg
    for plot in plots:
        for t in range(2024, 2029, 3):

         model += lpSum([plant_area[(year, plot, crop)] for year in range(t, t + 3) for crop in bean_crops if crop in crops]) >= 1

    for year in range(2024, 2031):
        for plot in plots:
            for crop in crops:

                model += sales_amount[(year, plot, crop)] <=  plant_area[(year, plot, crop)] * simulate_uncertainty( yield_per_mu.get(crop, 0), 0.1)

                model += sales_amount[(year, plot, crop)] <= expected_sales.get(crop, 0)

    model.solve()
    if LpStatus[model.status] != 'Optimal':
        print(f'Error: Model did not find an optimal solution. Status:{LpStatus[model.status]}')
        return None

    for v in model.variables():
        if v.varValue is not None and v.varValue > 0:  # 确保varValue不为None
            print(f'{v.name} = {v.varValue}')

    return value(model.objective)

results = []
for simulation in range(100):  # 运行 100 次模拟
    print(f'Running simulation {simulation + 1}')
    total_profit = optimize_planting(yield_per_mu, planting_cost, expected_sales, price_per_unit)
    if total_profit is not None:
        results.append(total_profit)


if results:
    print(f'Average Profit: {np.mean(results)}')
    print(f'Profit Standard Deviation: {np.std(results)}')
else:
    print('No successful simulations found.')

#%%
