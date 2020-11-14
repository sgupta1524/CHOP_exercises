import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

my_dpi = 100
barWidth = 0.4
Gender = ['Male', 'Female']

df = pd.read_csv("/home/sonali/CHOP_exercises/Section2/Q2/total_patients_demographics/stacked2.csv")
M = df.iloc[:,1].tolist()
F = df.iloc[:,2].tolist()
M = [int(i) for i in M]
F = [int(i) for i in F]
names = df.iloc[:,0].tolist()
r = np.arange(len(names))

bars = np.add(M, F).tolist()

plt.figure(figsize=(1000/my_dpi, 1000/my_dpi), dpi=my_dpi)
plt.bar(r, M, color='#7f6d5f', edgecolor='white', width=barWidth)
plt.bar(r, F, bottom=M, color='#557f2d', edgecolor='white', width=barWidth)

plt.xticks(r, names, size = 10,rotation=30)
plt.legend(Gender, loc=2)
plt.xlabel('Age Groups', fontsize=10)
plt.ylabel('# of patients', fontsize=10)
plt.title('Total Number of patients across age groups & gender (irrespective of diagnosis/ encounter)',fontsize=10)
plt.savefig('/home/sonali/CHOP_exercises/Section2/Q2/total_patients_demographics/stacked_bar_total_patients.pdf', dpi=my_dpi)

