from PUdefs import *
import numpy as np

Wrated = 376.991
# -----------Inverter 1----------------
#
# ---------control parameters---------

# ---------plant paramaters-------------
# ---------Actual values---------

VratedLLrmsLV1 = 0.69

# -----------Inverter ----------------

# ---------control parameters---------
# -----------Inverter 1----------------
#
# ---------control parameters---------
H1 = 5
wc1 = 1000
Kp1 = 1
Kq1 = 0.0868
Kd1 = 20
# Kpi1 = 27.0633
# Kpv1 = 0.177445
# Kiv1 = 2.92252
# Kii1 = 156.25

Kpi1 = 5.0
Kpv1 = 1.0
Kiv1 = 10.0
Kii1 = 5.0




# ---------plant paramaters-------------
# ---------Actual values---------

# Filter
Lfilt1 = 0.335e-3
F_cutoff1 = 900

Cfilt1 = 700e-6
Cdamp1 = 700e-6
Ldamp1 = 0.621e-3
Rdamp1 = 1.332


# LV line
Lgrid1LV = 0.04e-3
Rgrid1LV = 0.05

# LV transformer
Xtf1 = 0.05

# ----------------Input Parameters-------------

Pref1 = 0.815
Qref1 = 0.00745
Upcc1 = 1
wref1 = 1

# -----------Inf source Params----------------

Ugrid_Q = 1
Ugrid_D = 0
wsys = 1

#-----------Network Parameters-----------------

#--------HV transformer-------------

R_01 = 0.015235
wL_01 = 0.001937 * Wbase

#--------PI component 1--------------

R_02 = 0.00369 * 11.9025
wL_02 = 0.00454 * 11.9025
wC_02 = 0.00061 / 11.9025

#--------PI component 2--------------

Length_x = 1

R_03 = 0.000502 * 11.9025 * Length_x
wL_03 = 0.000512 * 11.9025 * 10 * Length_x
wC_03 = 0.00005 * 10 * Length_x / 11.9025