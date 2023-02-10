import math
import PUdefs as pu
import numpy as np
from numba import njit
from PUdefs import Wrated
@njit


def busmodel(GenIq, GenId, Iin, Iout):
    """

    :param x:
    :param wparams:
    :param sysparams:
    :param Isq_u1_12_load:
    :param Isd_u1_12_load:
    :param Isq_u1_13_load:
    :param Isd_u1_13_load:
    :param Isq:
    :param Isd:
    :return:
    """
    pi = math.pi



    Iinq = Iin[0]
    Iind = Iin[1]

    Ioutq = Iout[0]
    Ioutd = Iout[1]


    F = np.empty((2))

    # ---------------bus component-----------

    #----------convert to common reference frame----------

    # IsQ = (+Isq * np.cos(delta) - Isd * np.sin(delta))
    # IsD = (+Isq * np.sin(delta) + Isd * np.cos(delta))

    F[0] = ((GenIq + Iinq) - (Ioutq)) * 84033
    F[1] = ((GenId + Iind) - (Ioutd)) * 84033

    return F