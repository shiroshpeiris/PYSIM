# PYSIM
This Repository contains the Python models used to Simulate the Microgrid with and without The virtual resistances. 

# Parameteres for Converters and Microgrid #
The parameters for the Converters are given below

|                          |          |                         |          |
|--------------------------|----------|-------------------------|----------|
| Capacity (MVA)           | 2        | Tf Impedance (pu)       | 0.1      |
| Terminal Voltage (kV)    | 0.69     | Tf cu loss (pu)         | 0.021    |
| $L_{\rm{f}}$ (H)         | 0.000335 | $L_{\rm{d}}$ (H)        | 0.000621 |
| $C_{\rm{d}}$ (F)         | 0.0007   | $R_{\rm{d}}$ ($\Omega$) | 1.332    |
| $H$                      | 2        | $K_{\rm{p}}$            | 1        |
| $K_{\rm{q}}$             | 0.2      | $K_{\rm{d}}$            | 20       |
| $\omega_{\rm{c}}$        | 1000     | $\omega_0$              | 377      |
| $K_{\rm{pv}}$            | 1        | $K_{\rm{iv}}$           | 10       |
| $K_{\rm{pi}}$            | 5        | $K_{\rm{ii}}$           | 5        |
| $P_{\rm{ref}}$ (pu)      | 0.52     | $Q_{\rm{ref}}$ (pu)     | 0.3      |
| $\omega_{\rm{ref}}$ (pu) | 1        | $V_{\rm{ref}}$ (pu)     | 1        |


The paremeters for the Microgrid are given as follows

|                                     |        |                                      |       |
|-------------------------------------|--------|--------------------------------------|-------|
| $\rm{Line Resistance}$ $(R_{\rm{mn}}) $    | 0.502  | $\rm{Line inductance}$ $(L_{\rm{mn}})$     | 0.512 |
| $\rm{Load Resistance}$ $(R_{\rm{load}{n}})$ | 44.528 | $\rm{Load inductance}$ $(L_{\rm{load}{n}})$ | 26.55 |

# Symbolic Matrix generation #

The symcalc_4conv.py contains the code to generate the Matrix for 4 converter microgrid example without virtual resistances as shown in figure 1 of the Publication. 
The symcalc_Generalized.py contains the code to generate the Matrix the converter system with 8 converters provided in Figure 6 of the Publication.

# Simulation Case Files #

The Folders contain the python simulation cases for the Microgrid model with (VIR_RES_SYS) and without(NO_VIR_RES) virtual resistances. The Exec.py will execute the case. The relevant libraries to be installed are shown in the heading of each file. 


