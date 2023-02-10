import math
import PUdefs as pu
import numpy as np
from numba import njit


@njit
def unitmodel(x, sysparams, inputs, Ugq, Ugd, delta):
    """

    :param x:
    :param sysparams:
    :param Pref:
    :param Qref:
    :param Upcc:
    :param wref:
    :param Ugq:
    :param Ugd:
    :return:
    """
    pi = math.pi



    # ------------control params--------------------

    Wrated = sysparams[0]
    wc = sysparams[1]
    Kpi = sysparams[2]
    Kii = sysparams[3]
    Cfilt = sysparams[4]
    Lfilt = sysparams[5]
    Lgrid = sysparams[6]
    Rgrid = sysparams[7]
    Ltf = sysparams[8]
    Kp_pll = sysparams[9]
    Ki_pll = sysparams[10]
    Kp_p = sysparams[11]
    Ki_p = sysparams[12]
    Kp_q = sysparams[13]
    Ki_q = sysparams[14]
    KQ = sysparams[15]
    Tfpll = sysparams[16]
    Cdamp = sysparams[17]
    Ldamp = sysparams[18]
    Rdamp = sysparams[19]
    VratedLLrmsLV = sysparams[20]

    # ----input paramters
    Pref = inputs[0]
    Qref = inputs[1]
    wref = inputs[2]

    # base parameters

    VbaseLV = (VratedLLrmsLV * np.sqrt(2)) / (np.sqrt(3))
    ZbaseLV = (VratedLLrmsLV ** 2) / pu.MVAbase
    LbaseLV = ZbaseLV / pu.Wrated
    CbaseLV = 1 / (pu.Wrated * ZbaseLV)
    Wbase = pu.Wrated

    # -------per unitized values--------------

    Cf = Cfilt / CbaseLV
    Lf = Lfilt / LbaseLV
    Lg = (Lgrid / LbaseLV) + Ltf  # Line and Transformer impedance
    Rg = Rgrid / ZbaseLV
    w0 = Wrated / pu.Wbase

    # -------Filter per unitized values--------------

    Cd = Cdamp / CbaseLV
    Ld = Ldamp / LbaseLV
    Rd = Rdamp / ZbaseLV

    ##element order wint,P,Q,Phid,Phiq,Gamd,Gamq,Icd,Icq,Ufd,Ufq
    alpha = x[0]
    beta = x[1]
    Psi = x[2]
    Icd = x[3]
    Icq = x[4]
    Ufd = x[5]
    Ufq = x[6]
    Ufd_pll = x[7]
    Isd = x[8]
    Isq = x[9]               #-----------------change the dq order of these
    I1d = x[10]
    I1q = x[11]
    Uc2d = x[12]
    Uc2q = x[13]
    P = x[14]
    Q = x[15]
    Gamd = x[16]
    Gamq = x[17]


    wsys = wref + Ufd_pll * Kp_pll + Ki_pll * Psi

    # -------------------Equations-------------------

    F = np.empty((18))


    F[0] = (Q - Qref)
    F[1] = (Pref - P)

    F[2] = Ufd_pll

    F[3] = Wbase * ((1 / Lf) * (((Q - Qref) * Kp_q + (alpha * Ki_q) - Icd) * Kpi + Gamd * Kii + Ufd + Icq * w0 * Lf) - (Ufd / Lf) - wsys * Icq)
    F[4] = Wbase * ((1 / Lf) * (((Pref - P) * Kp_p + (beta * Ki_p) - Icq) * Kpi + Gamq * Kii + Ufq - Icd * w0 * Lf) - (Ufq / Lf) + wsys * Icd)

    F[5] = Wbase * (((Icd - Isd - I1d) / Cf) - wsys * Ufq)
    F[6] = Wbase * (((Icq - Isq - I1q) / Cf) + wsys * Ufd)

    F[7] = (1 / Tfpll) * (Ufd - Ufd_pll)

    UgQ = (+Ugq * np.cos(delta - 0.523599) + Ugd * np.sin(delta- 0.523599))                 # --------30 degree leading shift from the LV transformer is added to the delta---
    UgD = (-Ugq * np.sin(delta - 0.523599) + Ugd * np.cos(delta- 0.523599))

    F[8] = Wbase * (Ufd / Lg - (1 / Lg) * (UgD) - (Rg / Lg) * Isd - wsys * Isq)
    F[9] = Wbase * (Ufq / Lg - (1 / Lg) * (UgQ) - (Rg / Lg) * Isq + wsys * Isd)

    F[10] = Wbase * ((1 / (Rd * Cf)) * (Icd - Isd - I1d) - (I1d / (Rd * Cd)) + ((Ufd - Uc2d) / Ld) - wsys * I1q)
    F[11] = Wbase * ((1 / (Rd * Cf)) * (Icq - Isq - I1q) - (I1q / (Rd * Cd)) + ((Ufq - Uc2q) / Ld) + wsys * I1d)

    F[12] = Wbase * ((I1d / Cd) - wsys * Uc2q)
    F[13] = Wbase * ((I1q / Cd) + wsys * Uc2d)

    F[14] = -wc * P + wc * (Ufd * Icd + Ufq * Icq)
    F[15] = -wc * Q + wc * (Ufd * Icq - Ufq * Icd)

    F[16] = (Q - Qref) * Kp_q + (alpha * Ki_q) - Icd
    F[17] = (Pref - P) * Kp_p + (beta * Ki_p) - Icq

    return F
