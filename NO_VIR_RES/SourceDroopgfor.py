import math
from PUdefs import *
import numpy as np
from numba import njit


@njit
def unitmodel(x, sysparams, inputs, IsQ, IsD, delta):
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

    # base parameters

    MVAbase = MVAbaseLV

    # ------------control params--------------------

    Wrated = sysparams[0]
    H = sysparams[1]
    wc = sysparams[2]
    Kp = sysparams[3]
    Kq = sysparams[4]
    Kd = sysparams[5]
    Kpi = sysparams[6]
    Kpv = sysparams[7]
    Kiv = sysparams[8]
    Kii = sysparams[9]
    Cfilt = sysparams[10]
    Lfilt = sysparams[11]
    Lgrid = sysparams[12]
    Rgrid = sysparams[13]
    Ltf = sysparams[14]
    Cdamp = sysparams[15]
    Ldamp = sysparams[16]
    Rdamp = sysparams[17]

    #-----input parameters

    Pref = inputs[0]
    Qref = inputs[1]
    Upcc = inputs[2]
    wref = inputs[3]

    # base parameters

    VbaseLV = (VratedLLrmsLV * np.sqrt(2)) / (np.sqrt(3))
    ZbaseLV = (VratedLLrmsLV ** 2) / MVAbase
    LbaseLV = ZbaseLV / Wrated
    CbaseLV = 1 / (Wrated * ZbaseLV)
    Wbase = Wrated

    # -------Filter per unitized values--------------

    Cf = Cfilt / CbaseLV
    Lf = Lfilt / LbaseLV

    Cd = Cdamp / CbaseLV
    Ld = Ldamp / LbaseLV
    Rd = Rdamp / ZbaseLV

    # --LV line per unitized values

    Lg = (Lgrid / LbaseLV) + Ltf  # Line and Transformer impedance
    Rg = Rgrid / ZbaseLV
    w0 = Wrated / Wbase

    # -------Nonlinear equations-------------------

    wint = x[0]
    P = x[1]
    Q = x[2]
    Phiq = x[3]
    Phid = x[4]
    Gamq = x[5]
    Gamd = x[6]
    Icq = x[7]
    Icd = x[8]
    Ufq = x[9]
    Ufd = x[10]
    I1q = x[11]
    I1d = x[12]
    Uc2q = x[13]
    Uc2d = x[14]

    # -------------------Equations-------------------
    # -------------------Equations-------------------

    F = np.empty((15))
    wsys = Kp * wint + wref

    # -!!! All decoupled equations should be multiplied by Wbase when per
    # unitization

    # -----------Frequency control---------
    Isq = (+IsQ * np.cos(delta) + IsD * np.sin(delta))
    Isd = (-IsQ * np.sin(delta) + IsD * np.cos(delta))

    F[0] = -(Kd / (2 * H)) * wint + (Pref / (2 * H)) - (P / (2 * H))

    # --------Power Measurements---------

    F[1] = -wc * P + wc * (Ufq * Icq + Ufd * Icd)
    F[2] = -wc * Q + wc * (Ufd * Icq - Ufq * Icd)

    # ------Control Equations--------
    F[3] = Upcc + Kq * Qref - Kq * Q - Ufq
    F[4] = -Ufd
    F[5] = (Upcc + Kq * Qref - Kq * Q - Ufq) * Kpv + Phiq * Kiv + Isq - Ufd * w0 * Cf - Icq
    F[6] = -Ufd * Kpv + Phid * Kiv + Isd + Ufq * w0 * Cf - Icd

    # ------Filter Current--------
    F[7] = Wbase * ((1 / Lf) * (((Upcc + Kq * Qref - Kq * Q - Ufq) * Kpv + Phiq * Kiv + Isq - Ufd * w0 * Cf - Icq) * Kpi + Gamq * Kii + Ufq - Icd * w0 * Lf) - (Ufq / Lf) + wsys * Icd)
    F[8] = Wbase * ((1 / Lf) * (((-Ufd) * Kpv + Phid * Kiv + Isd + Ufq * w0 * Cf - Icd) * Kpi + Gamd * Kii + Ufd + Icq * w0 * Lf) - (Ufd / Lf) - wsys * Icq)

    # ------------Grid current and Filter voltages------

    F[9] = Wbase * ((Icq - Isq - I1q) / Cf + wsys * Ufd)
    F[10] = Wbase * ((Icd - Isd - I1d) / Cf - wsys * Ufq)

    #-------convert from common reference frame

    F[11] = Wbase * ((1 / (Rd * Cf)) * (Icq - Isq - I1q) - (I1q / (Rd * Cd)) + ((Ufq - Uc2q) / Ld) + wsys * I1d)
    F[12] = Wbase * ((1 / (Rd * Cf)) * (Icd - Isd - I1d) - (I1d / (Rd * Cd)) + ((Ufd - Uc2d) / Ld) - wsys * I1q)

    F[13] = Wbase * ((I1q / Cd) + wsys * Uc2d)
    F[14] = Wbase * ((I1d / Cd) - wsys * Uc2q)

    return F