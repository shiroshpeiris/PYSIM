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


cols_eigs_py = ["EIG100x","EIG100y","EIG1000x","EIG1000y","EIG10000x","EIG10000y"]

plot_lines = []


# only read specific columns from an excel file
df_py = pd.read_csv('eigs.csv', usecols=cols_eigs_py)
marker_style = dict(color='tab:blue', linestyle=':', marker='o',
                    markersize=15, markerfacecoloralt='tab:red')

ax.plot(df_py["EIG100x"], df_py["EIG100y"],'ro',fillstyle="none",label = "$R_N$=100 $\Omega$")
ax.plot(df_py["EIG1000x"], df_py["EIG1000y"],'gx',label = "$R_N$=1 k$\Omega$")
ax.plot(df_py["EIG10000x"], df_py["EIG10000y"],'b+',label = "$R_N$=10 k$\Omega$")


line1 = Line2D([0,1],[0,1],linestyle='solid', color='r')
line2 = Line2D([0,1],[0,1],linestyle='dashed', color='g')
line3 = Line2D([0,1],[0,1],linestyle='dashdot', color='b')



# plot_lines.append([line1, line2, line3])
# legend1 = plt.legend(plot_lines[0], ["DP\nmodel", "Constant\nAdmittance Matrix\nmodel","PSCAD/EMTDC"], loc=4,prop={'size': 12},frameon=False,ncol=3)
# #
ax.set_xlabel("Real ($\sigma$)")
ax.set_ylabel("Imag  ($j\omega$)")
#
x1 = -2800
x2 = 100
#
# # select y-range for zoomed region
y1 = -7850
y2 = 7850

# # Make the zoom-in plot:
axins = ax.inset_axes([0.4, 0.65, 0.4, 0.3])

axins.plot(df_py["EIG100x"], df_py["EIG100y"],'ro',fillstyle="none",label = "100 $\Omega$")
axins.plot(df_py["EIG1000x"], df_py["EIG1000y"],'gx',label = "1000 Ohm")
axins.plot(df_py["EIG10000x"], df_py["EIG10000y"],'b+',label = "10000 Ohm")

axins.set_xlim(x1, x2)
axins.set_ylim(y1, y2)



# ax.indicate_inset_zoom(axins)

axins.grid(linestyle='--', linewidth=0.5,)

plt.xticks(visible=True)
plt.yticks(visible=True)
mark_inset(ax, axins, loc1=1, loc2=4, fc="none", ec="0.5")

plt.draw()
plt.grid(linestyle='--', linewidth=0.5)
plt.ylim(-8000,8000)
plt.ticklabel_format( axis='x', useMathText = True)

plt.legend(loc=3,prop={'size': 12},frameon=False,ncol=3)
plt.show()