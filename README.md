# PYSIM- Microgrid Model
This Repository contains the Python models used to Simulate the Microgrid with and without the virtual resistances. 
The complete grid forming converter models, and the microgrid network models used to generate the  simulation results in the publication are provided in this repository.

# Parameteres for Converters and Microgrid #
The parameters for the Converters are given below

| **Converter Paramaters**  |          |                      |          |
|:--------------------------|:--------:|:---------------------|:--------:|
| Capacity (MVA)            |    2     | Tf Impedance (pu)    |   0.1    |
| Terminal Voltage (kV)     |   0.69   | Tf cu loss (pu)      |  0.021   |
| **Filter Parameters**     |          |                      |          |
| $L\_{\rm{f}}$ (H)         | 0.000335 | $L\_{\rm{d}}$ (H)    | 0.000621 |
| $C\_{\rm{d}}$ (F)         |  0.0007  | $R\_{\rm{d}}$ (*Ω*)  |  1.332   |
| **Power Controllers**     |          |                      |          |
| *H*                       |    2     | $K\_{\rm{p}}$        |    1     |
| $K\_{\rm{q}}$             |   0.2    | $K\_{\rm{d}}$        |    20    |
| $\omega\_{\rm{c}}$        |   1000   | *ω*<sub>0</sub>      |   377    |
| **Voltage Controller**    |          |                      |          |
| $K\_{\rm{pv}}$            |    1     | $K\_{\rm{iv}}$       |    10    |
| **Current Controller**    |          |                      |          |
| $K\_{\rm{pi}}$            |    5     | $K\_{\rm{ii}}$       |    5     |
| **Input Parameters**      |          |                      |          |
| $P\_{\rm{ref}}$ (pu)      |   0.52   | $Q\_{\rm{ref}}$ (pu) |   0.3    |
| $\omega\_{\rm{ref}}$ (pu) |    1     | $V\_{\rm{ref}}$ (pu) |    1     |

The paremeters for the Microgrid are given as follows, the parameters are same for all load elements and line segments

| **Microgrid Parameters (pu)**        |        |                                       |       |
|:-------------------------------------|:------:|:--------------------------------------|:-----:|
| $\rm{Line}$ $\rm{Resistance}$ $(R_{\rm{mn}}) $    | 0.502  | $\rm{Line}$ $\rm{inductance}$ $(L_{\rm{mn}})$     | 0.512 |
| $\rm{Load}$ $\rm{Resistance}$ $(R_{\rm{load}{n}})$ | 44.528 | $\rm{Load}$ $\rm{inductance}$ $(L_{\rm{load}{n}})$ | 26.55 |

# Symbolic code to generate Microgrid network models

1. The ___symcalc_4conv.py___ contains the code to generate the Matrix of coefficents in the microgrid network with 4 converters without virtual resistances as shown in figure 1 of the Publication. 
2. The ___symcalc_Generalized.py___ contains the code to generate the Matrix of coefficents in the microgrid network with 8 converters provided in figure 6 of the Publication.

# Simulation Case Files #

The Folders contain the python simulation cases.The ___Exec.py___ will execute the case and generate the responses and eigenvalues of the system. 
1. For the Microgrid model with virtual resistances the simulation case files are stored in __(VIR_RES_SYS)__ .The value of virtual resistance can be changed in ___Bus_mod_R.py___
2. For the proposed Microgrid model without virtual resistances the simulation case files are stored in __(NO_VIR_RES)__ virtual resistances. 
3. The case files for the generalized case using the proposed method without virtual resistances is in __(Generalized Case)__ folder.

The relevant dependencies to be installed are in the heading of each file and are listed below. They can be installed through __pip__ or __anaconda__ packages. 

* numpy  {1.20.3 (defaults/win-64) 
* numba  {0.54.1 (defaults/win-64)
* scipy  {1.7.1  (defaults/win-64)} 
* math
* Threading
* time
* pyqtgraph  {0.11.0 (anaconda/noarch) 
* pysimplegui {4.56.0 (conda-forge/noarch)}
* pandas  {1.3.4 (defaults/win-64)}
* sympy  {1.9 (defaults/win-64)}
* plotly {5.5.0 (plotly/noarch)}


