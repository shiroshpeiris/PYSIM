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


cols_eigs_py = ["P1_x","P1_y"]
cols_eigs_PSCAD = ["Domain","Pdq"]

plot_lines = []


# only read specific columns from an excel file
df_py = pd.read_csv('PRESP_DATA_PY.csv', usecols=cols_eigs_py)
df_PSCAD = pd.read_csv('PRESP_DATA_PSCAD.csv', usecols=cols_eigs_PSCAD)
df_PSCAD_SWTCH = pd.read_csv('PRESP_DATA_PSCAD_SWTCH.csv', usecols=cols_eigs_PSCAD)


ax.plot(df_py["P1_x"], df_py["P1_y"],'r',linestyle='solid',label = "Proposed System")
ax.plot(df_PSCAD["Domain"], df_PSCAD["Pdq"],'y',linestyle='dashed',label = "PSCAD/EMTDC Average Value Model")
# ax.plot(df_PSCAD_SWTCH["Domain"], df_PSCAD_SWTCH["Pdq"],'g',linestyle='dotted',label = "PSCAD/EMTDC Detailed Switching Model")



# plot_lines.append([line1, line2, line3])
# legend1 = plt.legend(plot_lines[0], ["DP\nmodel", "Constant\nAdmittance Matrix\nmodel","PSCAD/EMTDC"], loc=4,prop={'size': 12},frameon=False,ncol=3)
# #
ax.set_xlabel("Time (s)")
ax.set_ylabel("Active Power (pu)")
#
x1 = 0
x2 = 0.1
#
# # select y-range for zoomed region
y1 = 0.2
y2 = 0.4

# # Make the zoom-in plot:
axins = ax.inset_axes([0.12, 0.35, 0.8, 0.3])

axins.plot(df_py["P1_x"], df_py["P1_y"],'r',linestyle='solid',label = "Proposed System")
axins.plot(df_PSCAD["Domain"], df_PSCAD["Pdq"],'y',linestyle='dashed',label = "PSCAD/EMTDC Average Value Model")
# axins.plot(df_PSCAD_SWTCH["Domain"], df_PSCAD_SWTCH["Pdq"],'g',linestyle='dotted',label = "PSCAD/EMTDC Detailed Switching Model")


axins.set_xlim(x1, x2)
axins.set_ylim(y1, y2)



# ax.indicate_inset_zoom(axins)

axins.grid(linestyle='--', linewidth=0.5,)

plt.xticks(visible=True)
plt.yticks(visible=True)
mark_inset(ax, axins, loc1=2, loc2=3, fc="none", ec="0.5")

plt.draw()
plt.grid(linestyle='--', linewidth=0.5)
plt.xlim(-0.1,10)
plt.legend(loc=3,prop={'size': 12},frameon=False)
plt.show()