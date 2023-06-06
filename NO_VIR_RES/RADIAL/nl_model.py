from numba import njit
import numpy as np

import SourceDroopgfor as unit1
import LV_Linemod as LVsys
from PUdefs import Wrated, PU_Scaler

@njit#(cache = True)

def nlmodel(x, params, inputs):

    # ===Split the array of states based on individual function lengths=========================
    gen = x[0:60]
    angles = x[len(gen):(len(gen) + 3)]
    lines = x[(len(angles)+len(gen)):((len(angles)+len(gen)) + 10)]
    # ==========generation units==============
    gen01 = gen[0:15]
    gen02 = gen[15:30]
    gen03 = gen[30:45]
    gen04 = gen[45:60]
    # =======reference angle components==============
    delta01 = angles[0:1]
    delta02 = angles[1:2]
    delta03 = angles[2:3]
    # ==============line section states===============
    LVline = lines[0:10]
    #================================================================
    #================================================================
    #================================================================
    #================================================================

    #==============bus section states===============
    null = [0, 0]
    p_gen = params[0:72]
    p_LVparams = params[len(p_gen):len(p_gen) + 55]
    # ====Specify the parameters for the individual functions========
    #==========generation units==============

    pgen01 = p_gen[0:18]
    pgen02 = p_gen[18:36]
    pgen03 = p_gen[36:54]
    pgen04 = p_gen[54:72]

    # print(bus00)
    #===========inputs=============
    inputs01 = inputs[0:4]
    inputs02 = inputs[4:8]
    inputs03 = inputs[8:12]
    inputs04 = inputs[12:16]

    # ======calculate frequency related parameters needed for decoupled components in modular sections

    # ........wconv generates the individual frequency component of each converter
    # ........wconv_ss generates the linearized coefficents of the frequency parameter to be used in linearized models
    wconv01 = inputs01[3] + pgen01[3] * gen01[0]
    wconv02 = inputs02[3] + pgen02[3] * gen02[0]
    wconv03 = inputs03[3] + pgen03[3] * gen03[0]
    wconv04 = inputs04[3] + pgen04[3] * gen04[0]
    # print(wconv01)

    # ===========Reference frame Transformed currents from generating sources====================

    #=====unit 1(Reference)===

    GenVQ01 = (+gen01[9])
    GenVD01 = (+gen01[10])

    GenVQ02 = (+gen02[9] * np.cos(delta01) - gen02[10] * np.sin(delta01))
    GenVD02 = (+gen02[9] * np.sin(delta01) + gen02[10] * np.cos(delta01))

    GenVQ03 = (+gen03[9] * np.cos(delta02) - gen03[10] * np.sin(delta02))
    GenVD03 = (+gen03[9] * np.sin(delta02) + gen03[10] * np.cos(delta02))

    GenVQ04 = (+gen04[9] * np.cos(delta03) - gen04[10] * np.sin(delta03))
    GenVD04 = (+gen04[9] * np.sin(delta03) + gen04[10] * np.cos(delta03))



    GenV = [null[0],null[0],GenVQ01,GenVD01,GenVQ02[0],GenVD02[0],null[0],null[0],GenVQ03[0],GenVD03[0],GenVQ04[0],GenVD04[0]]

    # print(wconv01)


    # ===========calling individual functions to construct the total system====================
    # =============================LS system functions========================
    solLVsys = LVsys.LV_curr(LVline, GenV, wconv01, p_LVparams)

    # ============================= bus functions========================


    # =============================generator functions========================

    solu01 = unit1.unitmodel(gen01, pgen01, inputs01, PU_Scaler * LVline[0], PU_Scaler * LVline[1], 0)
    solu02 = unit1.unitmodel(gen02, pgen02, inputs02, PU_Scaler * LVline[2], PU_Scaler * LVline[3], delta01[0])
    solu03 = unit1.unitmodel(gen03, pgen03, inputs03, PU_Scaler * LVline[6], PU_Scaler * LVline[7], delta02[0])
    solu04 = unit1.unitmodel(gen04, pgen04, inputs04, PU_Scaler * LVline[8], PU_Scaler * LVline[9], delta03[0])

    #======Function for reference angle generation

    #----------state equations for calculating reference angle states------
    delta = np.empty((3))             # array parameter is just Wrated, in most cases 376.99 nothing to do with other parameters

    delta[0] = Wrated * (wconv02 - wconv01)
    delta[1] = Wrated * (wconv03 - wconv01)
    delta[2] = Wrated * (wconv04 - wconv01)

    # concatenate the calculated states from individual models

    gensols = np.concatenate((solu01, solu02, solu03, solu04))

    sols = np.concatenate((gensols, delta, solLVsys))

    return sols
