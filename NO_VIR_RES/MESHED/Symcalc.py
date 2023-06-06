from sympy import *
import numpy as np
from PUdefs import *

String_Line = np.array([0.000502, 0.000512,0.00005], dtype=float)*1000
Conv_Line = np.array([0.005, 0.04e-3], dtype=float)

pline1ld=np.array([44.528, 26.558, 0.00005], dtype=float)
pline2ld=np.array([44.528, 26.558, 0.00005], dtype=float)


Wbase = Wrated

VbaseLV = (VratedLLrmsLV * np.sqrt(2)) / (np.sqrt(3))
ZbaseLV = (VratedLLrmsLV ** 2) / MVAbase
LbaseLV = ZbaseLV / Wrated
CbaseLV = 1 / (Wrated * ZbaseLV)

ZbaseHV = (VratedLLrmsHV ** 2) / MVAbase
LbaseHV = ZbaseHV / Wrated
CbaseHV = 1 / (Wrated * ZbaseHV)


R1g = pline1ld[0]
R1 = Conv_Line[0]/ZbaseLV
R2 = Conv_Line[0]/ZbaseLV
R3 = pline2ld[0]
R4 = Conv_Line[0]/ZbaseLV
R5 = Conv_Line[0]/ZbaseLV

L1g = pline1ld[1]
L1 = Conv_Line[1]/LbaseLV + 0.05 * 50
L2 = Conv_Line[1]/LbaseLV + 0.05 * 50
L3 = pline2ld[1]
L4 = Conv_Line[1]/LbaseLV + 0.05 * 50
L5 = Conv_Line[1]/LbaseLV + 0.05 * 50


R21 = String_Line[0]#*3
R32 = String_Line[0]#*8
R43 = String_Line[0]#*9
R54 = String_Line[0]#*6
R15 = String_Line[0]#*2
R42 = String_Line[0]#*4

L21 = String_Line[1]
L32 = String_Line[1]
L43 = String_Line[1]
L54 = String_Line[1]
L15 = String_Line[1]
L42 = String_Line[1]


# R1 = R2 = R3 = R4 = R5 = Conv_Line[0]/ZbaseLV
# L1 = L2 = L3 = L4 = L5 = Conv_Line[1]/LbaseLV + 0.05 * PU_Scaler # line + transformer
#
# R21 = R32 = R43 = R54 = String_Line[0]
# L21 = L32 = L43 = L54 = String_Line[1]



Vc1, Vc2, Vc3, Vc4, Vc5 = symbols('Vc1, Vc2, Vc3, Vc4, Vc5')
dI1, dI2, dI3, dI4, dI5 = symbols('dI1, dI2, dI3, dI4, dI5')
I1, I2, I3, I4, I5 = symbols('I1, I2, I3, I4, I5')
# L1, L2 ,L3, L4, L5 = symbols('L1, L2 ,L3, L4, L5')
# R1, R2 ,R3, R4, R5 = symbols('R1, R2 ,R3, R4, R5')


# R1g, R21 ,R32, R43, R54 = symbols('R1g, R21 ,R32, R43, R54')
# L1g, L21 ,L32, L43, L54 = symbols('L1g, L21 ,L32, L43, L54')
dI1g, dI21, dI32, dI43, dI54, dI15, dI42 = symbols('dI1g, dI21, dI32, dI43, dI54, dI15, dI42')
I1g, I21, I32, I43, I54, I15, I42 = symbols('I1g, I21, I32, I43, I54, I15, I42')
Vg, V1, V2, V3, V4, V5 = symbols('Vg, V1, V2, V3, V4, V5')

#======source current injections====================
V1 = (L1g/Wrated) * dI1g + R1g * I1g + Vg
dI1 = (Wrated/L1) * (Vc1 - V1 - R1*I1)


I21 = I1g + I15 - I1
dI21 = dI1g + dI15 - dI1

V2 = (L21/Wrated) * dI21 + R21 * I21 + V1
dI2 = (Wrated/L2) * (Vc2 - V2 - R2 * I2)

I32 = I21 - I2 - I42
dI32 = dI21 - dI2 - dI42

V3 = (L32/Wrated) * dI32 + R32 * I32 + V2
dI3 = (Wrated/L3) * (Vc3 - V3 - R3 * I3)

I43 = I32 - I3
dI43 = dI32 - dI3

V4 = (L43/Wrated) * dI43 + R43 * I43 + V3
dI4 = (Wrated/L4) * (Vc4 - V4 - R4 * I4)



I54 = I43 + I42 - I4
dI54 = dI43 + dI42 - dI4


V5 = (L54/Wrated) * dI54 + R54 * I54 + V4
dI5 = (Wrated/L5) * (Vc5 - V5 - R5 * I5)


#-------Branch currents for the mesh----------------
eqdI15 = (Wrated/L15) * (V1 - V5 - R15 * I15) - dI15

dI15_ = solve(eqdI15, dI15)


dI15_ = dI15_[0]

V5 = V5.subs(dI15, dI15_)
V4 = V4.subs(dI15, dI15_)
V3 = V3.subs(dI15, dI15_)
V2 = V2.subs(dI15, dI15_)
V1 = V3.subs(dI15, dI15_)

dI2 = (dI2.subs(dI15, dI15_))
dI3 = (dI3.subs(dI15, dI15_))
dI4 = (dI4.subs(dI15, dI15_))
dI5 = (dI5.subs(dI15, dI15_))


eqdT42 = (Wrated/L42) * (V4 - V2 - R42 * I42) - dI42
dI42_ = solve(eqdT42, dI42)

dI42_= dI42_[0]

V5 = V5.subs(dI42, dI42_)
V4 = V4.subs(dI42, dI42_)
V3 = V3.subs(dI42, dI42_)
V2 = V2.subs(dI42, dI42_)
V1 = V1.subs(dI42, dI42_)

dI2 = (dI2.subs(dI42, dI42_))
dI3 = (dI3.subs(dI42, dI42_))
dI4 = (dI4.subs(dI42, dI42_))
dI5 = (dI5.subs(dI42, dI42_))
dI5 = (dI5.subs(dI42, dI42_))
dI15 = dI15_.subs(dI42, dI42_)

eq = dI1 + dI2 + dI3 + dI4 + dI5 - dI1g

I1g_new = I1 + I2 + I3 + I4 + I5

dI1g_ = solve(eq, dI1g)


#
V5 = V5.subs(dI1g, dI1g_[0])
V4 = V4.subs(dI1g, dI1g_[0])
V3 = V3.subs(dI1g, dI1g_[0])
V2 = V2.subs(dI1g, dI1g_[0])
V1 = V1.subs(dI1g, dI1g_[0])

dI1 = (dI1.subs(dI1g, dI1g_[0])).subs(I1g, I1g_new)
dI2 = (dI2.subs(dI1g, dI1g_[0])).subs(I1g, I1g_new)
dI3 = (dI3.subs(dI1g, dI1g_[0])).subs(I1g, I1g_new)
dI4 = (dI4.subs(dI1g, dI1g_[0])).subs(I1g, I1g_new)
dI5 = (dI5.subs(dI1g, dI1g_[0])).subs(I1g, I1g_new)

dI42 = dI42_

dI42 = (dI42.subs(dI1g, dI1g_[0])).subs(I1g, I1g_new)
dI15 = (dI15.subs(dI1g, dI1g_[0])).subs(I1g, I1g_new)

# print(dI42)




#
#
print(dI1)
print(dI2)
print(dI3)
print(dI4)
print(dI5)
print(dI15)
print(dI42)


#
# print(V1)
# print(V2)
# print(V3)
# print(V4)
# print(V5)



dI1_C = [dI1.coeff(I1),dI1.coeff(I2),dI1.coeff(I3),dI1.coeff(I4),dI1.coeff(I5),dI1.coeff(I21),dI1.coeff(I42),dI1.coeff(Vg),dI1.coeff(Vc1),dI1.coeff(Vc2),dI1.coeff(Vc3),dI1.coeff(Vc4),dI1.coeff(Vc5)]
dI2_C = [dI2.coeff(I1),dI2.coeff(I2),dI2.coeff(I3),dI2.coeff(I4),dI2.coeff(I5),dI2.coeff(I21),dI2.coeff(I42),dI2.coeff(Vg),dI2.coeff(Vc1),dI2.coeff(Vc2),dI2.coeff(Vc3),dI2.coeff(Vc4),dI2.coeff(Vc5)]
dI3_C = [dI3.coeff(I1),dI3.coeff(I2),dI3.coeff(I3),dI3.coeff(I4),dI3.coeff(I5),dI3.coeff(I21),dI3.coeff(I42),dI3.coeff(Vg),dI3.coeff(Vc1),dI3.coeff(Vc2),dI3.coeff(Vc3),dI3.coeff(Vc4),dI3.coeff(Vc5)]
dI4_C = [dI4.coeff(I1),dI4.coeff(I2),dI4.coeff(I3),dI4.coeff(I4),dI4.coeff(I5),dI4.coeff(I21),dI4.coeff(I42),dI4.coeff(Vg),dI4.coeff(Vc1),dI4.coeff(Vc2),dI4.coeff(Vc3),dI4.coeff(Vc4),dI4.coeff(Vc5)]
dI5_C = [dI5.coeff(I1),dI5.coeff(I2),dI5.coeff(I3),dI5.coeff(I4),dI5.coeff(I5),dI5.coeff(I21),dI5.coeff(I42),dI5.coeff(Vg),dI5.coeff(Vc1),dI5.coeff(Vc2),dI5.coeff(Vc3),dI5.coeff(Vc4),dI5.coeff(Vc5)]
dI21_C =[dI21.coeff(I1),dI21.coeff(I2),dI21.coeff(I3),dI21.coeff(I4),dI21.coeff(I5),dI21.coeff(I21),dI21.coeff(I42),dI21.coeff(Vg),dI21.coeff(Vc1),dI21.coeff(Vc2),dI21.coeff(Vc3),dI21.coeff(Vc4),dI21.coeff(Vc5)]
dI42_C =[dI42.coeff(I1),dI42.coeff(I2),dI42.coeff(I3),dI42.coeff(I4),dI42.coeff(I5),dI42.coeff(I21),dI42.coeff(I42),dI42.coeff(Vg),dI42.coeff(Vc1),dI42.coeff(Vc2),dI42.coeff(Vc3),dI42.coeff(Vc4),dI42.coeff(Vc5)]



LV_gridparams = np.concatenate((dI1_C, dI2_C, dI3_C, dI4_C, dI5_C, dI21_C, dI42_C))

LV_gridparams = np.array(LV_gridparams, dtype=np.float32)



print(len(LV_gridparams))