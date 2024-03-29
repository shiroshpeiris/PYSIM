
#------------------------------------------------------------------------------
# Project 'Drp_Gfor_casc' make using the 'Intel_ Fortran Compiler Classic 2021.1.2 (64-bit)' compiler.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# All project
#------------------------------------------------------------------------------

all: targets
	@echo !--Make: succeeded.



#------------------------------------------------------------------------------
# Directories, Platform, and Version
#------------------------------------------------------------------------------

Arch        = windows
EmtdcDir    = C:\Program Files (x86)\PSCAD500 x64\emtdc\if18
EmtdcInc    = $(EmtdcDir)\inc
EmtdcBin    = $(EmtdcDir)\$(Arch)
EmtdcMain   = $(EmtdcBin)\main.obj
EmtdcLib    = $(EmtdcBin)\emtdc.lib
SolverLib    = $(EmtdcBin)\Solver.lib


#------------------------------------------------------------------------------
# Fortran Compiler
#------------------------------------------------------------------------------

FC_Name         = ifort.exe
FC_Suffix       = obj
FC_Args         = /nologo /c /free /real_size:64 /fpconstant /warn:declarations /iface:default /align:dcommons /fpe:0
FC_Debug        =  /O2
FC_Preprocess   = 
FC_Preproswitch = 
FC_Warn         = 
FC_Checks       = 
FC_Includes     = /include:"$(EmtdcInc)" /include:"$(EmtdcDir)" /include:"$(EmtdcBin)"
FC_Compile      = $(FC_Name) $(FC_Args) $(FC_Includes) $(FC_Debug) $(FC_Warn) $(FC_Checks)

#------------------------------------------------------------------------------
# C Compiler
#------------------------------------------------------------------------------

CC_Name     = cl.exe
CC_Suffix   = obj
CC_Args     = /nologo /MT /W3 /EHsc /c
CC_Debug    =  /O2
CC_Includes = 
CC_Compile  = $(CC_Name) $(CC_Args) $(CC_Includes) $(CC_Debug)

#------------------------------------------------------------------------------
# Linker
#------------------------------------------------------------------------------

Link_Name   = link.exe
Link_Debug  = 
Link_Args   = /out:$@ /nologo /nodefaultlib:libc.lib /nodefaultlib:libcmtd.lib /subsystem:console
Link        = $(Link_Name) $(Link_Args) $(Link_Debug)

#------------------------------------------------------------------------------
# Build rules for generated files
#------------------------------------------------------------------------------


.f.$(FC_Suffix):
	@echo !--Compile: $<
	$(FC_Compile) $<



.c.$(CC_Suffix):
	@echo !--Compile: $<
	$(CC_Compile) $<



#------------------------------------------------------------------------------
# Build rules for file references
#------------------------------------------------------------------------------


#------------------------------------------------------------------------------
# Dependencies
#------------------------------------------------------------------------------


FC_Objects = \
 DS.$(FC_Suffix) \
 Main.$(FC_Suffix) \
 Converter_16.$(FC_Suffix) \
 Filter_L_1_1_1.$(FC_Suffix) \
 PQ_control_10.$(FC_Suffix) \
 VF_Control_7.$(FC_Suffix) \
 Current_Limiter_3.$(FC_Suffix) \
 Converter_15.$(FC_Suffix)

FC_ObjectsLong = \
 "DS.$(FC_Suffix)" \
 "Main.$(FC_Suffix)" \
 "Converter_16.$(FC_Suffix)" \
 "Filter_L_1_1_1.$(FC_Suffix)" \
 "PQ_control_10.$(FC_Suffix)" \
 "VF_Control_7.$(FC_Suffix)" \
 "Current_Limiter_3.$(FC_Suffix)" \
 "Converter_15.$(FC_Suffix)"

CC_Objects =

CC_ObjectsLong =

LK_Objects =

LK_ObjectsLong =

SysLibs  = ws2_32.lib

Binary   = Drp_Gfor_casc.exe

$(Binary): $(FC_Objects) $(CC_Objects) $(LK_Objects) 
	@echo !--Link: $@
	$(Link) "$(EmtdcMain)" $(FC_ObjectsLong) $(CC_ObjectsLong) $(LK_ObjectsLong) "$(EmtdcLib)" "$(SolverLib)" $(SysLibs)

targets: $(Binary)


clean:
	-del EMTDC_V*
	-del *.obj
	-del *.o
	-del *.exe
	@echo !--Make clean: succeeded.



