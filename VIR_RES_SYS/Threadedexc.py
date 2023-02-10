#------------------import libraries-------------------------
from threading import Thread
import math
from numpy import genfromtxt
import time
import matplotlib.pyplot as plt

from funcs import *
from param_arr import *
from eigplot import *
from scipy.optimize import fsolve,leastsq
import pyqtgraph as pg
pg.setConfigOptions(antialias=True)

import control.matlab as ctl
from control import ss
import csv

import PySimpleGUI as sg
import pandas as pd


pertb_inp=4
sim_length = 20000


#-------------------------- control params------------------------------------------


#-----------------------initialize global variables--------------------------

#-----sim parameter variables----------
varobs_y = 0
varobs_x = 0
windowlen = 5000
delta_t = 1e-8
plotstep = 1000


#--------conditional variables--------------
showeigs = 0
novals = 5
showpfvals = 0
changevarobs = 0
showpf = 0
recsnapshot = 0
plotderivs = 0
plottimeasx = 1
initsim = 0
showvals = 0

def systemfunc():
    pi = math.pi

    # ---------------------------------get initial conditions from File-----------------------------
    x0 = genfromtxt('init_snapshot.csv', delimiter=',')

    #------------solve for initialization------------------
    x = np.ones((83)) * 1e-20
    x0 = fsolve(func = nlmodel, x0 = x0, args=(params,inputs))#np.ones((199)) * 1e-20 ##

    x = leastsq(func = nlmodel, x0 = x0, args=(params,inputs),ftol=1.49012e-10, xtol=1.49012e-10)               # leastsq works fine for the case where it doesnt solve with fsolve due to the 60Hz oscillatory mode in the detailed non aggregate system
    x=x[0]

    print(x)

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

    X=[]
    Y=[]
    ploteignum = p1.plot(X, Y, symbolBrush=(0, 0, 255), symbol='o',pen=pg.mkPen(None))

    plotsim1 = p2.plot(tx, out, pen=pg.mkPen('r', width=2),name = 'P1', )
    plotsim2 = p2.plot(tx, out, pen=pg.mkPen('g', width=2),name = 'P2')
    plotsim3 = p2.plot(tx, out, pen=pg.mkPen('b', width=2),name = 'P3', )
    plotsim4 = p2.plot(tx, out, pen=pg.mkPen('c', width=2),name = 'P4')
    plotsim5 = p2.plot(tx, out, pen=pg.mkPen('m', width=2),name = 'P5', )

    data_PSCAD = np.genfromtxt("PSCAD_data.txt", delimiter=",", names=["x", "y"])
    plotpscad = p2.plot(data_PSCAD['x'], data_PSCAD['y'], pen="b",
                        name='PSCAD Plot')  # ----------------plot PSCAD response for validation SAved--------------------


    def displayvals(x):
        gen = x[0:85]
        angles = x[len(gen):(len(gen) + 5)]
        lines = x[(len(angles) + len(gen)):((len(angles) + len(gen)) + 10)]
        busvol = []
        linecurr = []

        i = 0
        j = 0

        # while i < len(buses):
        #     busvol = np.append(busvol, np.sqrt(buses[i] ** 2 + buses[i + 1] ** 2))
        #     i += 2

        while j < len(lines):
            linecurr = np.append(linecurr, np.sqrt(lines[j] ** 2 + lines[j + 1] ** 2))
            j += 2

        # print(busvol)
        print(linecurr)

    displayvals(x)


    global text
    text = {}
    for number in range(0, 74):
        text["text%i" % number] = pg.TextItem('[%0.1f, %0.1f]' % (0, 0))
        text["text%i" % number].setColor('k')
        p1.addItem(text["text"+str(number)])



    def solver(x_hist):
        """

        :param Pref1:
        :param x_hist:
        :param delta_t:
        :return:
        """
        # assign history term value
        time = 0
        out1, out2, out3, out4,out5,out6,out7,out8,out9,out10 = ([], ) * 10
        tx = []
        x_temp = np.zeros((len(x_hist)))
        time_splt = 0
        out_eigtest = np.zeros((len(x_hist)))

        global delta_t
        while time < sim_length:
            global initsim
            if initsim == 1:
                x0 = genfromtxt('init_snapshot.csv', delimiter=',')
                x = fsolve(func=nlmodel, x0=x0, args=(params, inputs))
                
                x_hist = x
                time = 0
                out1, out2, out3, out4, out5,  = ([],) * 5
                tx = []
                x_temp = np.zeros((len(x_hist)))
                time_splt = 0
                out_eigtest = np.zeros((len(x_hist)))
                initsim = 0
            # ---------------------change a parameter at a given time(for validation with ss_models)

            # if time > 0.1:
            #     inputs[0] = 1



            #------------------create simulation snapshot-------------------------
            global recsnapshot
            if recsnapshot == 1:
                 np.savetxt("init_snapshot.csv", x_hist)
                 print("snapshot recorded")
                 recsnapshot = 0
            # call 4th order RK method

            global showvals
            if showvals == 1:
                 displayvals(x_hist)
                 showvals = 0
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

                gen = x_hist[0:85]
                angles = x_hist[len(gen):(len(gen) + 5)]

                global windowlen
                if len(out1) > windowlen:
                    out1 = np.append(out1[1:windowlen], x_hist[1])
                    out2 = np.append(out2[1:windowlen], x_hist[18])
                    out3 = np.append(out3[1:windowlen], x_hist[35])
                    out4 = np.append(out4[1:windowlen], x_hist[52])

                else:
                    out1 = np.append(out1, x_hist[1])
                    out2 = np.append(out2, x_hist[18])
                    out3 = np.append(out3, x_hist[35])
                    out4 = np.append(out4, x_hist[52])

                global plottimeasx
                if plottimeasx == 1:
                    if len(tx) > windowlen:
                        tx = np.append(tx[1:windowlen], time)
                    else:
                        tx = np.append(tx, time)

                if plottimeasx == 0:
                    if len(tx) > windowlen:
                        tx = np.append(tx[1:windowlen], x_hist[varobs_x])

                    else:
                        tx = np.append(tx, x_hist[varobs_x])

                #-------------show all datapoints on plot-------------------------

                #--display solver solution-----
                # out.append(x_hist[varobs_y])
                # tx.append(time)

                pen = pg.mkPen(color=(255, 0, 0), width = 2,)
                plotsim1.setData(tx, out1)
                plotsim2.setData(tx, out2)
                plotsim3.setData(tx, out3)
                plotsim4.setData(tx, out4)

                global plotderivs
                if plotderivs == 1:
                    plotstatevarderiv.setOpts(height = np.abs((x_temp - x_hist) / delta_t))
                    # plotstatevar.setOpts(height = x_hist)

                #-------------calculate eigenvalues dynamically-------------------------
                if showeigs == 1:
                    Xnum, Ynum, jac = num_linmodd(params, inputs, x_hist)
                    ploteignum.setData(Xnum, Ynum)
                    win1.setWindowTitle("Eigenvalue Plot")
                    if showpfvals == 1:
                        pfabs = pfgen(jac)
                        eigno = 0
                        for eigtextref in text:
                            pfordered = pfsort(pfabs, eigno, novals)

                            states = pfordered[0, :]
                            states = states.astype(int)
                            pfvals = pfordered[1, :]

                            res = "\n".join("State:{}   PF:{}".format(x, y) for x, y in zip(states, pfvals))

                            text[eigtextref].setPos(Xnum[eigno], Ynum[eigno])
                            text[eigtextref].setText('Values: [%0.3f, %0.3f]\nDamping ratio:[%0.3f]\n%s' % (
                            Xnum[eigno], Ynum[eigno], (-Xnum[eigno] / (np.sqrt(Xnum[eigno] ** 2 + Ynum[eigno] ** 2))),
                            res))
                            eigno = eigno + 1
                    elif showpfvals == 0:
                        eigno = 0
                        for eigtextref in text:
                            text[eigtextref].setPos(Xnum[eigno], Ynum[eigno])
                            text[eigtextref].setText('Values: [%0.3f, %0.3f]\nDamping ratio:[%0.3f]' % (
                            Xnum[eigno], Ynum[eigno], (-Xnum[eigno] / (np.sqrt(Xnum[eigno] ** 2 + Ynum[eigno] ** 2)))))
                            eigno = eigno + 1

                    #---------------plot eiganvalues and participation factors-------------------
                    global showpf
                    if showpf == 1:
                        if np.var((x_temp - x_hist) / delta_t) < 1e-10:
                            print("Variance of state Derivatives = ", np.var((x_temp - x_hist) / delta_t))
                            pfcalc(jac)
                            eigplot(Xnum, Ynum)
                            np.savetxt("eigsx.csv", Xnum)
                            np.savetxt("eigsy.csv", Ynum)

                        else:
                            print("Variance of state Derivatives = ", np.var((x_temp - x_hist) / delta_t))
                            print("not reached steady state")

                        showpf = 0

                p1.enableAutoRange("xy", False)
                pg.QtGui.QApplication.processEvents()
                time_splt = time_splt + delta_t * plotstep
                x_temp = x_hist

        return tx, out

    start = time.time()
    solver(x)
    win2.close()
    end = time.time()
    print(end - start)

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
        global piu1params, ld12params, piu2params, ld13params, piu3params, ld32params, unit1sysparms, unit2sysparms, unit3sysparms, inputs_u1, inputs_u2, inputs_u3
        if parsetno == 1:
            piu1params = params[0:9] = parvalues
        if parsetno == 2:
            piu2params = params[16:25] = parvalues
        if parsetno == 3:
            piu3params = params[32:41] = parvalues
        if parsetno == 4:
            ld12params = params[9:16] = parvalues
        if parsetno == 5:
            ld13params = params[25:32] = parvalues
        if parsetno == 6:
            ld32params = params[41:48] = parvalues
        if parsetno == 7:
            unit1sysparms = params[48:88] = parvalues
        if parsetno == 8:
            unit2sysparms = params[88:128] = parvalues
        if parsetno == 9:
            unit3sysparms = params[128:168] = parvalues
        if parsetno == 10:
            inputs_u1 = inputs[0:4] = parvalues
        if parsetno == 11:
            inputs_u2 = inputs[4:8] = parvalues
        if parsetno == 12:
            inputs_u3 = inputs[8:12] = parvalues

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

    def showpfvals(var):
        global showpfvals
        if var == True:
            showpfvals = 1
        elif var == False:
            showpfvals = 0

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
                    [sg.Checkbox("Generate Eigenvalues on Runtime", change_submits = True, key='reltimeeig'),sg.Checkbox("Show Participation and States", change_submits=True, key='shwpfvals')],
                    [sg.Checkbox("View Statevar Derivatives", change_submits = True, key='viewderiv'),sg.Button('Generate PF and Eigenvalue plots')],
                    [sg.Text("Set system parameters", text_color= "Blue")],
                    [sg.Button('PI section 1'),sg.Button('PI section 2'),sg.Button('PI section 3')],
                    [sg.Button('Load 12'), sg.Button('Load 13'), sg.Button('Load 23')],
                    [sg.Button('Unit 1'), sg.Button('Unit 2'), sg.Button('Unit 3')],
                    [sg.Text("Set input parameters", text_color="Blue")],
                    [sg.Button('Unit 1 inputs'), sg.Button('Unit 2 inputs'), sg.Button('Unit 3 inputs')],
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
            if event == 'PI section 1':
                parsetno = 1
                paramset_gui(piu1params, piu1params_label, parsetno)
            if event == 'PI section 2':
                parsetno = 2
                paramset_gui(piu2params, piu2params_label, parsetno)
            if event == 'PI section 3':
                parsetno = 3
                paramset_gui(piu3params, piu3params_label, parsetno)
            if event == 'Load 12':
                parsetno = 4
                paramset_gui(ld12params, ld12params_label, parsetno)
            if event == 'Load 13':
                parsetno = 5
                paramset_gui(ld13params, ld13params_label, parsetno)
            if event == 'Load 23':
                parsetno = 6
                paramset_gui(ld32params, ld32params_label, parsetno)
            if event == 'Unit 1':
                parsetno = 7
                paramset_gui(unit1sysparms, unit1sysparms_label, parsetno)
            if event == 'Unit 2':
                parsetno = 8
                paramset_gui(unit2sysparms, unit2sysparms_label, parsetno)
            if event == 'Unit 3':
                parsetno = 9
                paramset_gui(unit3sysparms, unit3sysparms_label, parsetno)
            if event == 'Unit 1 inputs':
                parsetno = 10
                paramset_gui(inputs_u1, inputs_u1_label, parsetno)
            if event == 'Unit 2 inputs':
                parsetno = 11
                paramset_gui(inputs_u2, inputs_u2_label, parsetno)
            if event == 'Unit 3 inputs':
                parsetno = 12
                paramset_gui(inputs_u3, inputs_u3_label, parsetno)

            if event == 'Update Window size':
                setwindowlen(values[4])
            if event == 'Update Timestep':
                setdt(values[5])
            if event == 'Update Plotstep':
                setpltwndw(values[6])
            if event == 'reltimeeig':
                showeigs(values[7])
            if event == 'shwpfvals':
                showpfvals(values[8])
            if event == 'Generate PF and Eigenvalue plots':
                genpf()
            if event == 'viewderiv':
                plotderivs(values[9])
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

if __name__ == "__main__":
    thread_gui = Thread(target=controlgui)
    thread_sys = Thread(target=systemfunc)
    thread_gui.start()
    thread_sys.start()

