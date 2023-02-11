import numpy as np
from GFparams import Gfparamsarr, Gfinputsarr

VratedLLrmsLV1 = 230
#===========================================================
#--------------------line parameters-------------------------
#===========================================================
pline01_02=np.array([0.000502, 0.000512,0.00005], dtype=float)*1000
pline02_03=np.array([0.000502, 0.000512,0.00005], dtype=float)*1000
pline03_04=np.array([0.000502, 0.000512,0.00005], dtype=float)*1000
pline04_05=np.array([0.000502, 0.000512,0.00005], dtype=float)*1000


pline1ld=np.array([44.528, 26.558, 0.00005], dtype=float)
pline2ld=np.array([44.528, 26.558, 0.00005], dtype=float)

#===========================================================
#--------------------bus parameters-------------------------
#===========================================================

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
lineparams = np.concatenate((pline01_02[0:2], pline02_03[0:2],pline03_04[0:2], pline04_05[0:2], pline1ld[0:2], pline2ld[0:2]))
genparams = np.concatenate((pgen01, pgen02, pgen03, pgen04))
params = np.concatenate((lineparams,genparams))

inputs = np.concatenate((inputs01, inputs02, inputs03, inputs04))

unitsysparms_label = (['Wrated', 'H', 'wc', 'Kp', 'Kq', 'Kd', 'Kpi', 'Kpv', 'Kiv', 'Kii', 'Cfilt', 'Lfilt', 'LgridLV', 'RgridLV', 'Xtf', 'Cdamp', 'Ldamp', 'Rdamp'])
inputs_label = np.array(['Pref', 'Qref', 'Upcc', 'wref'])



print(len(busparams))
print(len(ldparams)+len(busparams))
print(len(lineparams)+len(ldparams)+len(busparams))
print(len(genparams)+len(lineparams)+len(ldparams)+len(busparams))
# print(params)