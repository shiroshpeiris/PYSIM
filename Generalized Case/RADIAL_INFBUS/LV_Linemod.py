import math
import PUdefs as pu
import numpy as np
from numba import njit
from PUdefs import Wrated
from param_arr import *

@njit
def LV_curr(x, Vin, wsys, LVparams):

    #------- Currents-------

    Iq1g = x[0]
    Id1g = x[1]

    Iq1 = x[2]
    Id1 = x[3]

    Iq2 = x[4]
    Id2 = x[5]

    Iq3 = x[6]
    Id3 = x[7]

    Iq4 = x[8]
    Id4 = x[9]


    Iq5 = x[10]
    Id5 = x[11]

    Iq6 = x[12]
    Id6 = x[13]

    Iq7 = x[14]
    Id7 = x[15]

    Iq8 = x[16]
    Id8 = x[17]





    # Iq5 = x[10]
    # Id5 = x[11]


    # ----- Voltages-------

    Vqg = Vin[0]
    Vdg = Vin[1]

    Vqc1 = Vin[2]
    Vdc1 = Vin[3]

    Vqc2 = Vin[4]
    Vdc2 = Vin[5]

    Vqc3 = Vin[6]
    Vdc3 = Vin[7]

    Vqc4 = Vin[8]
    Vdc4 = Vin[9]

    Vqc5 = Vin[10]
    Vdc5 = Vin[11]

    Vqc6 = Vin[12]
    Vdc6 = Vin[13]

    Vqc7 = Vin[14]
    Vdc7 = Vin[15]

    Vqc8 = Vin[16]
    Vdc8 = Vin[17]

    F = np.empty((18))

    Iqg1_= 0
    Iq1_ = 0
    Iq2_ = 0
    Iq3_ = 0
    Iq4_ = 0
    Iq5_ = 0
    Iq6_ = 0
    Iq7_ = 0
    Iq8_ = 0

    Idg1_= 0
    Id1_ = 0
    Id2_ = 0
    Id3_ = 0
    Id4_ = 0
    Id5_ = 0
    Id6_ = 0
    Id7_ = 0
    Id8_ = 0


    i = 0
    j = 0
    # ---Q axis components---------------
    while j < 18:
        Iqg1_ = LVparams[i] * x[j] + LVparams[i + 9] * Vin[j] + Iqg1_
        Idg1_ = LVparams[i] * x[j+1] + LVparams[i + 9] * Vin[j+1] + Idg1_

        j = j + 2
        i = i + 1
    i = i + 9
    j = 0
    while j < 18:
        Iq1_ = LVparams[i] * x[j] + LVparams[i + 9] * Vin[j] + Iq1_
        Id1_ = LVparams[i] * x[j+1] + LVparams[i + 9] * Vin[j+1] + Id1_

        j = j + 2
        i = i + 1

    i = i + 9
    j = 0
    while j < 18:
        Iq2_ = LVparams[i] * x[j] + LVparams[i + 9] * Vin[j] + Iq2_
        Id2_ = LVparams[i] * x[j+1] + LVparams[i + 9] * Vin[j+1] + Id2_

        j = j + 2
        i = i + 1

    i = i + 9
    j = 0
    while j < 18:
        Iq3_ = LVparams[i] * x[j] + LVparams[i + 9] * Vin[j] + Iq3_
        Id3_ = LVparams[i] * x[j+1] + LVparams[i + 9] * Vin[j+1] + Id3_

        j = j + 2
        i = i + 1

    i = i + 9
    j = 0
    while j < 18:
        Iq4_ = LVparams[i] * x[j] + LVparams[i + 9] * Vin[j] + Iq4_
        Id4_ = LVparams[i] * x[j+1] + LVparams[i + 9] * Vin[j+1] + Id4_

        j = j + 2
        i = i + 1

    i = i + 9
    j = 0
    while j < 18:
        Iq5_ = LVparams[i] * x[j] + LVparams[i + 9] * Vin[j] + Iq5_
        Id5_ = LVparams[i] * x[j+1] + LVparams[i + 9] * Vin[j+1] + Id5_

        j = j + 2
        i = i + 1

    i = i + 9
    j = 0
    while j < 18:
        Iq6_ = LVparams[i] * x[j] + LVparams[i + 9] * Vin[j] + Iq6_
        Id6_ = LVparams[i] * x[j + 1] + LVparams[i + 9] * Vin[j + 1] + Id6_

        j = j + 2
        i = i + 1

    i = i + 9
    j = 0
    while j < 18:
        Iq7_ = LVparams[i] * x[j] + LVparams[i + 9] * Vin[j] + Iq7_
        Id7_ = LVparams[i] * x[j + 1] + LVparams[i + 9] * Vin[j + 1] + Id7_

        j = j + 2
        i = i + 1

    i = i + 9
    j = 0
    while j < 18:
        Iq8_ = LVparams[i] * x[j] + LVparams[i + 9] * Vin[j] + Iq8_
        Id8_ = LVparams[i] * x[j + 1] + LVparams[i + 9] * Vin[j + 1] + Id8_

        j = j + 2
        i = i + 1



    F[0] = Iqg1_ + Id1g * wsys * Wrated
    F[1] = Idg1_ - Iq1g * wsys * Wrated

    F[2] = Iq1_ + Id1 * wsys * Wrated
    F[3] = Id1_ - Iq1 * wsys * Wrated

    F[4] = Iq2_ + Id2 * wsys * Wrated
    F[5] = Id2_ - Iq2 * wsys * Wrated

    F[6] = Iq3_ + Id3 * wsys * Wrated
    F[7] = Id3_ - Iq3 * wsys * Wrated

    F[8] = Iq4_ + Id4 * wsys * Wrated
    F[9] = Id4_ - Iq4 * wsys * Wrated

    F[10] = Iq5_ + Id5 * wsys * Wrated
    F[11] = Id5_ - Iq5 * wsys * Wrated

    F[12] = Iq6_ + Id6 * wsys * Wrated
    F[13] = Id6_ - Iq6 * wsys * Wrated

    F[14] = Iq7_ + Id7 * wsys * Wrated
    F[15] = Id7_ - Iq7 * wsys * Wrated

    F[16] = Iq8_ + Id8 * wsys * Wrated
    F[17] = Id8_ - Iq8 * wsys * Wrated



    return F

