#------------------import libraries-------------------------
from threading import Thread
import math
from numpy import genfromtxt

from numpy.linalg import inv

import pyqtgraph as pg
from params import *
from pfcalc import *
from eigplot import *
from scipy.optimize import fsolve

import control.matlab as ctl
from control import ss
import csv

import PySimpleGUI as sg
import pandas as pd

from nl_model import *

pertb_inp=4
sim_length = 20000


#-------------------------- control params------------------------------------------
gridparams = np.array([Ugrid_Q, Ugrid_D, wsys], dtype=float)

unit1sysparms = np.array([Wrated, wc2, Kpi, Kii, Cfilt1, Lfilt1, Lgrid1LV, Rgrid1LV, Xtf1, Kp_pll, Ki_pll, Kp_p, Ki_p, Kp_q, Ki_q, KQ, Tfpll, Cdamp, Ldamp, Rdamp, VratedLLrmsLV1], dtype=float)


inputs_u1 = np.array([Pref1, Qref1, wref1], dtype=float)

params = np.concatenate((gridparams,unit1sysparms))
inputs = inputs_u1

gridparams_label = (['Ugrid_Q', 'Ugrid_D', 'wsys'])


unit1sysparms_label = (['Wrated','wc1','Kpi','Kii','Cfilt1','Lfilt1','Lgrid1LV','Rgrid1LV','Xtf1','Kp_pll','Ki_pll','Kp_p','Ki_p','Kp_q','Ki_q','KQ','Tfpll','Cdamp','Ldamp','Rdamp','VratedLLrmsLV1'])


inputs_u1_label = np.array(['Pref1', 'Qref1', 'wref1'])


#-----------------------initialize global variables--------------------------

#-----sim parameter variables----------
varobs_y = 30
varobs_x = 0
windowlen = 5000
delta_t = 1e-6
plotstep = 1


#--------conditional variables--------------
showeigs = 0
changevarobs = 0
showpf = 0
recsnapshot = 0
plotderivs = 0
plottimeasx = 1
initsim = 0

def readfile():

    path = 'C:\\Users\\speiris\\OneDrive - University of Manitoba\\Research\\9 bus system\\Gfol_Infbus.if18\\Rank_00001\\Run_00001\\playback.tmp'
    FO=open(path, 'r')
    while True:
        loglines=FO.readline()
        if loglines.find(' ') >=0:

            loglines = loglines.strip()
            global data
            data = loglines.split(' ')





def controlgui():

    def paramset_gui(params,params_labels,parsetno):

    # Define the window's contents
        layout = []
        for j in range(len(params)):
            column = []
            for i in range(2):
                column.append(0)
            layout.append(column)
        layout[1][0] = 1

        # layout = [  [sg.Text("What's your name?")],     # Part 2 - The Layout
        #             [sg.Input()],
        #             [sg.Button('Ok')] ]
        # print(layout)

        j = 0
        while j < len(params):
            layout[j][0] = sg.Text(params_labels[j])
            layout[j][1] = sg.Input(params[j], size = (10,1))
            j = j + 1
            if j == (len(params)):
                buttonadd = layout[1]
                buttonadd.append(sg.Button('Update Values'))
                buttonadd.append(sg.Button('Quit'))

        # Create the window
        window = sg.Window('Parameters', layout)

        # Display and interact with the Window using an Event Loop
        while True:
            event, values = window.read()
            s = pd.Series(values)
            values = s.values
            setparams(values.astype(float),parsetno)
            # See if user wants to quit or window was closed
            if event == sg.WINDOW_CLOSED or event == 'Quit':
                break
        # Finish up by removing from the screen
        window.close()


    def setparams(parvalues, parsetno):
        global params
        global gridparams, unit1sysparms, inputs_u1
        if parsetno == 1:
            gridparams = params[0:3] = parvalues
        if parsetno == 7:
            unit1sysparms = params[3:24] = parvalues
        if parsetno == 10:
            inputs_u1 = inputs[0:3] = parvalues

    def recsnapshot():
        global recsnapshot
        recsnapshot = 1

    def changevarobs(varsel,varobsx,varobsy):
        global changevarobs
        global varobs_y
        global varobs_x
        global plottimeasx
        changevarobs = 1
        if varsel == True:
            plottimeasx = 1
            varobs_y = int(varobsy)
        elif varsel == False:
            plottimeasx = 0
            varobs_y = int(varobsy)
            varobs_x = int(varobsx)

    # def disable_input_varobsobsx():
    #     if plotvarx_sel.get() == 1:
    #         E9.config(state = 'disabled')
    #     elif plotvarx_sel.get() == 2:
    #         E9.config(state = 'normal')


    def showeigs(var):
        global showeigs
        if var == True:
            showeigs = 1
        elif var == False:
            showeigs = 0

    def plotderivs(var):
        global plotderivs
        if var == True:
            plotderivs = 1
        elif var == False:
            plotderivs = 0

    def genpf():
        global showpf
        showpf = 1
    def reinit():
        global initsim
        initsim = 1


    def setwindowlen(var):
        global windowlen
        windowlen = int(var)

    def setdt(var):
        global delta_t
        delta_t = float(var)

    def setpltwndw(var):
        global plotstep
        plotstep = int(var)


    def main_gui():


        layout = [  [sg.Text("Plotting Variables", text_color= "Blue")],     # Part 2 - The Layout
                    [sg.Text("Y axis Plotting Variable"), sg.Input(varobs_y, size = (10,1))],
                    [sg.Text("X axis Plotting Variable")],
                    [sg.Radio("Time", "RADIO1", default=True, change_submits = True,  key = "seltime")],
                    [sg.Radio("State Variable", "RADIO1",default=False, change_submits = True, key = "selstatevar"), sg.Input(0, size = (10,1))],
                    [sg.Button('Clear and Plot')],
                    [sg.Text("Simulation parameters", text_color= "Blue")],
                    [sg.Text("Plot window length"), sg.Input(windowlen, size = (10,1)), sg.Button('Update Window size')],
                    [sg.Text("Simulation timestep"), sg.Input(delta_t, size = (10,1)), sg.Button('Update Timestep')],
                    [sg.Text("Plotstep"), sg.Input(plotstep, size = (10,1)), sg.Button('Update Plotstep')],
                    [sg.Text("View Analysis", text_color= "Blue")],
                    [sg.Checkbox("Generate Eigenvalues on Runtime", change_submits = True, key='reltimeeig'),sg.Button('Generate PF and Eigenvalues')],
                    [sg.Checkbox("View Statevar Derivatives", change_submits = True, key='viewderiv')],
                    [sg.Text("Set system parameters", text_color= "Blue")],
                    [sg.Button('Grid Params')],
                    [sg.Button('Unit 1')],
                    [sg.Text("Set input parameters", text_color="Blue")],
                    [sg.Button('Unit 1 inputs')],
                    [sg.Button("Re Initialize")],
                    [sg.Button('Generate initialization snapshot'),],
                    ]

        window = sg.Window('Control GUI', layout)

        # Display and interact with the Window using an Event Loop
        while True:
            event, values = window.read()
            s = pd.Series(values)
            values = s.values
            print(values)
            if event == 'Grid Params':
                parsetno = 1
                paramset_gui(gridparams, gridparams_label, parsetno)
            if event == 'Unit 1':
                parsetno = 7
                paramset_gui(unit1sysparms, unit1sysparms_label, parsetno)
            if event == 'Unit 1 inputs':
                parsetno = 10
                paramset_gui(inputs_u1, inputs_u1_label, parsetno)

            if event == 'Update Window size':
                setwindowlen(values[4])
            if event == 'Update Timestep':
                setdt(values[5])
            if event == 'Update Plotstep':
                setpltwndw(values[6])
            if event == 'reltimeeig':
                showeigs(values[7])
            if event == 'Generate PF and Eigenvalues':
                genpf()
            if event == 'viewderiv':
                plotderivs(values[8])
            if event == 'Generate initialization snapshot':
                recsnapshot()
            if event == 'seltime':
                changevarobs(values[1],values[3],values[0])
            if event == 'selstatevar':
                changevarobs(values[1],values[3],values[0])
            if event == 'Clear and Plot':
                changevarobs(values[1],values[3],values[0])
            if event == 'Re Initialize':
                reinit()
            # See if user wants to quit or window was closed
            if event == sg.WINDOW_CLOSED or event == 'Quit':
                break
        # Finish up by removing from the screen
        window.close()
    main_gui()

def systemfunc():
    pi = math.pi

    # ---------------------------------get initial conditions from File-----------------------------
    #x = genfromtxt('init_snapshot_gridinit.csv', delimiter=',')

    #------------solve for initialization------------------
    x = np.ones((19)) * 1e-20
    #x = fsolve(func = nlmodel, x0 = x0, args=(params,inputs))#np.ones((15)) * 3 #

    print(x)


    def ssresponse(A, B):

    # =================develop State space form=======================
    # ----------------Output Matrices------------------------
        C = np.zeros(len(A))
        C[varobs_y] = 1                           #state to observe

        # -------------------Feedforward Matrix----------------
        D = np.zeros(len(B[0]))

        # -------------------State matrix Defintion-------------------

        sys = ss(A, B, C, D)

        #----------------get response---------------
        tEnd = 5
        time = np.arange(0, tEnd, 1e-3)
        yss, tss = ctl.step(sys * 0.001, T=time, input=pertb_inp)
        return yss,tss


    @njit
    def integrator(params, inputs, x_hist, delta_t):
        """

        :param Pref1:
        :param x_hist:
        :param delta_t:
        :return:
        """
        fn = nlmodel(x_hist, params, inputs)

        fn1_int = x_hist + 0.5 * delta_t * fn
        fn1 = nlmodel(fn1_int, params, inputs)

        fn2_int = x_hist + 0.5 * delta_t * fn1
        fn2 = nlmodel(fn2_int, params, inputs)

        fn3_int = x_hist + delta_t * fn2
        fn3 = nlmodel(fn3_int, params, inputs)

        x_curr = x_hist + (delta_t / 6) * (fn + 2 * fn1 + 2 * fn2 + fn3)
        return x_curr

    def num_linmodd(params,inputs,x_hist):

        i = 0
        inc = 1e-10
        #jac_x = np.zeros((len(x_hist),len(x_hist)))
        while i < len(x_hist):
            x_pert = x_hist.copy()
            x_pert[i] = x_pert[i] + inc
            fn = nlmodel(x_hist, params, inputs)
            fn_inc = nlmodel(x_pert, params, inputs)
            jac_x = (fn_inc - fn)/(inc)
            if i == 0:
                jac = jac_x.copy()
            if i > 0:
                jac = np.vstack((jac, jac_x))
            i = i + 1
        jac = np.asarray(jac)
        jac = np.transpose(jac)
        eigs = la.eig(jac)
        Y = (eigs[0].imag)
        X = (eigs[0].real)
        # print(eigs[0])
        return X, Y, jac

    out = []
    tx = []

    #-----------------initialize graph objects----------------------

    dx = np.arange(len(x))
    dvar = np.empty([len(x)])

    win1 = pg.GraphicsWindow()
    win1.resize(800, 400)
    win1.setBackground('w')

    win2 = pg.GraphicsWindow()
    win2.resize(800, 400)
    win2.setBackground('w')

    win3 = pg.plot()
    win3.resize(800, 400)
    win3.setBackground('w')
    plotstatevarderiv = pg.BarGraphItem(x = dx, height = dvar,width = 0.6, brush="b")
    win3.addItem(plotstatevarderiv)


    # win4 = pg.plot()
    # win4.resize(800, 800)
    # win4.setBackground('w')
    # plotstatevar = pg.BarGraphItem(x = dx, height = x,width = 0.6, brush="b")
    # win4.addItem(plotstatevar)

    p1 = win1.addPlot()
    p1.showGrid(x=True, y=True, alpha=0.3)

    p2 = win2.addPlot()
    p2.showGrid(x=True, y=True, alpha=0.3)
    p2.addLegend()


    p3 = win2.addPlot()
    p3.showGrid(x=True, y=True, alpha=0.3)
    p3.addLegend()

    X=[]
    Y=[]
    ploteignum = p1.plot(X, Y, symbolBrush=(0, 0, 255), symbol='o',pen=pg.mkPen(None))

    plotsim = p2.plot(tx, out, pen="r",name = 'P1')
    plotsim2 = p2.plot(tx, out, pen="g",name = 'Q2')

    plotsim3 = p3.plot(tx, out, pen="b",name = 'W')

    out_PSCAD = []
    tx_PSCAD = []


    #plotpscad = p2.plot(tx, out, pen="b", name = 'PSCAD Runtime Plot')         #----------------plot PSCAD response for validation Runtime--------------------
    data_PSCAD = np.genfromtxt("PSCAD_data.txt", delimiter=",", names=["x", "y"])

    plotpscad = p2.plot(data_PSCAD['x'], data_PSCAD['y'], pen="b", name = 'PSCAD Plot')         #----------------plot PSCAD response for validation SAved--------------------



    # plotss = p2.plot((tss + 0.1), (yss + x[varobs_y]), pen="b")         #----------------plot an SS response for validation--------------------

    @njit
    def eigcalc(MAT):
        eigs = la.eig(MAT)
        Y = (eigs[0].imag)
        X = (eigs[0].real)
        return X, Y



    def solver(x_hist):
        """

        :param Pref1:
        :param x_hist:
        :param delta_t:
        :return:
        """
        # assign history term value
        time = 0
        out = []
        tx = []
        out2 = []
        tx2 = []

        out3 = []
        tx3 = []

        x_temp = np.zeros((len(x_hist)))
        time_splt = 0
        out_eigtest = np.zeros((len(x_hist)))

        global delta_t
        while time < sim_length:

            #--------------Re initialize the simulation----------
            global initsim
            if initsim == 1:
                x = genfromtxt('init_snapshot_gridinit.csv', delimiter=',')
                x_hist = x
                initsim = 0
            # ---------------------change a parameter at a given time(for validation with ss_models)

            # if time > 10:
            #     params[15] = 100

            #------------------create simulation snapshot-------------------------
            global recsnapshot
            if recsnapshot == 1:
                 np.savetxt("init_snapshot_gridinit.csv", x_hist)
                 print("snapshot recorded")
                 recsnapshot = 0
            # call 4th order RK method
            x_hist = integrator(params, inputs, x_hist, delta_t)
            time = time + delta_t

            #----------plot within plot step------------------
            if time > time_splt:
                global changevarobs
                if changevarobs == 1:
                    out = []
                    tx = []
                    changevarobs = 0
                #------------show limited datapoints on plot----------------

                # Iq1 = (+x_hist[1] * np.cos(x_hist[14]) - x_hist[2] * np.sin(x_hist[14]))        # Transform unit currents to common reference frame
                # Id1 = (+x_hist[1] * np.sin(x_hist[14]) + x_hist[2] * np.cos(x_hist[14]))
                wconv = inputs_u1[2] + x_hist[7] * unit1sysparms[9] + x_hist[2] * unit1sysparms[10]

                P1 = x_hist[14] #constructed variables for observation
                Q1 = x_hist[15] #constructed variables for observation



                #intvar = np.sqrt(x_hist[0]**2 + x_hist[1]**2)
                # active powers
                global windowlen

                if len(out) > windowlen:
                    out = np.append(out[1:windowlen], P1)
                else:
                    out = np.append(out, P1)

                # reactive powers

                if len(out2) > windowlen:
                    out2 = np.append(out2[1:windowlen], Q1)
                else:
                    out2 = np.append(out2, Q1)

                # frequency

                if len(out3) > windowlen:
                    out3 = np.append(out3[1:windowlen], wconv)
                else:
                    out3 = np.append(out3, wconv)

                global plottimeasx
                if plottimeasx == 1:
                    if len(tx) > windowlen:
                        tx = np.append(tx[1:windowlen], time)
                    else:
                        tx = np.append(tx, time)

                    if len(tx2) > windowlen:
                        tx2 = np.append(tx2[1:windowlen], time)
                    else:
                        tx2 = np.append(tx2, time)

                    if len(tx3) > windowlen:
                        tx3 = np.append(tx3[1:windowlen], time)
                    else:
                        tx3 = np.append(tx3, time)

                if plottimeasx == 0:
                    if len(tx) > windowlen:
                        tx = np.append(tx[1:windowlen], x_hist[varobs_x])
                    else:
                        tx = np.append(tx, x_hist[varobs_x])
                #-------------show all datapoints on plot-------------------------

                #--display solver solution-----
                # out.append(x_hist[varobs_y])
                # tx.append(time)

                pen1 = pg.mkPen(color=(255, 0, 0), width = 2,)
                pen2 = pg.mkPen(color=(0, 255, 0), width = 2,)
                pen3 = pg.mkPen(color=(0, 0, 255), width = 2,)

                plotsim.setData(tx, out, pen = pen1)
                plotsim2.setData(tx2, out2, pen = pen2)
                plotsim3.setData(tx3, out3, pen = pen3)


                global plotderivs
                if plotderivs == 1:
                    plotstatevarderiv.setOpts(height = np.abs((x_temp - x_hist) / delta_t))
                    # plotstatevar.setOpts(height = x_hist)

                #-------------calculate eigenvalues dynamically-------------------------
                if showeigs == 1:
                    Xnum, Ynum, jac = num_linmodd(params, inputs, x_hist)
                    ploteignum.setData(Xnum, Ynum)

                    #---------------plot eiganvalues and participation factors-------------------
                    global showpf
                    if showpf == 1:
                        if np.var((x_temp - x_hist) / delta_t) < 1e-10:
                            print("Variance of state Derivatives = ", np.var((x_temp - x_hist) / delta_t))
                            pfcalc(jac)
                            eigplot(Xnum, Ynum)
                        else:
                            print("Variance of state Derivatives = ", np.var((x_temp - x_hist) / delta_t))
                            print("not reached steady state")

                        showpf = 0
                # -------------Plot PSCAD Runtime data-------------------------

                # x1pscad = float(data[0])
                # y1pscad = float(data[1])
                # out_PSCAD.append(y1pscad)
                # tx_PSCAD.append(x1pscad)
                #
                # plotpscad.setData(tx_PSCAD, out_PSCAD)

                p1.enableAutoRange("xy", False)
                pg.QtGui.QApplication.processEvents()
                time_splt = time_splt + delta_t * plotstep
                x_temp = x_hist

        return tx, out


    solver(x)
    win2.close()


if __name__ == "__main__":
    thread_readf = Thread(target=readfile)
    thread_gui = Thread(target=controlgui)
    thread_sys = Thread(target=systemfunc)
    thread_readf.start()
    thread_gui.start()
    thread_sys.start()

