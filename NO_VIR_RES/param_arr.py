import numpy as np
from GFparams import Gfparamsarr, Gfinputsarr
from Symcalc import LV_gridparams


#===========================================================
#--------------------bus parameters-------------------------
#===========================================================
gridparams=np.array([1,0,1], dtype=float)

#===========================================================
#--------------------generator parameters-------------------------
#===========================================================


pgen01 = np.array(Gfparamsarr, dtype=np.float32)
pgen02 = np.array(Gfparamsarr, dtype=np.float32)
pgen03 = np.array(Gfparamsarr, dtype=np.float32)
pgen04 = np.array(Gfparamsarr, dtype=np.float32)


inputs01 = np.array(Gfinputsarr, dtype=np.float32)
inputs02 = np.array(Gfinputsarr, dtype=np.float32)
inputs03 = np.array(Gfinputsarr, dtype=np.float32)
inputs04 = np.array(Gfinputsarr, dtype=np.float32)


ldparams = []
busparams = []
lineparams = []
genparams = []
params = np.concatenate((pgen01, pgen02, pgen03, pgen04, LV_gridparams, gridparams))

inputs = np.concatenate((inputs01, inputs02, inputs03, inputs04))


unitsysparms_label = (['Wrated', 'H', 'wc', 'Kp', 'Kq', 'Kd', 'Kpi', 'Kpv', 'Kiv', 'Kii', 'Cfilt', 'Lfilt', 'LgridLV', 'RgridLV', 'Xtf', 'Cdamp', 'Ldamp', 'Rdamp'])
inputs_label = np.array(['Pref', 'Qref', 'Upcc', 'wref'])





# print(len(busparams))
# print(len(ldparams)+len(busparams))
# print(len(lineparams)+len(ldparams)+len(busparams))
# print(len(genparams)+len(lineparams)+len(ldparams)+len(busparams))
# print(params)