from numba import njit
import numpy as np
from numpy import linalg as LA

import SourceDroopgfor as unit1
import Bus_mod_R as Bus
import Line_mod as Line
from PUdefs import Wrated

@njit#(cache = True)

def nlmodel(x, params, inputs):

    # ===Split the array of states based on individual function lengths=========================
    gen = x[0:68]
    angles = x[len(gen):(len(gen)+3)]
    lines = x[(len(angles)+len(gen)):((len(angles)+len(gen)) + 12)]
    # ==========generation units==============
    gen01 = gen[0:17]
    gen02 = gen[17:34]
    gen03 = gen[34:51]
    gen04 = gen[51:68]

    # =======reference angle components==============
    delta01 = angles[0:1]
    delta02 = angles[1:2]
    delta03 = angles[2:3]


    # ==============line section states===============
    line01_02 = lines[0:2]
    line02_03 = lines[2:4]
    line03_04 = lines[4:6]
    line04_05 = lines[6:8]

    line1ld = lines[8:10]
    line2ld = lines[10:12]

    #================================================================
    #================================================================
    #================================================================
    #================================================================

    #==============bus section states===============
    null = [0, 0]

    p_lines = params[0:12]
    p_gen = params[len(p_lines):len(p_lines)+72]
    # ====Specify the parameters for the individual functions========


    #==============line section states===============

    pline01_02 = p_lines[0:2]
    pline02_03 = p_lines[2:4]
    pline03_04 = p_lines[4:6]
    pline04_05 = p_lines[6:8]

    pline1ld = p_lines[8:10]
    pline2ld = p_lines[10:12]

    #==========generation units==============

    pgen01 = p_gen[0:18]
    pgen02 = p_gen[18:36]
    pgen03 = p_gen[36:54]
    pgen04 = p_gen[54:72]


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

    GenIQ01 = 0.02 * (+gen01[11])
    GenID01 = 0.02 * (+gen01[12])

    GenIQ02 = 0.02 * (+gen02[11] * np.cos(delta01) - gen02[12] * np.sin(delta01))
    GenID02 = 0.02 * (+gen02[11] * np.sin(delta01) + gen02[12] * np.cos(delta01))

    GenIQ03 = 0.02 * (+gen03[11] * np.cos(delta02) - gen03[12] * np.sin(delta02))
    GenID03 = 0.02 * (+gen03[11] * np.sin(delta02) + gen03[12] * np.cos(delta02))

    GenIQ04 = 0.02 * (+gen04[11] * np.cos(delta03) - gen04[12] * np.sin(delta03))
    GenID04 = 0.02 * (+gen04[11] * np.sin(delta03) + gen04[12] * np.cos(delta03))


    # ===========calculate bus voltages====================

    bus01 = Bus.busmodel((GenIQ01),(GenID01),null,(line01_02 + line1ld))
    bus02 = Bus.busmodel((GenIQ02[0]),(GenID02[0]),line01_02,line02_03)
    bus03 = Bus.busmodel(null[0], null[1], line02_03,(line03_04+line2ld))
    bus04 = Bus.busmodel((GenIQ03[0]),(GenID03[0]),line03_04,line04_05)
    bus05 = Bus.busmodel((GenIQ04[0]),(GenID04[0]),line04_05,null)
    # print(LA.norm(bus01),LA.norm(bus02),LA.norm(bus03),LA.norm(bus04),LA.norm(bus05))


    # ===========calling individual functions to construct the total system====================
    # =============================line functions========================
    solline01_02 = Line.linemodel(line01_02, wconv01, pline01_02, bus01, bus02)
    solline02_03 = Line.linemodel(line02_03, wconv01, pline02_03, bus02, bus03)
    solline03_04 = Line.linemodel(line03_04, wconv01, pline03_04, bus03, bus04)
    solline04_05 = Line.linemodel(line04_05, wconv01, pline04_05, bus04, bus05)

    sol1ld = Line.linemodel(line1ld, wconv01, pline1ld, bus01, null)
    sol2ld = Line.linemodel(line2ld, wconv01, pline2ld, bus03, null)

    # ============================= bus functions========================


    # =============================generator functions========================

    solu01 = unit1.unitmodel(gen01, pgen01, inputs01, bus01[0], bus01[1], 0)
    solu02 = unit1.unitmodel(gen02, pgen02, inputs02, bus02[0], bus02[1], delta01[0])

    solu03 = unit1.unitmodel(gen03, pgen03, inputs03, bus04[0], bus04[1], delta02[0])
    solu04 = unit1.unitmodel(gen04, pgen04, inputs04, bus05[0], bus05[1], delta03[0])

    #======Function for reference angle generation

    #----------state equations for calculating reference angle states------
    delta = np.empty((3))             # array parameter is just Wrated, in most cases 376.99 nothing to do with other parameters

    delta[0] = Wrated * (wconv02 - wconv01)
    delta[1] = Wrated * (wconv03 - wconv01)
    delta[2] = Wrated * (wconv04 - wconv01)

    # concatenate the calculated states from individual models

    gensols = np.concatenate((solu01, solu02, solu03, solu04))

    linesols = np.concatenate((solline01_02, solline02_03, solline03_04, solline04_05, sol1ld, sol2ld))
    sols = np.concatenate((gensols, delta, linesols))

    return sols
