from sympy import *
import numpy as np


#========per unitization of parameters for the microgrid model=================

VratedLLrmsHV=34.5
MVAbase=100
Wrated=376.991
VratedLLrmsLV=0.69
VratedPhrmsHV = VratedLLrmsHV / np.sqrt(3)
Wbase = Wrated

VbaseLV = (VratedLLrmsLV * np.sqrt(2)) / (np.sqrt(3))
ZbaseLV = (VratedLLrmsLV ** 2) / MVAbase
LbaseLV = ZbaseLV / Wrated
CbaseLV = 1 / (Wrated * ZbaseLV)

ZbaseHV = (VratedLLrmsHV ** 2) / MVAbase
LbaseHV = ZbaseHV / Wrated
CbaseHV = 1 / (Wrated * ZbaseHV)


#========per unit values of the line impedances (R(pu), X(pu))=================
String_Line = np.array([0.502, 0.512], dtype=float)



#========values of the converter impedances (R (Ohm), L(H)) =================
Conv_Line = np.array([0.005, 0.04e-3], dtype=float)
Conv_Line = np.array([0.005, 0.04e-3], dtype=float)

X_LVtf = 0.05

#========per unit values of the Load impedances (Rload, Lload)=================
pline1ld=np.array([44.528, 26.558], dtype=float)
pline2ld=np.array([44.528, 26.558], dtype=float)



#====Assigning the values and per unitizing of LV impedances=======
Rload1 = pline1ld[0]
R1 = Conv_Line[0]/ZbaseLV
R2 = Conv_Line[0]/ZbaseLV
Rload2 = pline2ld[0]
R4 = Conv_Line[0]/ZbaseLV
R5 = Conv_Line[0]/ZbaseLV

Lload1 = pline1ld[1]
L1 = Conv_Line[1]/LbaseLV + X_LVtf * 50
L2 = Conv_Line[1]/LbaseLV + X_LVtf * 50
Lload2 = pline2ld[1]
L4 = Conv_Line[1]/LbaseLV + X_LVtf * 50
L5 = Conv_Line[1]/LbaseLV + X_LVtf * 50


R12 = String_Line[0]
R23 = String_Line[0]
R34 = String_Line[0]
R45 = String_Line[0]

L21 = String_Line[1]
L32 = String_Line[1]
L43 = String_Line[1]
L45 = String_Line[1]


# ================================ Symbolic Definitions of Variables ==================================

Vconv1, Vconv2, Vload_ground, Vconv4, Vconv5 = symbols('Vconv1, Vconv2, Vload_ground, Vconv4, Vconv5')          
dI1, dI2, dIload2, dI3, dI4 = symbols('dI1, dI2, dIload2, dI3, dI4')
I1, I2, Iload2, I3, I4 = symbols('I1, I2, Iload2, I3, I4')


dIload1, dI21, dI32, dI43, dI54 = symbols('dIload1, dI21, dI32, dI43, dI54')
Iload1, I12, I12, I34, I45 = symbols('Iload1, I12, I12, I34, I45')
Vload1_ground, V1, V2, V3, V4, V5 = symbols('Vload1_ground, V1, V2, V3, V4, V5')


V1 = (Lload1/Wrated) * dIload1 + Rload1 * Iload1 + Vload1_ground
dI1 = (Wrated/L1) * (Vconv1 - V1 - R1*I1)

I12 = Iload1 - I1
dI21 = dIload1 - dI1


V2 = (L21/Wrated) * dI21 + R12 * I12 + V1
dI2 = (Wrated/L2) * (Vconv2 - V2 -R2 * I2)

I12 = Iload1 - I1 - I2
dI32 = dIload1 - dI1 - dI2


V3 = (L32/Wrated) * dI32 + R23 * I12 + V2
dIload2 = (Wrated/Lload2) * (Vload_ground - V3 -Rload2 * Iload2)

I34 = Iload1 - I1 - I2 - Iload2
dI43 = dIload1 - dI1 - dI2 - dIload2


V4 = (L43/Wrated) * dI43 + R34 * I34 + V3
dI3 = (Wrated/L4) * (Vconv4 - V4 -R4 * I3)

I45 = Iload1 - I1 - I2 - Iload2 - I3
dI54 = dIload1 - dI1 - dI2 - dIload2 - dI3

V5 = (L45/Wrated) * dI54 + R45 * I45 + V4
dI4 = (Wrated/L5) * (Vconv5 - V5 - R5 * I4)

eq = dI1 + dI2 + dIload2 + dI3 + dI4 - dIload1

Iload1_new = I1 + I2 + Iload2 + I3 + I4


dIload1_ = solve(eq, dIload1)

V5_ = V5.subs(dIload1, dIload1_[0])
V4_ = V4.subs(dIload1, dIload1_[0])
V3_ = V3.subs(dIload1, dIload1_[0])
V2_ = V2.subs(dIload1, dIload1_[0])
V1_ = V1.subs(dIload1, dIload1_[0])

dI1 = (dI1.subs(dIload1, dIload1_[0])).subs(Iload1, Iload1_new)
dI2 = (dI2.subs(dIload1, dIload1_[0])).subs(Iload1, Iload1_new)
dIload2 = (dIload2.subs(dIload1, dIload1_[0])).subs(Iload1, Iload1_new)
dI3 = (dI3.subs(dIload1, dIload1_[0])).subs(Iload1, Iload1_new)
dI4 = (dI4.subs(dIload1, dIload1_[0])).subs(Iload1, Iload1_new)



# simplify(dIload1)
# print(dIload1_)

print(dI1)
print(dI2)
print(dIload2)
print(dI3)
print(dI4)



dI1_C = [dI1.coeff(I1),dI1.coeff(I2),dI1.coeff(Iload2),dI1.coeff(I3),dI1.coeff(I4),dI1.coeff(Vload1_ground),dI1.coeff(Vconv1),dI1.coeff(Vconv2),dI1.coeff(Vload_ground),dI1.coeff(Vconv4),dI1.coeff(Vconv5)]
dI2_C = [dI2.coeff(I1),dI2.coeff(I2),dI2.coeff(Iload2),dI2.coeff(I3),dI2.coeff(I4),dI2.coeff(Vload1_ground),dI2.coeff(Vconv1),dI2.coeff(Vconv2),dI2.coeff(Vload_ground),dI2.coeff(Vconv4),dI2.coeff(Vconv5)]
dIload2_C = [dIload2.coeff(I1),dIload2.coeff(I2),dIload2.coeff(Iload2),dIload2.coeff(I3),dIload2.coeff(I4),dIload2.coeff(Vload1_ground),dIload2.coeff(Vconv1),dIload2.coeff(Vconv2),dIload2.coeff(Vload_ground),dIload2.coeff(Vconv4),dIload2.coeff(Vconv5)]
dI3_C = [dI3.coeff(I1),dI3.coeff(I2),dI3.coeff(Iload2),dI3.coeff(I3),dI3.coeff(I4),dI3.coeff(Vload1_ground),dI3.coeff(Vconv1),dI3.coeff(Vconv2),dI3.coeff(Vload_ground),dI3.coeff(Vconv4),dI3.coeff(Vconv5)]
dI4_C = [dI4.coeff(I1),dI4.coeff(I2),dI4.coeff(Iload2),dI4.coeff(I3),dI4.coeff(I4),dI4.coeff(Vload1_ground),dI4.coeff(Vconv1),dI4.coeff(Vconv2),dI4.coeff(Vload_ground),dI4.coeff(Vconv4),dI4.coeff(Vconv5)]

LV_gridparams = np.concatenate((dI1_C, dI2_C, dIload2_C, dI3_C, dI4_C))

LV_gridparams = np.array(LV_gridparams, dtype=np.float32)



np.savetxt("LV_gridparams.csv", LV_gridparams, delimiter=',')

# print(len(LV_gridparams))
