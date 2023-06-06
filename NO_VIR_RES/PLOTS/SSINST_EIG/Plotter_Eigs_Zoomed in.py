import pandas as pd
import numpy as np
from matplotlib import pyplot as plt
from matplotlib.lines import Line2D
from mpl_toolkits.axes_grid1.inset_locator import zoomed_inset_axes
from mpl_toolkits.axes_grid1.inset_locator import mark_inset

plt.rcParams['font.family'] = 'serif'
plt.rcParams['font.serif'] = ['Times New Roman'] + plt.rcParams['font.serif']
plt.rcParams['font.size'] = 18
plt.rcParams.update({'figure.autolayout': True})

fig = plt.figure(figsize=(700/96,500/96), dpi=96)
ax = plt.axes()


cols_eigs_py = ["0.2x","0.2y","0.22x","0.22y","0.24x","0.24y","0.26x","0.26y","0.28x","0.28y","0.3x","0.3y","0.32x","0.32y","0.34x","0.34y","0.36x","0.36y"]

plot_lines = []


# only read specific columns from an excel file
df_py = pd.read_csv('eigsp.csv', usecols=cols_eigs_py)
marker_style = dict(color='tab:blue', linestyle=':', marker='o',
                    markersize=15, markerfacecoloralt='tab:red')

ax.plot(df_py["0.2x"], df_py["0.2y"],'ro',fillstyle="none",label = "Kq = 0.2")
ax.plot(df_py["0.22x"], df_py["0.22y"],'rx',fillstyle="none",label = "Kq = 0.22")
ax.plot(df_py["0.24x"], df_py["0.24y"],'r+',fillstyle="none",label = "Kq = 0.24")
ax.plot(df_py["0.26x"], df_py["0.26y"],'r*',fillstyle="none",label = "Kq = 0.26")
ax.plot(df_py["0.28x"], df_py["0.28y"],'rs',fillstyle="none",label = "Kq = 0.28")
ax.plot(df_py["0.3x"], df_py["0.3y"],'rd',fillstyle="none",label = "Kq = 0.3")
ax.plot(df_py["0.32x"], df_py["0.32y"],'rv',fillstyle="none",label = "Kq = 0.32")
ax.plot(df_py["0.34x"], df_py["0.34y"],'r^',fillstyle="none",label = "Kq = 0.34")
ax.plot(df_py["0.36x"], df_py["0.36y"],'rp',fillstyle="none",label = "Kq = 0.36")


line1 = Line2D([0,1],[0,1],linestyle='solid', color='r')
line2 = Line2D([0,1],[0,1],linestyle='dashed', color='g')



# plot_lines.append([line1, line2, line3])
# legend1 = plt.legend(plot_lines[0], ["DP\nmodel", "Constant\nAdmittance Matrix\nmodel","PSCAD/EMTDC"], loc=4,prop={'size': 12},frameon=False,ncol=3)
# #
ax.set_xlabel("Real ($\sigma$)")
ax.set_ylabel("Imag  ($j\omega$)")
#
x1 = -50
x2 = 10
#
# # select y-range for zoomed region
y1 = -500
y2 = 500

# # Make the zoom-in plot:
# axins = ax.inset_axes([0.12, 0.65, 0.8, 0.3])
#
# axins.plot(df_py["0.2x"], df_py["0.2y"],'ro',label = "Kq = 0.2")
# axins.plot(df_py["0.22x"], df_py["0.22y"],'gx',label = "Kq = 0.22")
# axins.plot(df_py["0.24x"], df_py["0.24y"],'r+',label = "Kq = 0.24")
# axins.plot(df_py["0.26x"], df_py["0.26y"],'g*',label = "Kq = 0.26")
# axins.plot(df_py["0.28x"], df_py["0.28y"],'rs',label = "Kq = 0.28")
# axins.plot(df_py["0.3x"], df_py["0.3y"],'gd',label = "Kq = 0.3")
# axins.plot(df_py["0.32x"], df_py["0.32y"],'rv',label = "$Kq = 0.32")
# axins.plot(df_py["0.34x"], df_py["0.34y"],'g^',label = "Kq = 0.34")
# axins.plot(df_py["0.36x"], df_py["0.36y"],'gp',label = "Kq = 0.36")
#
#
# axins.set_xlim(x1, x2)
# axins.set_ylim(y1, y2)



# ax.indicate_inset_zoom(axins)

# axins.grid(linestyle='--', linewidth=0.5,)

plt.xticks(visible=True)
plt.yticks(visible=True)
# mark_inset(ax, axins, loc1=1, loc2=4, fc="none", ec="0.5")

plt.draw()
plt.grid(linestyle='--', linewidth=0.5)
plt.ylim(-500,500)
plt.xlim(-50,10)
plt.legend(loc=(0.02,0.25),prop={'size': 12},frameon=True,ncol=3)
plt.show()