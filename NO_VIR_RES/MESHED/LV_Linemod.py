import math
import PUdefs as pu
import numpy as np
from numba import njit
from PUdefs import Wrated
from param_arr import *

@njit
def LV_curr(x, Vin, wsys, LVparams):

    #------- Currents-------


    Iq1 = x[0]
    Id1 = x[1]

    Iq2 = x[2]
    Id2 = x[3]

    Iq3 = x[4]
    Id3 = x[5]

    Iq4 = x[6]
    Id4 = x[7]

    Iq5 = x[8]
    Id5 = x[9]

    Iq15 = x[10]
    Id15 = x[11]

    Iq42 = x[12]
    Id42 = x[13]


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



    F = np.empty((14))

    Iq1_  = 0
    Iq2_  = 0
    Iq3_  = 0
    Iq4_  = 0
    Iq5_  = 0
    Iq15_ = 0
    Iq42_ = 0


    Id1_  = 0
    Id2_  = 0
    Id3_  = 0
    Id4_  = 0
    Id5_  = 0
    Id15_ = 0
    Id42_ = 0

    Iq1_ = -210.981359170437 * Iq1 - 7.15052208569539e-14 * Iq15 - 131.295088476962 * Iq2 - 10.1049412857869 * Iq3 - 129.093200898018 * Iq4 - 1.44739422690487e-14 * Iq42 - 132.115526167565 * Iq5 + 49.8228542456468 * Vqc1 - 14.51658816153 * Vqc2 - 3.01654679355477 * Vqc3 - 14.027978705608 * Vqc4 - 14.6986472355068 * Vqc5 - 3.56309334944727 * Vqg
    Iq2_ = -122.691626115322 * Iq1 - 1.81527704243268e-14 * Iq15 - 201.605527244263 * Iq2 + 4.2344963002601 * Iq3 - 124.664814072831 * Iq4 - 2.80939863048913e-14 * Iq42 - 120.808278882923 * Iq5 - 14.51658816153 * Vqc1 + 49.9942467709994 * Vqc2 - 3.32678882415374 * Vqc3 - 14.9544480702601 * Vqc4 - 14.0986643422874 * Vqc5 - 3.09775737276813 * Vqg
    Iq3_ = -25.4953179931769 * Iq1 + 3.33353789545842e-15 * Iq15 - 26.893404062455 * Iq2 - 628.461153796271 * Iq3 - 26.9159176190506 * Iq4 + 3.40115206729148e-16 * Iq42 - 25.5874061488913 * Iq5 - 3.01654679355477 * Vqc1 - 3.32678882415374 * Vqc2 + 13.3558158409356 * Vqc3 - 3.33178469076575 * Vqc4 - 3.03698159871502 * Vqc5 - 0.643713933746362 * Vqg
    Iq4_ = -118.561985733206 * Iq1 + 2.82220117195666e-14 * Iq15 - 122.737061269658 * Iq2 + 6.25461623710441 * Iq3 - 199.890812648564 * Iq4 + 3.88752322173344e-14 * Iq42 - 121.316732184102 * Iq5 - 14.027978705608 * Vqc1 - 14.9544480702601 * Vqc2 - 3.33178469076574 * Vqc3 + 49.9469725669757 * Vqc4 - 14.6392702072482 * Vqc5 - 2.99349089309364 * Vqg
    Iq5_ = -124.230357088931 * Iq1 + 7.33612492205021e-14 * Iq15 - 121.526572165929 * Iq2 - 1.84195900148109 * Iq3 - 123.96277827028 * Iq4 + 6.44123813167235e-15 * Iq42 - 204.054633097596 * Iq5 - 14.6986472355068 * Vqc1 - 14.0986643422874 * Vqc2 - 3.03698159871501 * Vqc3 - 14.6392702072482 * Vqc4 + 49.6101711277295 * Vqc5 - 3.13660774397211 * Vqg
    Iq15_ = 186.973539608727 * Iq1 - 369.627894531251 * Iq15 + 108.127672551311 * Iq2 + 91.4629217259523 * Iq3 + 56.7886299493951 * Iq4 + 1.46427976008078e-13 * Iq42 - 23.0207244822313 * Iq5 + 22.1222748246274 * Vqc1 + 4.62599727938332 * Vqc2 - 0.226192786157501 * Vqc3 - 6.76638347300454 * Vqc4 - 24.4764635058066 * Vqc5 + 4.72076766095755 * Vqg
    Iq42_ = -45.7109748066509 * Iq1 - 3.90088760155194e-13 * Iq15 - 99.7217752769877 * Iq2 - 22.3607004472756 * Iq3 + 59.4033165015314 * Iq4 - 369.627894531249 * Iq42 + 5.62806779526441 * Iq5 - 5.4084163421765 * Vqc1 - 17.3936730301607 * Vqc2 + 0.055299229886359 * Vqc3 + 17.9169510275601 * Vqc4 + 5.98396441021146 * Vqc5 - 1.15412529532084 * Vqg

    Id1_ = -210.981359170437 * Id1 - 7.15052208569539e-14 * Id15 - 131.295088476962 * Id2 - 10.1049412857869 * Id3 - 129.093200898018 * Id4 - 1.44739422690487e-14 * Id42 - 132.115526167565 * Id5 + 49.8228542456468 * Vdc1 - 14.51658816153 * Vdc2 - 3.01654679355477 * Vdc3 - 14.027978705608 * Vdc4 - 14.6986472355068 * Vdc5 - 3.56309334944727 * Vdg
    Id2_ = -122.691626115322 * Id1 - 1.81527704243268e-14 * Id15 - 201.605527244263 * Id2 + 4.2344963002601 * Id3 - 124.664814072831 * Id4 - 2.80939863048913e-14 * Id42 - 120.808278882923 * Id5 - 14.51658816153 * Vdc1 + 49.9942467709994 * Vdc2 - 3.32678882415374 * Vdc3 - 14.9544480702601 * Vdc4 - 14.0986643422874 * Vdc5 - 3.09775737276813 * Vdg
    Id3_ = -25.4953179931769 * Id1 + 3.33353789545842e-15 * Id15 - 26.893404062455 * Id2 - 628.461153796271 * Id3 - 26.9159176190506 * Id4 + 3.40115206729148e-16 * Id42 - 25.5874061488913 * Id5 - 3.01654679355477 * Vdc1 - 3.32678882415374 * Vdc2 + 13.3558158409356 * Vdc3 - 3.33178469076575 * Vdc4 - 3.03698159871502 * Vdc5 - 0.643713933746362 * Vdg
    Id4_ = -118.561985733206 * Id1 + 2.82220117195666e-14 * Id15 - 122.737061269658 * Id2 + 6.25461623710441 * Id3 - 199.890812648564 * Id4 + 3.88752322173344e-14 * Id42 - 121.316732184102 * Id5 - 14.027978705608 * Vdc1 - 14.9544480702601 * Vdc2 - 3.33178469076574 * Vdc3 + 49.9469725669757 * Vdc4 - 14.6392702072482 * Vdc5 - 2.99349089309364 * Vdg
    Id5_ = -124.230357088931 * Id1 + 7.33612492205021e-14 * Id15 - 121.526572165929 * Id2 - 1.84195900148109 * Id3 - 123.96277827028 * Id4 + 6.44123813167235e-15 * Id42 - 204.054633097596 * Id5 - 14.6986472355068 * Vdc1 - 14.0986643422874 * Vdc2 - 3.03698159871501 * Vdc3 - 14.6392702072482 * Vdc4 + 49.6101711277295 * Vdc5 - 3.13660774397211 * Vdg
    Id15_ = 186.973539608727 * Id1 - 369.627894531251 * Id15 + 108.127672551311 * Id2 + 91.4629217259523 * Id3 + 56.7886299493951 * Id4 + 1.46427976008078e-13 * Id42 - 23.0207244822313 * Id5 + 22.1222748246274 * Vdc1 + 4.62599727938332 * Vdc2 - 0.226192786157501 * Vdc3 - 6.76638347300454 * Vdc4 - 24.4764635058066 * Vdc5 + 4.72076766095755 * Vdg
    Id42_ = -45.7109748066509 * Id1 - 3.90088760155194e-13 * Id15 - 99.7217752769877 * Id2 - 22.3607004472756 * Id3 + 59.4033165015314 * Id4 - 369.627894531249 * Id42 + 5.62806779526441 * Id5 - 5.4084163421765 * Vdc1 - 17.3936730301607 * Vdc2 + 0.055299229886359 * Vdc3 + 17.9169510275601 * Vdc4 + 5.98396441021146 * Vdc5 - 1.15412529532084 * Vdg

    F[0] = Iq1_ + Id1 * wsys * Wrated
    F[1] = Id1_ - Iq1 * wsys * Wrated

    F[2] = Iq2_ + Id2 * wsys * Wrated
    F[3] = Id2_ - Iq2 * wsys * Wrated

    F[4] = Iq3_ + Id3 * wsys * Wrated
    F[5] = Id3_ - Iq3 * wsys * Wrated

    F[6] = Iq4_ + Id4 * wsys * Wrated
    F[7] = Id4_ - Iq4 * wsys * Wrated

    F[8] = Iq5_ + Id5 * wsys * Wrated
    F[9] = Id5_ - Iq5 * wsys * Wrated

    F[10] = Iq15_ + Id15 * wsys * Wrated
    F[11] = Id15_ - Iq15 * wsys * Wrated

    F[12] = Iq42_ + Id42 * wsys * Wrated
    F[13] = Id42_ - Iq42 * wsys * Wrated

    return F

