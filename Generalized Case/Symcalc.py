from sympy import *
import numpy as np
from PUdefs import *

TF_line = np.array([0.00369,0.00454, 0.00061], dtype=float)
String_Line = np.array([0.000502, 0.000512,0.00005], dtype=float)
Conv_Line = np.array([0.005, 0.04e-3], dtype=float)

Wbase = Wrated

VbaseLV = (VratedLLrmsLV * np.sqrt(2)) / (np.sqrt(3))
ZbaseLV = (VratedLLrmsLV ** 2) / MVAbase
LbaseLV = ZbaseLV / Wrated
CbaseLV = 1 / (Wrated * ZbaseLV)

ZbaseHV = (VratedLLrmsHV ** 2) / MVAbase
LbaseHV = ZbaseHV / Wrated
CbaseHV = 1 / (Wrated * ZbaseHV)



Rg = TF_line[0]
Lg = TF_line[1]


R1 = String_Line[0] * 2

R11 = String_Line[0] * 3
R111 = 3 * Conv_Line[0]/ZbaseLV
R112 = 9 * Conv_Line[0]/ZbaseLV

R12 = String_Line[0] * 3
R121 = 1 * Conv_Line[0]/ZbaseLV
R122 = 4 * Conv_Line[0]/ZbaseLV



R2 = String_Line[0] * 3

R21 = String_Line[0] * 3
R211 = 7 * Conv_Line[0]/ZbaseLV
R212 = 2 * Conv_Line[0]/ZbaseLV

R22 = String_Line[0] * 3
R221 = 5 * Conv_Line[0]/ZbaseLV
R222 = 6 * Conv_Line[0]/ZbaseLV




L1 = String_Line[1] * 2

L11 = String_Line[1] * 3
L111 = 3 * Conv_Line[1]/LbaseLV + 0.05 * 50
L112 = 9 * Conv_Line[1]/LbaseLV + 0.05 * 50

L12 = String_Line[1] * 3
L121 = 1 * Conv_Line[1]/LbaseLV + 0.05 * 50
L122 = 4 * Conv_Line[1]/LbaseLV + 0.05 * 50


L2 = String_Line[1] * 3

L21 = String_Line[1] * 3
L211 = 7 * Conv_Line[1]/LbaseLV + 0.05 * 50
L212 = 2 * Conv_Line[1]/LbaseLV + 0.05 * 50

L22 = String_Line[1] * 3
L221 = 5 * Conv_Line[1]/LbaseLV + 0.05 * 50
L222 = 6 * Conv_Line[1]/LbaseLV + 0.05 * 50







#
# R1 = 1 * Conv_Line[0]/ZbaseLV
# R2 = 4 * Conv_Line[0]/ZbaseLV
# R3 = 7 * Conv_Line[0]/ZbaseLV
# R4 = 2 * Conv_Line[0]/ZbaseLV
# R5 = 3 * Conv_Line[0]/ZbaseLV
#
# L1 = 1 * Conv_Line[1]/LbaseLV + 0.05 * 50
# L2 = 4 * Conv_Line[1]/LbaseLV + 0.05 * 50
# L3 = 7 * Conv_Line[1]/LbaseLV + 0.05 * 50
# L4 = 2 * Conv_Line[1]/LbaseLV + 0.05 * 50
# L5 = 3 * Conv_Line[1]/LbaseLV + 0.05 * 50




Vg,V0,V1,V2,V11,V111,V112,V12,V121,V122,V21,V211,V212,V22,V221,V222 = symbols('Vg,V0,V1,V2,V11,V111,V112,V12,V121,V122,V21,V211,V212,V22,V221,V222')
Ig,I1,I2,I11,I111,I112,I12,I121,I122,I21,I211,I212,I22,I221,I222 = symbols('Ig,I1,I2,I11,I111,I112,I12,I121,I122,I21,I211,I212,I22,I221,I222')
dIg,dI1,dI2,dI11,dI111,dI112,dI12,dI121,dI122,dI21,dI211,dI212,dI22,dI221,dI222  = symbols('dIg,dI1,dI2,dI11,dI111,dI112,dI12,dI121,dI122,dI21,dI211,dI212,dI22,dI221,dI222 ')

I11 = I111 + I112
I12 = I121 + I122
I1 = I11 + I12


I21 = I211 + I212
I22 = I221 + I222
I2 = I21 + I22

V0 = (Lg/Wrated) * dIg + Vg + Rg*Ig

V1 = (L1/Wrated) * dI1 + V0 + R1*I1
V2 = (L2/Wrated) * dI2 + V0 + R2*I2

V11 = (L11/Wrated) * dI11 + V1 + R11*I11
V12 = (L12/Wrated) * dI12 + V1 + R12*I12

V21 = (L21/Wrated) * dI21 + V2 + R21*I21
V22 = (L22/Wrated) * dI22 + V2 + R22*I22





#=================I1 Branch=================================
dI111 = (Wrated/L111) * (V111 - V11 - R111*I111)
dI112 = (Wrated/L112) * (V112 - V11 - R112*I112)

dI121 = (Wrated/L121) * (V121 - V12 - R121*I121)
dI122 = (Wrated/L122) * (V122 - V12 - R122*I122)


eqdI11 = dI111 + dI112 - dI11
eqdI12 = dI121 + dI122 - dI12

dI11_ = solve(eqdI11, dI11)
dI12_ = solve(eqdI12, dI12)


eqdI1 = dI11_[0] + dI12_[0] - dI1

dI1_ = solve(eqdI1, dI1)

# print(dI1)

#=================I2 Branch=================================
dI211 = (Wrated/L211) * (V211 - V21 - R211*I211)
dI212 = (Wrated/L212) * (V212 - V21 - R212*I212)

dI221 = (Wrated/L221) * (V221 - V22 - R221*I221)
dI222 = (Wrated/L222) * (V222 - V22 - R222*I222)


eqdI21 = dI211 + dI212 - dI21
eqdI22 = dI221 + dI222 - dI22

dI21_ = solve(eqdI21, dI21)
dI22_ = solve(eqdI22, dI22)


eqdI2 = dI21_[0] + dI22_[0] - dI2

dI2_ = solve(eqdI2, dI2)

# print(dI2)

#=================Ig Branch=================================


eqdIg = dI1_[0] + dI2_[0] - dIg

#-----solve for Ig--------
dIg_ = solve(eqdIg, dIg)

# print(dIg_)

#=================Substitute dIg for Branch Current derivatives=================================

dI1__ = dI1_[0].subs(dIg,dIg_[0])

dI11__ = dI11_[0].subs(dIg,dIg_[0]).subs(dI1,dI1__)
dI111__ = dI111.subs(dIg,dIg_[0]).subs(dI1,dI1__).subs(dI11,dI11__)
dI112__ = dI112.subs(dIg,dIg_[0]).subs(dI1,dI1__).subs(dI11,dI11__)

dI12__ = dI12_[0].subs(dIg,dIg_[0]).subs(dI1,dI1__)
dI121__ = dI121.subs(dIg,dIg_[0]).subs(dI1,dI1__).subs(dI12,dI12__)
dI122__ = dI122.subs(dIg,dIg_[0]).subs(dI1,dI1__).subs(dI12,dI12__)



dI2__ = dI2_[0].subs(dIg,dIg_[0])

dI21__ = dI21_[0].subs(dIg,dIg_[0]).subs(dI2,dI2__)
dI211__ = dI211.subs(dIg,dIg_[0]).subs(dI2,dI2__).subs(dI21,dI21__)
dI212__ = dI212.subs(dIg,dIg_[0]).subs(dI2,dI2__).subs(dI21,dI21__)

dI22__ = dI22_[0].subs(dIg,dIg_[0]).subs(dI2,dI2__)
dI221__ = dI221.subs(dIg,dIg_[0]).subs(dI2,dI2__).subs(dI22,dI22__)
dI222__ = dI222.subs(dIg,dIg_[0]).subs(dI2,dI2__).subs(dI22,dI22__)




# print(dI111__)
# print(dI112__)
# print(dI121__)
# print(dI122__)
# print(dI211__)
# print(dI212__)
# print(dI221__)
# print(dI222__)
#



dI111_C = [dI111__.coeff(Ig),
           dI111__.coeff(I111),dI111__.coeff(I112),dI111__.coeff(I121),dI111__.coeff(I122),
           dI111__.coeff(I211),dI111__.coeff(I212),dI111__.coeff(I221),dI111__.coeff(I222),
           dI111__.coeff(Vg),
           dI111__.coeff(V111),dI111__.coeff(V112),dI111__.coeff(V121),dI111__.coeff(V122),
           dI111__.coeff(V211),dI111__.coeff(V212),dI111__.coeff(V221),dI111__.coeff(V222)]

dI112_C = [dI112__.coeff(Ig),
           dI112__.coeff(I111),dI112__.coeff(I112),dI112__.coeff(I121),dI112__.coeff(I122),
           dI112__.coeff(I211),dI112__.coeff(I212),dI112__.coeff(I221),dI112__.coeff(I222),
           dI112__.coeff(Vg),
           dI112__.coeff(V111),dI112__.coeff(V112),dI112__.coeff(V121),dI112__.coeff(V122),
           dI112__.coeff(V211),dI112__.coeff(V212),dI112__.coeff(V221),dI112__.coeff(V222)]

dI121_C = [dI121__.coeff(Ig),
           dI121__.coeff(I111),dI121__.coeff(I112),dI121__.coeff(I121),dI121__.coeff(I122),
           dI121__.coeff(I211),dI121__.coeff(I212),dI121__.coeff(I221),dI121__.coeff(I222),
           dI121__.coeff(Vg),
           dI121__.coeff(V111),dI121__.coeff(V112),dI121__.coeff(V121),dI121__.coeff(V122),
           dI121__.coeff(V211),dI121__.coeff(V212),dI121__.coeff(V221),dI121__.coeff(V222)]

dI122_C = [dI122__.coeff(Ig),
           dI122__.coeff(I111),dI122__.coeff(I112),dI122__.coeff(I121),dI122__.coeff(I122),
           dI122__.coeff(I211),dI122__.coeff(I212),dI122__.coeff(I221),dI122__.coeff(I222),
           dI122__.coeff(Vg),
           dI122__.coeff(V111),dI122__.coeff(V112),dI122__.coeff(V121),dI122__.coeff(V122),
           dI122__.coeff(V211),dI122__.coeff(V212),dI122__.coeff(V221),dI122__.coeff(V222)]


dI211_C = [dI211__.coeff(Ig),
           dI211__.coeff(I111),dI211__.coeff(I112),dI211__.coeff(I121),dI211__.coeff(I122),
           dI211__.coeff(I211),dI211__.coeff(I212),dI211__.coeff(I221),dI211__.coeff(I222),
           dI211__.coeff(Vg),
           dI211__.coeff(V111),dI211__.coeff(V112),dI211__.coeff(V121),dI211__.coeff(V122),
           dI211__.coeff(V211),dI211__.coeff(V212),dI211__.coeff(V221),dI211__.coeff(V222)]

dI212_C = [dI212__.coeff(Ig),
           dI212__.coeff(I111),dI212__.coeff(I112),dI212__.coeff(I121),dI212__.coeff(I122),
           dI212__.coeff(I211),dI212__.coeff(I212),dI212__.coeff(I221),dI212__.coeff(I222),
           dI212__.coeff(Vg),
           dI212__.coeff(V111),dI212__.coeff(V112),dI212__.coeff(V121),dI212__.coeff(V122),
           dI212__.coeff(V211),dI212__.coeff(V212),dI212__.coeff(V221),dI212__.coeff(V222)]

dI221_C = [dI221__.coeff(Ig),
           dI221__.coeff(I111),dI221__.coeff(I112),dI221__.coeff(I121),dI221__.coeff(I122),
           dI221__.coeff(I211),dI221__.coeff(I212),dI221__.coeff(I221),dI221__.coeff(I222),
           dI221__.coeff(Vg),
           dI221__.coeff(V111),dI221__.coeff(V112),dI221__.coeff(V121),dI221__.coeff(V122),
           dI221__.coeff(V211),dI221__.coeff(V212),dI221__.coeff(V221),dI221__.coeff(V222)]

dI222_C = [dI222__.coeff(Ig),
           dI222__.coeff(I111),dI222__.coeff(I112),dI222__.coeff(I121),dI222__.coeff(I122),
           dI222__.coeff(I211),dI222__.coeff(I212),dI222__.coeff(I221),dI222__.coeff(I222),
           dI222__.coeff(Vg),
           dI222__.coeff(V111),dI222__.coeff(V112),dI222__.coeff(V121),dI222__.coeff(V122),
           dI222__.coeff(V211),dI222__.coeff(V212),dI222__.coeff(V221),dI222__.coeff(V222)]

dIg_ = dIg_[0]
dIg_C =   [dIg_.coeff(Ig),
           dIg_.coeff(I111),dIg_.coeff(I112),dIg_.coeff(I121),dIg_.coeff(I122),
           dIg_.coeff(I211),dIg_.coeff(I212),dIg_.coeff(I221),dIg_.coeff(I222),
           dIg_.coeff(Vg),
           dIg_.coeff(V111),dIg_.coeff(V112),dIg_.coeff(V121),dIg_.coeff(V122),
           dIg_.coeff(V211),dIg_.coeff(V212),dIg_.coeff(V221),dIg_.coeff(V222)]


#
#
# # print(dI11_C)
#
LV_gridparams = np.concatenate((dIg_C,dI111_C,dI112_C,dI121_C,dI122_C,dI211_C,dI212_C,dI221_C,dI222_C))
#
LV_gridparams = np.array(LV_gridparams, dtype=np.float32)
#
# print(LV_gridparams)