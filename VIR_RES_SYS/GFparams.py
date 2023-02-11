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
Kq1 = 0.2
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
Rgrid1LV = 0.005

# LV transformer
Xtf1 = 0.05

# ----------------Input Parameters-------------

Pref1 = 0.52
Qref1 = 0.3
Upcc1 = 1
wref1 = 1



Gfparamsarr = np.array([Wrated, H1, wc1, Kp1, Kq1, Kd1, Kpi1, Kpv1, Kiv1, Kii1, Cfilt1, Lfilt1, Lgrid1LV, Rgrid1LV, Xtf1, Cdamp1, Ldamp1, Rdamp1], dtype=float)
Gfinputsarr = np.array([Pref1, Qref1, Upcc1, wref1], dtype=float)