import matplotlib.pyplot as plt
import matplotlib

matplotlib.rcParams['pdf.fonttype'] = 42
matplotlib.rcParams.update({'font.size': 5})
plt.rc('font', size=10)
# matplotlib.rcParams['ps.fonttype'] = 3

# Pie chart, where the slices will be ordered and plotted counter-clockwise:
labels = 'RESPIRATORY TRACT INFECTION, UPPER'.title(), 'MALARIA'.title(), 'PERIPHERAL NEUROPATHY'.title(), 'MYALGIA'.title(), 'PNEUMONIA'.title(), 'DERMATITIS'.title(), 'GASTROENTERITIS'.title(), 'RESPIRATORY TRACT INFECTION, NOS'.title(), 'OTHERS'.title()

sizes = [710, 509, 225, 153, 141, 136, 132, 119, 2323]
print(sum(sizes))
colours = ['mediumseagreen', 'burlywood', 'cornflowerblue', 'indianred', "darkkhaki", "peru", "skyblue", "darkcyan", 'coral']

# colours = colours[::-1]
fig = plt.figure(figsize=[5, 5])
ax = fig.add_subplot(111)
ax.pie(sizes, labels=labels, autopct='%1.1f%%', colors=colours)
# Equal aspect ratio ensures that pie is drawn as a circle.
plt.title("No. of patients in diagnosis categories    N=4,448")



#plt.show()
plt.savefig("/home/sonali/CHOP_exercises/Section2/Q2/piechart.pdf", transparent = True, dpi=400)