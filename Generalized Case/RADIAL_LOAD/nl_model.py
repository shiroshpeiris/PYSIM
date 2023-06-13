from numba import njit
import numpy as np

import SourceDroopgfor as unit1
import LV_Linemod as LVsys
from PUdefs import Wrated, PU_Scaler

@njit#(cache = True)

def nlmodel(x, params, inputs):

    # ===Split the array of states based on individual function lengths=========================
    gen = x[0:120]
    angles = x[len(gen):(len(gen) + 7)]
    lines = x[(len(angles)+len(gen)):((len(angles)+len(gen)) + 18)]
    # ==========generation units==============
    gen01 = gen[0:15]
    gen02 = gen[15:30]
    gen03 = gen[30:45]
    gen04 = gen[45:60]
    gen05 = gen[60:75]
    gen06 = gen[75:90]
    gen07 = gen[90:105]
    gen08 = gen[105:120]




    # =======reference angle components==============
    delta01 = angles[0:1]
    delta02 = angles[1:2]
    delta03 = angles[2:3]
    delta04 = angles[3:4]
    delta05 = angles[4:5]
    delta06 = angles[5:6]
    delta07 = angles[6:7]
    # delta08 = angles[7:8]
    # ==============line section states===============
    LVline = lines[0:18]
    #================================================================
    #================================================================
    #================================================================
    #================================================================

    #==============bus section states===============
    null = [0, 0]
    p_gen = params[0:144]
    p_LVparams = params[len(p_gen):len(p_gen) + 162]
    p_grid = params[len(p_gen) + len(p_LVparams):len(p_gen) + len(p_LVparams) + 3]
    time = params[309]
    # if time > 0 and time < 1.01:
    #     gen08[9] = 0
    #     gen08[10] = 0
    # ====Specify the parameters for the individual functions========
    #==========generation units==============

    pgen01 = p_gen[0:18]
    pgen02 = p_gen[18:36]
    pgen03 = p_gen[36:54]
    pgen04 = p_gen[54:72]
    pgen05 = p_gen[72:90]
    pgen06 = p_gen[90:108]
    pgen07 = p_gen[108:126]
    pgen08 = p_gen[126:144]



    bus00 = p_grid[0:2]
    wgrid = p_grid[2]

    #===========inputs=============
    inputs01 = inputs[0:4]
    inputs02 = inputs[4:8]
    inputs03 = inputs[8:12]
    inputs04 = inputs[12:16]
    inputs05 = inputs[16:20]
    inputs06 = inputs[20:24]
    inputs07 = inputs[24:28]
    inputs08 = inputs[28:32]
    # ======calculate frequency related parameters needed for decoupled components in modular sections

    # ........wconv generates the individual frequency component of each converter
    # ........wconv_ss generates the linearized coefficents of the frequency parameter to be used in linearized models

    wconv01 = inputs01[3] + pgen01[3] * gen01[0]
    wconv02 = inputs02[3] + pgen02[3] * gen02[0]
    wconv03 = inputs03[3] + pgen03[3] * gen03[0]
    wconv04 = inputs04[3] + pgen04[3] * gen04[0]
    wconv05 = inputs05[3] + pgen05[3] * gen05[0]
    wconv06 = inputs06[3] + pgen06[3] * gen06[0]
    wconv07 = inputs07[3] + pgen07[3] * gen07[0]
    wconv08 = inputs08[3] + pgen08[3] * gen08[0]


    # ===========Reference frame Transformed currents from generating sources====================
    #=====unit 1(Reference)===

    GenVQ01 = (+gen01[9] * np.cos(delta01) - gen01[10] * np.sin(delta01))
    GenVD01 = (+gen01[9] * np.sin(delta01) + gen01[10] * np.cos(delta01))

    GenVQ02 = (+gen02[9] * np.cos(delta02) - gen02[10] * np.sin(delta02))
    GenVD02 = (+gen02[9] * np.sin(delta02) + gen02[10] * np.cos(delta02))

    GenVQ03 = (+gen03[9] * np.cos(delta03) - gen03[10] * np.sin(delta03))
    GenVD03 = (+gen03[9] * np.sin(delta03) + gen03[10] * np.cos(delta03))

    GenVQ04 = (+gen04[9] * np.cos(delta04) - gen04[10] * np.sin(delta04))
    GenVD04 = (+gen04[9] * np.sin(delta04) + gen04[10] * np.cos(delta04))

    GenVQ05 = (+gen05[9] * np.cos(delta05) - gen05[10] * np.sin(delta05))
    GenVD05 = (+gen05[9] * np.sin(delta05) + gen05[10] * np.cos(delta05))

    GenVQ06 = (+gen06[9] * np.cos(delta06) - gen06[10] * np.sin(delta06))
    GenVD06 = (+gen06[9] * np.sin(delta06) + gen06[10] * np.cos(delta06))

    GenVQ07 = (+gen07[9] * np.cos(delta07) - gen07[10] * np.sin(delta07))
    GenVD07 = (+gen07[9] * np.sin(delta07) + gen07[10] * np.cos(delta07))

    GenVQ08 = (+gen08[9])
    GenVD08 = (+gen08[10])


    GenV = [bus00[1], bus00[1],GenVQ01[0],GenVD01[0],GenVQ02[0],GenVD02[0],GenVQ03[0],GenVD03[0],GenVQ04[0],GenVD04[0],GenVQ05[0],GenVD05[0],GenVQ06[0],GenVD06[0],GenVQ07[0],GenVD07[0],GenVQ08,GenVD08]

    # print(LVline[16],LVline[17])

    # ===========calling individual functions to construct the total system====================
    # =============================LS system functions========================
    solLVsys = LVsys.LV_curr(LVline, GenV, wgrid, p_LVparams)
    # =============================generator functions========================
    solu01 = unit1.unitmodel(gen01, pgen01, inputs01, PU_Scaler * LVline[2], PU_Scaler * LVline[3], delta01[0])
    solu02 = unit1.unitmodel(gen02, pgen02, inputs02, PU_Scaler * LVline[4], PU_Scaler * LVline[5], delta02[0])
    solu03 = unit1.unitmodel(gen03, pgen03, inputs03, PU_Scaler * LVline[6], PU_Scaler * LVline[7], delta03[0])
    solu04 = unit1.unitmodel(gen04, pgen04, inputs04, PU_Scaler * LVline[8], PU_Scaler * LVline[9], delta04[0])
    solu05 = unit1.unitmodel(gen05, pgen05, inputs05, PU_Scaler * LVline[10], PU_Scaler * LVline[11], delta05[0])
    solu06 = unit1.unitmodel(gen06, pgen06, inputs06, PU_Scaler * LVline[12], PU_Scaler * LVline[13], delta06[0])
    solu07 = unit1.unitmodel(gen07, pgen07, inputs07, PU_Scaler * LVline[14], PU_Scaler * LVline[15], delta07[0])
    solu08 = unit1.unitmodel(gen08, pgen08, inputs08, PU_Scaler * LVline[16], PU_Scaler * LVline[17], 0)
    #======Function for reference angle generation

    #----------state equations for calculating reference angle states------
    delta = np.empty((7))             # array parameter is just Wrated, in most cases 376.99 nothing to do with other parameters

    delta[0] = Wrated * (wconv01 - wconv08)
    delta[1] = Wrated * (wconv02 - wconv08)
    delta[2] = Wrated * (wconv03 - wconv08)
    delta[3] = Wrated * (wconv04 - wconv08)
    delta[4] = Wrated * (wconv05 - wconv08)
    delta[5] = Wrated * (wconv06 - wconv08)
    delta[6] = Wrated * (wconv07 - wconv08)
    # concatenate the calculated states from individual models

    gensols = np.concatenate((solu01, solu02, solu03, solu04, solu05, solu06, solu07, solu08))
    sols = np.concatenate((gensols, delta, solLVsys))

    return sols
