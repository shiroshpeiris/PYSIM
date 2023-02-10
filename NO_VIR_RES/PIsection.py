import math
import PUdefs as pu
import numpy as np
from numba import njit

@njit


def pimodel(x, wsys, sysparams, U_u1_12_out_q, U_u1_12_out_d, I_u1_13_l_q, I_u1_13_l_d, Isq, Isd, delta):
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
    Wrated = sysparams[0]
    R_u1_12 = sysparams[1]
    wL_u1_12 = sysparams[2]
    wC_u1_12 = sysparams[3]
    wC_u1_13 = sysparams[4]


    # base parameters


    CbaseHV = pu.CbaseHV
    LbaseHV = pu.LbaseHV
    ZbaseHV = pu.ZbaseHV

    Wbase = pu.Wbase

    # -------per unitized values--------------

    w0 = Wrated / Wbase

    Rpi_u1_12 = R_u1_12 / ZbaseHV
    Lpi_u1_12 = (wL_u1_12 / Wbase) / LbaseHV
    Cpi_u1_12 = (wC_u1_12 / Wbase) / CbaseHV
    Cpi_u1_13 = (wC_u1_13 / Wbase) / CbaseHV


    ##element order delta,wint,P,Q,Phid,Phiq,Gamd,Gamq,Icd,Icq,Ufd,Ufq

    # ---unit side states--

    U_u1_cmn_in_q = x[0]
    U_u1_cmn_in_d = x[1]

    # ---line 12 states--


    I_u1_12_l_q = x[2]
    I_u1_12_l_d = x[3]


    # -------------------Equations-------------------

    F = np.empty((4))

    # ---------------PI section base component-----------

    #----------convert to common reference frame----------

    IsQ = (+Isq * np.cos(delta) - Isd * np.sin(delta))
    IsD = (+Isq * np.sin(delta) + Isd * np.cos(delta))

    # IsQ = (+Isq * np.cos(delta) + Isd * np.sin(delta))
    # IsD = (-Isq * np.sin(delta) + Isd * np.cos(delta))
    # ---------------PI section 12-----------

    F[0] = Wbase * (((2 / (Cpi_u1_12 + Cpi_u1_13)) * (IsQ + I_u1_13_l_q - I_u1_12_l_q)) + (wsys) * U_u1_cmn_in_d)
    F[1] = Wbase * (((2 / (Cpi_u1_12 + Cpi_u1_13)) * (IsD + I_u1_13_l_d - I_u1_12_l_d)) - (wsys) * U_u1_cmn_in_q)

    F[2] = Wbase * (((1 / Lpi_u1_12) * ((U_u1_cmn_in_q - U_u1_12_out_q) - (Rpi_u1_12) * I_u1_12_l_q)) + (wsys) * I_u1_12_l_d)
    F[3] = Wbase * (((1 / Lpi_u1_12) * ((U_u1_cmn_in_d - U_u1_12_out_d) - (Rpi_u1_12) * I_u1_12_l_d)) - (wsys) * I_u1_12_l_q)


    return F
