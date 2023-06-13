from PUdefs import *
import numpy as np

Wrated = 376.991
# -----------Inverter 1----------------
#
# ---------control parameters---------

# ---------plant paramaters-------------
# ---------Actual values---------

VratedLLrmsLV = 0.69

# -----------Inverter ----------------

# ---------control parameters---------
# -----------Inverter 1----------------
#
# ---------control parameters---------
H = 5
wc = 1000
Kp = 1
Kq = 0.0168
Kd = 20
# Kpi = 27.0633
# Kpv = 0.177445
# Kiv = 2.92252
# Kii = 156.25

Kpi = 5.0
Kpv = 1.0
Kiv = 10.0
Kii = 5.0




# ---------plant paramaters-------------
# ---------Actual values---------

# Filter
Lfilt = 0.335e-3
F_cutoff = 900

Cfilt = 700e-6
Cdamp = 700e-6
Ldamp = 0.621e-3
Rdamp = 1.332


# LV line
LgridLV = 0.04e-3
RgridLV = 0.005

# LV transformer
Xtf = 0.05

# ----------------Input Parameters-------------

Pref = 0.815
Qref = 0.00745
Upcc = 1
wref = 1



Gfparamsarr = np.array([Wrated, H, wc, Kp, Kq, Kd, Kpi, Kpv, Kiv, Kii, Cfilt, Lfilt, LgridLV, RgridLV, Xtf, Cdamp, Ldamp, Rdamp], dtype=float)
Gfinputsarr = np.array([Pref, Qref, Upcc, wref], dtype=float)