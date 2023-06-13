!=======================================================================
! Generated by: PSCAD v5.0.0.0
! Warning:  The content of this file is automatically generated.
!           Do not modify, as any changes made here will be lost!
!-----------------------------------------------------------------------
! Component     : Converter_16
! Description   : 
!-----------------------------------------------------------------------


!=======================================================================

      SUBROUTINE Converter_16Dyn(Pref, Qref, UN, V_HV)

!---------------------------------------
! Standard includes 
!---------------------------------------

      INCLUDE 'nd.h'
      INCLUDE 'emtconst.h'
      INCLUDE 'emtstor.h'
      INCLUDE 's0.h'
      INCLUDE 's1.h'
      INCLUDE 's2.h'
      INCLUDE 's4.h'
      INCLUDE 'branches.h'
      INCLUDE 'pscadv3.h'
      INCLUDE 'fnames.h'
      INCLUDE 'radiolinks.h'
      INCLUDE 'matlab.h'
      INCLUDE 'rtconfig.h'

!---------------------------------------
! Function/Subroutine Declarations 
!---------------------------------------

!     SUBR    Filter_L_1_1_1Dyn  ! 
!     SUBR    PQ_control_10Dyn  ! 
!     SUBR    VF_Control_7Dyn  ! 
!     SUBR    Converter_15Dyn  ! 
!     SUBR    EMTDC_X2COMP  ! 'Comparator with Interpolation'

!---------------------------------------
! Variable Declarations 
!---------------------------------------


! Subroutine Arguments
      REAL,    INTENT(IN)  :: Pref, Qref, UN
      REAL,    INTENT(IN)  :: V_HV

! Electrical Node Indices
      INTEGER  NT_9(3), NT_10(3)

! Control Signals
      REAL     Vref_dq(3), UFqref, Wint, Qref_
      REAL     Pref_, Q, P, RT_1, RT_2, RT_3
      REAL     RT_4, Iinv(3), Pmeas, Qmeas
      REAL     RT_5(3), Fmeas, RT_6, RT_7, RT_8
      REAL     RT_9, RT_10, RT_11, Qcontrol
      REAL     RT_12, RT_13, RT_14, RT_15, RT_16
      REAL     RT_17, VRMS, VRMSF, L_Load, R_Load
      REAL     RT_18(3), Vpcc, Pg, Ig, Qg, Wref
      REAL     RT_19, Wsys, RT_20, Igrid(3), IRMS
      REAL     Va, Vb, Vc, Vgrid(3), V33(3), PG_
      REAL     QG_, Vrms_bus_pu

! Internal Variables
      INTEGER  IVD1_1
      REAL     Hma_n_1, Hmb_n_1, Hmc_n_1, Hka_n_1
      REAL     Hkb_n_1, Hkc_n_1, Hma_n, Hmb_n
      REAL     Hmc_n, Hka_n, Hkb_n, Hkc_n, Yc
      REAL     Ycm, RVD2_1(2)

! Indexing variables
      INTEGER ICALL_NO                            ! Module call num
      INTEGER ISTOF, IT_0                         ! Storage Indices
      INTEGER ICX, IPGB                           ! Control/Monitoring
      INTEGER ISUBS, SS(2), IBRCH(2), INODE       ! SS/Node/Branch/Xfmr
      INTEGER IXFMR


!---------------------------------------
! Local Indices 
!---------------------------------------

! Dsdyn <-> Dsout transfer index storage

      NTXFR = NTXFR + 1

      TXFR(NTXFR,1) = NSTOL
      TXFR(NTXFR,2) = NSTOI
      TXFR(NTXFR,3) = NSTOF
      TXFR(NTXFR,4) = NSTOC

! Increment and assign runtime configuration call indices

      ICALL_NO  = NCALL_NO
      NCALL_NO  = NCALL_NO + 1

! Increment global storage indices

      ISTOF     = NSTOF
      NSTOF     = NSTOF + 70
      IPGB      = NPGB
      NPGB      = NPGB + 22
      ICX       = NCX
      NCX       = NCX + 11
      INODE     = NNODE + 2
      NNODE     = NNODE + 29
      IXFMR     = NXFMR
      NXFMR     = NXFMR + 3
      NCSCS     = NCSCS + 0
      NCSCR     = NCSCR + 0

! Initialize Subsystem Mapping

      ISUBS = NSUBS + 0
      NSUBS = NSUBS + 2

      DO IT_0 = 1,2
         SS(IT_0) = SUBS(ISUBS + IT_0)
      END DO

! Initialize Branch Mapping.

      IBRCH(1)     = NBRCH(SS(1))
      NBRCH(SS(1)) = NBRCH(SS(1)) + 28


      IBRCH(2)     = NBRCH(SS(2))
      NBRCH(SS(2)) = NBRCH(SS(2)) + 1

!---------------------------------------
! Transfers from storage arrays 
!---------------------------------------

      UFqref   = STOF(ISTOF + 8)
      Wint     = STOF(ISTOF + 9)
      Qref_    = STOF(ISTOF + 10)
      Pref_    = STOF(ISTOF + 11)
      Q        = STOF(ISTOF + 12)
      P        = STOF(ISTOF + 13)
      RT_1     = STOF(ISTOF + 14)
      RT_2     = STOF(ISTOF + 15)
      RT_3     = STOF(ISTOF + 16)
      RT_4     = STOF(ISTOF + 17)
      Pmeas    = STOF(ISTOF + 21)
      Qmeas    = STOF(ISTOF + 22)
      Fmeas    = STOF(ISTOF + 26)
      RT_6     = STOF(ISTOF + 27)
      RT_7     = STOF(ISTOF + 28)
      RT_8     = STOF(ISTOF + 29)
      RT_9     = STOF(ISTOF + 30)
      RT_10    = STOF(ISTOF + 31)
      RT_11    = STOF(ISTOF + 32)
      Qcontrol = STOF(ISTOF + 33)
      RT_12    = STOF(ISTOF + 34)
      RT_13    = STOF(ISTOF + 35)
      RT_14    = STOF(ISTOF + 36)
      RT_15    = STOF(ISTOF + 37)
      RT_16    = STOF(ISTOF + 38)
      RT_17    = STOF(ISTOF + 39)
      VRMS     = STOF(ISTOF + 40)
      VRMSF    = STOF(ISTOF + 41)
      L_Load   = STOF(ISTOF + 42)
      R_Load   = STOF(ISTOF + 43)
      Vpcc     = STOF(ISTOF + 47)
      Pg       = STOF(ISTOF + 48)
      Ig       = STOF(ISTOF + 49)
      Qg       = STOF(ISTOF + 50)
      Wref     = STOF(ISTOF + 51)
      RT_19    = STOF(ISTOF + 52)
      Wsys     = STOF(ISTOF + 53)
      RT_20    = STOF(ISTOF + 54)
      IRMS     = STOF(ISTOF + 58)
      Va       = STOF(ISTOF + 59)
      Vb       = STOF(ISTOF + 60)
      Vc       = STOF(ISTOF + 61)
      PG_      = STOF(ISTOF + 68)
      QG_      = STOF(ISTOF + 69)
      Vrms_bus_pu = STOF(ISTOF + 70)

! Array (1:3) quantities...
      DO IT_0 = 1,3
         Vref_dq(IT_0) = STOF(ISTOF + 4 + IT_0)
         Iinv(IT_0) = STOF(ISTOF + 17 + IT_0)
         RT_5(IT_0) = STOF(ISTOF + 22 + IT_0)
         RT_18(IT_0) = STOF(ISTOF + 43 + IT_0)
         Igrid(IT_0) = STOF(ISTOF + 54 + IT_0)
         Vgrid(IT_0) = STOF(ISTOF + 61 + IT_0)
         V33(IT_0) = STOF(ISTOF + 64 + IT_0)
      END DO


!---------------------------------------
! Electrical Node Lookup 
!---------------------------------------


! Array (1:3) quantities...
      DO IT_0 = 1,3
         NT_9(IT_0) = NODE(INODE + 20 + IT_0)
         NT_10(IT_0) = NODE(INODE + 23 + IT_0)
      END DO

!---------------------------------------
! Configuration of Models 
!---------------------------------------

      IF ( TIMEZERO ) THEN
         FILENAME = 'Converter_16.dta'
         CALL EMTDC_OPENFILE
         SECTION = 'DATADSD:'
         CALL EMTDC_GOTOSECTION
      ENDIF
!---------------------------------------
! Generated code from module definition 
!---------------------------------------


! 20:[var] Variable Input Slider 'KPg'
      Pg = CX(CXMAP(ICX+1))

! 30:[var] Variable Input Slider 'Pref'
      Pref_ = CX(CXMAP(ICX+2))

! 40:[var] Variable Input Slider 'KQg'
      Qg = CX(CXMAP(ICX+3))

! 50:[var] Variable Input Slider 'Qref'
      Qref_ = CX(CXMAP(ICX+4))

! 60:[var] Variable Input Slider 'KIg'
      Ig = CX(CXMAP(ICX+5))

! 70:[const] Real Constant 
      RT_13 = 0.0

! 80:[const] Real Constant 
      RT_12 = 0.5

! 90:[var] Variable Input Slider 'Wref'
      Wref = CX(CXMAP(ICX+6))

! 100:[time-sig] Output of Simulation Time 
      RT_14 = TIME

! 110:[const] Real Constant 
      RT_15 = 2.0

! 120:[var] Variable Input Slider 'Vpcc'
      Vpcc = CX(CXMAP(ICX+7))

! 130:[var_switch] Two State Switch 'Qcontrol'
      Qcontrol = CX(CXMAP(ICX+8))

! 140:[var] Variable Input Slider 'R_Load'
      R_Load = CX(CXMAP(ICX+9))

! 150:[emtconst] Commonly Used Constants (pi...) 
      RT_20 = TWO_PI

! 160:[var] Variable Input Slider 'L_Load'
      L_Load = CX(CXMAP(ICX+10))

! 170:[const] Real Constant 
      RT_4 = 20.0

! 180:[emtconst] Commonly Used Constants (pi...) 
      RT_7 = TWO_PI

! 240:[const] Real Constant 
      RT_3 = 5.0

! 250:[xfmr-3p2w] 3 Phase 2 Winding Transformer 
!  TRANSFORMER SATURATION SUBROUTINE
      IVD1_1 = NEXC
      CALL TSAT2_EXE((IXFMR + 1),(IXFMR + 2),(IXFMR + 3), (IBRCH(1)+19),&
     & (IBRCH(1)+20), (IBRCH(1)+21), (IBRCH(1)+22), (IBRCH(1)+23), (IBRC&
     &H(1)+24),0,0,0,0,0,0,SS(1),0,1.0,0)

! 270:[var_switch] Two State Switch 'Constant VF control'
      RT_1 = CX(CXMAP(ICX+11))

! 280:[LLTX_SCALER_pu_2]  
!
!
!

      IF(TIMEZERO) THEN
        STORF(NSTORF)=DELT/(0.015*(V_HV*V_HV/2.0)/(TWO_PI*60.0))
      ENDIF
      Yc  = STORF(NSTORF)
      Ycm = UN*Yc

      Hka_n_1 =  STORF(NSTORF+1)
      Hkb_n_1 =  STORF(NSTORF+2)
      Hkc_n_1 =  STORF(NSTORF+3)
      !
      Hma_n_1 =  STORF(NSTORF+4)
      Hmb_n_1 =  STORF(NSTORF+5)
      Hmc_n_1 =  STORF(NSTORF+6)
      !
      ! History current calclulation is done for one loss loss line segment
      Hma_n = 2*VDC(NT_10(1),SS(1))*Yc - Hka_n_1
      Hmb_n = 2*VDC(NT_10(2),SS(1))*Yc - Hkb_n_1
      Hmc_n = 2*VDC(NT_10(3),SS(1))*Yc - Hkc_n_1
      !
      Hka_n = 2*VDC(NT_9(1),SS(1))*Yc - Hma_n_1
      Hkb_n = 2*VDC(NT_9(2),SS(1))*Yc - Hmb_n_1
      Hkc_n = 2*VDC(NT_9(3),SS(1))*Yc - Hmc_n_1
      ! History current is saved for the next time step
      STORF(NSTORF+1)= Hka_n
      STORF(NSTORF+2)= Hkb_n
      STORF(NSTORF+3)= Hkc_n
      !
      STORF(NSTORF+4)= Hma_n
      STORF(NSTORF+5)= Hmb_n
      STORF(NSTORF+6)= Hmc_n

! Ensure main program records CCIN current injections at these nodes
      IF ( TIMEZERO ) THEN
         ENABCCIN(NT_10(1), SS(1)) = .TRUE.
         ENABCCIN(NT_10(2), SS(1)) = .TRUE.
         ENABCCIN(NT_10(3), SS(1)) = .TRUE.
!
         ENABCCIN(NT_9(1), SS(1)) = .TRUE.
         ENABCCIN(NT_9(2), SS(1)) = .TRUE.
         ENABCCIN(NT_9(3), SS(1)) = .TRUE.
      ENDIF

! If 'SCL' number of parallel loss less lines are assumed. To save computation time only one unit (e.g. wind turbine) is simulated at k th side.
!If side m has 'SCL' number of parallel lossless lines connected together. Total impedance is Zc/SCL and total current injection is Hm*SCAL
      CCIN(NT_10(1),SS(1)) = CCIN(NT_10(1),SS(1)) + Hka_n
      CCIN(NT_10(2),SS(1)) = CCIN(NT_10(2),SS(1)) + Hkb_n
      CCIN(NT_10(3),SS(1)) = CCIN(NT_10(3),SS(1)) + Hkc_n
!
      GGIN(NT_10(1),SS(1)) = GGIN(NT_10(1),SS(1)) + Yc
      GGIN(NT_10(2),SS(1)) = GGIN(NT_10(2),SS(1)) + Yc
      GGIN(NT_10(3),SS(1)) = GGIN(NT_10(3),SS(1)) + Yc
!
!m Side current injection Scaled up by SCL
      CCIN(NT_9(1),SS(1)) = CCIN(NT_9(1),SS(1)) + UN*Hma_n
      CCIN(NT_9(2),SS(1)) = CCIN(NT_9(2),SS(1)) + UN*Hmb_n
      CCIN(NT_9(3),SS(1)) = CCIN(NT_9(3),SS(1)) + UN*Hmc_n
!
!m Side Condutance Scaled down by SCL
      GGIN(NT_9(1),SS(1)) = GGIN(NT_9(1),SS(1)) + Ycm
      GGIN(NT_9(2),SS(1)) = GGIN(NT_9(2),SS(1)) + Ycm
      GGIN(NT_9(3),SS(1)) = GGIN(NT_9(3),SS(1)) + Ycm

      NSTORF = NSTORF + 7

! 300:[Filter_L_1_1_1]  
      CALL Filter_L_1_1_1Dyn(0, 0.000621, 700.0, 700.0, 1.332, 900.0, 0.&
     &000835)


! 360:[mult] Multiplier 
      RT_2 = Fmeas * RT_7

! 370:[PQ_control_10]  
      CALL PQ_control_10Dyn(UFqref, Wint, Wref, Qref_, Pref_, Q, P, Pg, &
     &Ig, Qg, Vpcc, RT_1, VRMSF, RT_2, Qcontrol, RT_3, RT_4, 0.69, 376.9&
     &91)


! 380:[VF_Control_7]  
      CALL VF_Control_7Dyn(Vref_dq, Igrid, Vgrid, Iinv, Wint, UFqref, Ws&
     &ys, P, Q, Wref, 0.69, 1.6735, 376.991, 0.000835, 0.0007)


! 390:[div] Divider 
      IF (ABS(RT_20) .LT. 1.0E-100) THEN
         IF (RT_20 .LT. 0.0)  THEN
            RT_19 = -1.0E100 * Wsys
         ELSE
            RT_19 =  1.0E100 * Wsys
         ENDIF
      ELSE
         RT_19 = Wsys / RT_20
      ENDIF

! 400:[gain] Gain Block 
!  Gain
      RT_18 = 0.001 * Vref_dq

! 410:[gain] Gain Block 
!  Gain
      RT_5 = 0.001 * Vref_dq

! 430:[pgb] Output Channel 'Pdq'

      PGB(IPGB+1) = P

! 440:[Converter_15]  
      CALL Converter_15Dyn(Vref_dq)


! 450:[datatap] Scalar/Array Tap 
      Va = Vref_dq(1)

! 460:[datatap] Scalar/Array Tap 
      Vb = Vref_dq(2)

! 470:[datatap] Scalar/Array Tap 
      Vc = Vref_dq(3)

! 480:[pgb] Output Channel 'Frequency_int'

      PGB(IPGB+2) = RT_19

! 500:[pgb] Output Channel 'VA_Ref'

      DO IVD1_1 = 1, 3
         PGB(IPGB+4+IVD1_1-1) = RT_18(IVD1_1)
      ENDDO

! 530:[pgb] Output Channel 'VA_Ref'

      DO IVD1_1 = 1, 3
         PGB(IPGB+11+IVD1_1-1) = RT_5(IVD1_1)
      ENDDO

! 540:[compar] Two Input Comparator 
!
      CALL EMTDC_X2COMP(0,0,RT_14,RT_15,1.0,0.0,0.0,RVD2_1)
      RT_16 = RVD2_1(1)

! 560:[select] Two Input Selector 
      IF (NINT(RT_16) .EQ. RTCI(NRTCI)) THEN
         RT_17 = RT_13
      ELSE
         RT_17 = RT_12
      ENDIF
      NRTCI = NRTCI + 1
!

!---------------------------------------
! Feedbacks and transfers to storage 
!---------------------------------------

      STOF(ISTOF + 1) = Pref
      STOF(ISTOF + 2) = Qref
      STOF(ISTOF + 3) = UN
      STOF(ISTOF + 4) = V_HV
      STOF(ISTOF + 8) = UFqref
      STOF(ISTOF + 9) = Wint
      STOF(ISTOF + 10) = Qref_
      STOF(ISTOF + 11) = Pref_
      STOF(ISTOF + 12) = Q
      STOF(ISTOF + 13) = P
      STOF(ISTOF + 14) = RT_1
      STOF(ISTOF + 15) = RT_2
      STOF(ISTOF + 16) = RT_3
      STOF(ISTOF + 17) = RT_4
      STOF(ISTOF + 21) = Pmeas
      STOF(ISTOF + 22) = Qmeas
      STOF(ISTOF + 26) = Fmeas
      STOF(ISTOF + 27) = RT_6
      STOF(ISTOF + 28) = RT_7
      STOF(ISTOF + 29) = RT_8
      STOF(ISTOF + 30) = RT_9
      STOF(ISTOF + 31) = RT_10
      STOF(ISTOF + 32) = RT_11
      STOF(ISTOF + 33) = Qcontrol
      STOF(ISTOF + 34) = RT_12
      STOF(ISTOF + 35) = RT_13
      STOF(ISTOF + 36) = RT_14
      STOF(ISTOF + 37) = RT_15
      STOF(ISTOF + 38) = RT_16
      STOF(ISTOF + 39) = RT_17
      STOF(ISTOF + 40) = VRMS
      STOF(ISTOF + 41) = VRMSF
      STOF(ISTOF + 42) = L_Load
      STOF(ISTOF + 43) = R_Load
      STOF(ISTOF + 47) = Vpcc
      STOF(ISTOF + 48) = Pg
      STOF(ISTOF + 49) = Ig
      STOF(ISTOF + 50) = Qg
      STOF(ISTOF + 51) = Wref
      STOF(ISTOF + 52) = RT_19
      STOF(ISTOF + 53) = Wsys
      STOF(ISTOF + 54) = RT_20
      STOF(ISTOF + 58) = IRMS
      STOF(ISTOF + 59) = Va
      STOF(ISTOF + 60) = Vb
      STOF(ISTOF + 61) = Vc
      STOF(ISTOF + 68) = PG_
      STOF(ISTOF + 69) = QG_
      STOF(ISTOF + 70) = Vrms_bus_pu

! Array (1:3) quantities...
      DO IT_0 = 1,3
         STOF(ISTOF + 4 + IT_0) = Vref_dq(IT_0)
         STOF(ISTOF + 17 + IT_0) = Iinv(IT_0)
         STOF(ISTOF + 22 + IT_0) = RT_5(IT_0)
         STOF(ISTOF + 43 + IT_0) = RT_18(IT_0)
         STOF(ISTOF + 54 + IT_0) = Igrid(IT_0)
         STOF(ISTOF + 61 + IT_0) = Vgrid(IT_0)
         STOF(ISTOF + 64 + IT_0) = V33(IT_0)
      END DO


!---------------------------------------
! Transfer to Exports
!---------------------------------------

!---------------------------------------
! Close Model Data read 
!---------------------------------------

      IF ( TIMEZERO ) CALL EMTDC_CLOSEFILE
      RETURN
      END

!=======================================================================

      SUBROUTINE Converter_16Out()

!---------------------------------------
! Standard includes 
!---------------------------------------

      INCLUDE 'nd.h'
      INCLUDE 'emtconst.h'
      INCLUDE 'emtstor.h'
      INCLUDE 's0.h'
      INCLUDE 's1.h'
      INCLUDE 's2.h'
      INCLUDE 's4.h'
      INCLUDE 'branches.h'
      INCLUDE 'pscadv3.h'
      INCLUDE 'fnames.h'
      INCLUDE 'radiolinks.h'
      INCLUDE 'matlab.h'
      INCLUDE 'rtconfig.h'

!---------------------------------------
! Function/Subroutine Declarations 
!---------------------------------------

      REAL    EMTDC_VVDC    ! 
      REAL    P3PH3         ! 
      REAL    Q3PH3         ! 
      REAL    VM3PH2        ! '3 Phase RMS Voltage Measurement'
      REAL    RMS3PH        ! '3 Phase RMS Measurement'
      REAL    REALPOLE      ! 
!     SUBR    DGTL_RMS3     ! '3 Phase Digital RMS Meter'
!     SUBR    Filter_L_1_1_1Out  ! 
!     SUBR    PQ_control_10Out  ! 
!     SUBR    VF_Control_7Out  ! 
!     SUBR    Converter_15Out  ! 

!---------------------------------------
! Variable Declarations 
!---------------------------------------


! Electrical Node Indices
      INTEGER  NT_3(3), NT_8(3), NT_9(3)

! Control Signals
      REAL     RT_3, RT_4, Iinv(3), Pmeas, Qmeas
      REAL     Fmeas, RT_6, RT_7, RT_8, RT_9
      REAL     RT_10, RT_11, RT_12, RT_13, RT_15
      REAL     VRMS, VRMSF, RT_20, Igrid(3), IRMS
      REAL     Vgrid(3), V33(3), PG_, QG_
      REAL     Vrms_bus_pu

! Internal Variables
      INTEGER  IVD1_1
      REAL     RVD1_1, RVD1_2, RVD1_3

! Indexing variables
      INTEGER ICALL_NO                            ! Module call num
      INTEGER ISTOL, ISTOI, ISTOF, ISTOC, IT_0    ! Storage Indices
      INTEGER IPGB                                ! Control/Monitoring
      INTEGER ISUBS, SS(2), IBRCH(2), INODE       ! SS/Node/Branch/Xfmr
      INTEGER IXFMR


!---------------------------------------
! Local Indices 
!---------------------------------------

! Dsdyn <-> Dsout transfer index storage

      NTXFR = NTXFR + 1

      ISTOL = TXFR(NTXFR,1)
      ISTOI = TXFR(NTXFR,2)
      ISTOF = TXFR(NTXFR,3)
      ISTOC = TXFR(NTXFR,4)

! Increment and assign runtime configuration call indices

      ICALL_NO  = NCALL_NO
      NCALL_NO  = NCALL_NO + 1

! Increment global storage indices

      IPGB      = NPGB
      NPGB      = NPGB + 22
      NCX       = NCX + 0
      INODE     = NNODE + 2
      NNODE     = NNODE + 29
      IXFMR     = NXFMR
      NXFMR     = NXFMR + 3
      NCSCS     = NCSCS + 0
      NCSCR     = NCSCR + 0

! Initialize Subsystem Mapping

      ISUBS = NSUBS + 0
      NSUBS = NSUBS + 2

      DO IT_0 = 1,2
         SS(IT_0) = SUBS(ISUBS + IT_0)
      END DO

! Initialize Branch Mapping.

      IBRCH(1)     = NBRCH(SS(1))
      NBRCH(SS(1)) = NBRCH(SS(1)) + 28


      IBRCH(2)     = NBRCH(SS(2))
      NBRCH(SS(2)) = NBRCH(SS(2)) + 1

!---------------------------------------
! Transfers from storage arrays 
!---------------------------------------

      RT_3     = STOF(ISTOF + 16)
      RT_4     = STOF(ISTOF + 17)
      Pmeas    = STOF(ISTOF + 21)
      Qmeas    = STOF(ISTOF + 22)
      Fmeas    = STOF(ISTOF + 26)
      RT_6     = STOF(ISTOF + 27)
      RT_7     = STOF(ISTOF + 28)
      RT_8     = STOF(ISTOF + 29)
      RT_9     = STOF(ISTOF + 30)
      RT_10    = STOF(ISTOF + 31)
      RT_11    = STOF(ISTOF + 32)
      RT_12    = STOF(ISTOF + 34)
      RT_13    = STOF(ISTOF + 35)
      RT_15    = STOF(ISTOF + 37)
      VRMS     = STOF(ISTOF + 40)
      VRMSF    = STOF(ISTOF + 41)
      RT_20    = STOF(ISTOF + 54)
      IRMS     = STOF(ISTOF + 58)
      PG_      = STOF(ISTOF + 68)
      QG_      = STOF(ISTOF + 69)
      Vrms_bus_pu = STOF(ISTOF + 70)

! Array (1:3) quantities...
      DO IT_0 = 1,3
         Iinv(IT_0) = STOF(ISTOF + 17 + IT_0)
         Igrid(IT_0) = STOF(ISTOF + 54 + IT_0)
         Vgrid(IT_0) = STOF(ISTOF + 61 + IT_0)
         V33(IT_0) = STOF(ISTOF + 64 + IT_0)
      END DO


!---------------------------------------
! Electrical Node Lookup 
!---------------------------------------


! Array (1:3) quantities...
      DO IT_0 = 1,3
         NT_3(IT_0) = NODE(INODE + 9 + IT_0)
         NT_8(IT_0) = NODE(INODE + 17 + IT_0)
         NT_9(IT_0) = NODE(INODE + 20 + IT_0)
      END DO

!---------------------------------------
! Configuration of Models 
!---------------------------------------

      IF ( TIMEZERO ) THEN
         FILENAME = 'Converter_16.dta'
         CALL EMTDC_OPENFILE
         SECTION = 'DATADSO:'
         CALL EMTDC_GOTOSECTION
      ENDIF
!---------------------------------------
! Generated code from module definition 
!---------------------------------------


! 70:[const] Real Constant 

      RT_13 = 0.0

! 80:[const] Real Constant 

      RT_12 = 0.5

! 110:[const] Real Constant 

      RT_15 = 2.0

! 150:[emtconst] Commonly Used Constants (pi...) 
      RT_20 = TWO_PI

! 170:[const] Real Constant 

      RT_4 = 20.0

! 180:[emtconst] Commonly Used Constants (pi...) 
      RT_7 = TWO_PI

! 210:[multimeter] Multimeter 
      IVD1_1 = NRTCF
      NRTCF  = NRTCF + 5
      Iinv(1) = ( CBR((IBRCH(1)+1), SS(1)))
      Iinv(2) = ( CBR((IBRCH(1)+2), SS(1)))
      Iinv(3) = ( CBR((IBRCH(1)+3), SS(1)))
      Vgrid(1) = EMTDC_VVDC(SS(1), NT_3(1), 0)
      Vgrid(2) = EMTDC_VVDC(SS(1), NT_3(2), 0)
      Vgrid(3) = EMTDC_VVDC(SS(1), NT_3(3), 0)
      RVD1_1 = RTCF(IVD1_1) * P3PH3(SS(1), (IBRCH(1)+1), (IBRCH(1)+2), (&
     &IBRCH(1)+3),RTCF(IVD1_1+2),0)
      IF (UPDATE_AG) CALL PSCAD_AGR2(ICALL_NO,292820506,RVD1_1,"Pd")
      Pmeas = RVD1_1
      RVD1_1 = RTCF(IVD1_1) * Q3PH3(SS(1), (IBRCH(1)+1), (IBRCH(1)+2), (&
     &IBRCH(1)+3),RTCF(IVD1_1+2),0)
      IF (UPDATE_AG) CALL PSCAD_AGR2(ICALL_NO,292820506,RVD1_1,"Qd")
      Qmeas = RVD1_1
      RVD1_1 = RTCF(IVD1_1+1) * VM3PH2(SS(1), NT_3(1), NT_3(2), NT_3(3),&
     & RTCF(IVD1_1+2))
      IF (UPDATE_AG) CALL PSCAD_AGR2(ICALL_NO,292820506,RVD1_1,"Vd")
      VRMS = RVD1_1
      RVD1_1 = RMS3PH(( CBR((IBRCH(1)+1), SS(1))),( CBR((IBRCH(1)+2), SS&
     &(1))),( CBR((IBRCH(1)+3), SS(1))))
      RVD1_1 = REALPOLE(0,1,0,RTCF(IVD1_1+4),RTCF(IVD1_1+2),RVD1_1,0.0,0&
     &.0,RTCF(IVD1_1+2))
      IRMS = RVD1_1
      IF (FIRSTSTEP) THEN
        CALL PSCAD_AGI2(ICALL_NO,292820506,1,"hide1")
        CALL PSCAD_AGI2(ICALL_NO,292820506,1,"hide2")
      ENDIF

! 230:[ammeter] Current Meter 'Igrid'
      Igrid(1) = ( CBR((IBRCH(1)+4), SS(1)))
      Igrid(2) = ( CBR((IBRCH(1)+5), SS(1)))
      Igrid(3) = ( CBR((IBRCH(1)+6), SS(1)))

! 240:[const] Real Constant 

      RT_3 = 5.0

! 260:[multimeter] Multimeter 
      IVD1_1 = NRTCF
      NRTCF  = NRTCF + 5
      V33(1) = EMTDC_VVDC(SS(1), NT_8(1), 0)
      V33(2) = EMTDC_VVDC(SS(1), NT_8(2), 0)
      V33(3) = EMTDC_VVDC(SS(1), NT_8(3), 0)
      RVD1_1 = RTCF(IVD1_1) * P3PH3(SS(1), (IBRCH(1)+10), (IBRCH(1)+11),&
     & (IBRCH(1)+12),RTCF(IVD1_1+2),0)
      IF (UPDATE_AG) CALL PSCAD_AGR2(ICALL_NO,889511427,RVD1_1,"Pd")
      PG_ = RVD1_1
      RVD1_1 = RTCF(IVD1_1) * Q3PH3(SS(1), (IBRCH(1)+10), (IBRCH(1)+11),&
     & (IBRCH(1)+12),RTCF(IVD1_1+2),0)
      IF (UPDATE_AG) CALL PSCAD_AGR2(ICALL_NO,889511427,RVD1_1,"Qd")
      QG_ = RVD1_1
      CALL DGTL_RMS3(256,SS(1),NT_8(1),NT_8(2),NT_8(3),RTCF(IVD1_1+3),1.&
     &0,0.0,RVD1_1)
      RVD1_1 = RTCF(IVD1_1+1)*RVD1_1
      IF (UPDATE_AG) CALL PSCAD_AGR2(ICALL_NO,889511427,RVD1_1,"Vd")
      Vrms_bus_pu = RVD1_1
      IF (FIRSTSTEP) THEN
        CALL PSCAD_AGI2(ICALL_NO,889511427,1,"hide1")
        CALL PSCAD_AGI2(ICALL_NO,889511427,1,"hide2")
      ENDIF

! 290:[multimeter] Multimeter 
      IVD1_1 = NRTCF
      NRTCF  = NRTCF + 5
      RVD1_1 = RTCF(IVD1_1) * P3PH3(SS(1), (IBRCH(1)+7), (IBRCH(1)+8), (&
     &IBRCH(1)+9),RTCF(IVD1_1+2),0)
      IF (UPDATE_AG) CALL PSCAD_AGR2(ICALL_NO,893807234,RVD1_1,"Pd")
      RVD1_1 = RTCF(IVD1_1) * Q3PH3(SS(1), (IBRCH(1)+7), (IBRCH(1)+8), (&
     &IBRCH(1)+9),RTCF(IVD1_1+2),0)
      IF (UPDATE_AG) CALL PSCAD_AGR2(ICALL_NO,893807234,RVD1_1,"Qd")
      RVD1_1 = RTCF(IVD1_1+1) * VM3PH2(SS(1), NT_9(1), NT_9(2), NT_9(3),&
     & RTCF(IVD1_1+2))
      IF (UPDATE_AG) CALL PSCAD_AGR2(ICALL_NO,893807234,RVD1_1,"Vd")
      IF (FIRSTSTEP) THEN
        CALL PSCAD_AGI2(ICALL_NO,893807234,1,"hide1")
        CALL PSCAD_AGI2(ICALL_NO,893807234,1,"hide2")
      ENDIF

! 300:[Filter_L_1_1_1]  
      CALL Filter_L_1_1_1Out()


! 310:[realpole] Real Pole 
!  Real_Pole
      VRMSF = REALPOLE(0,1,0,1.0,0.02,VRMS,0.0,-1.0E20,1.0E20)

! 320:[datatap] Scalar/Array Tap 
      RT_8 = Vgrid(1)

! 330:[datatap] Scalar/Array Tap 
      RT_9 = Vgrid(2)

! 340:[datatap] Scalar/Array Tap 
      RT_10 = Vgrid(3)

! 350:[tvekta] Phase-Locked Loop 
      RVD1_1 = 0.0*PI_BY180
      CALL COMPONENT_ID(ICALL_NO,965234578)
      CALL TVEKA1_EXE(RT_8,RT_9,RT_10,50.0,900.0,RVD1_1,0.05,1.2,0.8,RT_&
     &11,RVD1_3,RVD1_2)
      RT_11 = RT_11*BY180_PI
      Fmeas = RVD1_2
!

! 370:[PQ_control_10]  
      CALL PQ_control_10Out()


! 380:[VF_Control_7]  
      CALL VF_Control_7Out()


! 420:[realpole] Real Pole 
!  Real_Pole
      RT_6 = REALPOLE(0,1,0,1.0,0.02,Fmeas,0.0,-1.0E20,1.0E20)

! 440:[Converter_15]  
      CALL Converter_15Out()


! 490:[pgb] Output Channel 'Pmeas'

      PGB(IPGB+3) = Pmeas

! 510:[pgb] Output Channel 'Qmeas'

      PGB(IPGB+7) = Qmeas

! 520:[pgb] Output Channel 'Igrid'

      DO IVD1_1 = 1, 3
         PGB(IPGB+8+IVD1_1-1) = Igrid(IVD1_1)
      ENDDO

! 550:[pgb] Output Channel 'Irms'

      PGB(IPGB+14) = IRMS

! 570:[pgb] Output Channel 'I_inverter'

      DO IVD1_1 = 1, 3
         PGB(IPGB+15+IVD1_1-1) = Iinv(IVD1_1)
      ENDDO

! 580:[pgb] Output Channel 'Fmeas'

      PGB(IPGB+18) = RT_6

! 590:[pgb] Output Channel 'Vgrid'

      DO IVD1_1 = 1, 3
         PGB(IPGB+19+IVD1_1-1) = Vgrid(IVD1_1)
      ENDDO

! 600:[pgb] Output Channel 'V_rms'

      PGB(IPGB+22) = VRMSF

!---------------------------------------
! Feedbacks and transfers to storage 
!---------------------------------------

      STOF(ISTOF + 16) = RT_3
      STOF(ISTOF + 17) = RT_4
      STOF(ISTOF + 21) = Pmeas
      STOF(ISTOF + 22) = Qmeas
      STOF(ISTOF + 26) = Fmeas
      STOF(ISTOF + 27) = RT_6
      STOF(ISTOF + 28) = RT_7
      STOF(ISTOF + 29) = RT_8
      STOF(ISTOF + 30) = RT_9
      STOF(ISTOF + 31) = RT_10
      STOF(ISTOF + 32) = RT_11
      STOF(ISTOF + 34) = RT_12
      STOF(ISTOF + 35) = RT_13
      STOF(ISTOF + 37) = RT_15
      STOF(ISTOF + 40) = VRMS
      STOF(ISTOF + 41) = VRMSF
      STOF(ISTOF + 54) = RT_20
      STOF(ISTOF + 58) = IRMS
      STOF(ISTOF + 68) = PG_
      STOF(ISTOF + 69) = QG_
      STOF(ISTOF + 70) = Vrms_bus_pu

! Array (1:3) quantities...
      DO IT_0 = 1,3
         STOF(ISTOF + 17 + IT_0) = Iinv(IT_0)
         STOF(ISTOF + 54 + IT_0) = Igrid(IT_0)
         STOF(ISTOF + 61 + IT_0) = Vgrid(IT_0)
         STOF(ISTOF + 64 + IT_0) = V33(IT_0)
      END DO


!---------------------------------------
! Close Model Data read 
!---------------------------------------

      IF ( TIMEZERO ) CALL EMTDC_CLOSEFILE
      RETURN
      END

!=======================================================================

      SUBROUTINE Converter_16Dyn_Begin(UN, V_HV)

!---------------------------------------
! Standard includes 
!---------------------------------------

      INCLUDE 'nd.h'
      INCLUDE 'emtconst.h'
      INCLUDE 's0.h'
      INCLUDE 's1.h'
      INCLUDE 's4.h'
      INCLUDE 'branches.h'
      INCLUDE 'pscadv3.h'
      INCLUDE 'radiolinks.h'
      INCLUDE 'rtconfig.h'

!---------------------------------------
! Function/Subroutine Declarations 
!---------------------------------------

!     SUBR    Filter_L_1_1_1Dyn_Begin  ! 
!     SUBR    PQ_control_10Dyn_Begin  ! 
!     SUBR    VF_Control_7Dyn_Begin  ! 
!     SUBR    Converter_15Dyn_Begin  ! 

!---------------------------------------
! Variable Declarations 
!---------------------------------------


! Subroutine Arguments
      REAL,    INTENT(IN)  :: UN, V_HV

! Electrical Node Indices

! Control Signals
      REAL     RT_3, RT_4, RT_7, RT_12, RT_13
      REAL     RT_15, RT_20

! Internal Variables
      INTEGER  IVD1_1
      REAL     RVD1_1, RVD1_2, RVD1_3, RVD1_4
      REAL     RVD1_5, RVD1_6

! Indexing variables
      INTEGER ICALL_NO                            ! Module call num
      INTEGER IT_0                                ! Storage Indices
      INTEGER ICX                                 ! Control/Monitoring
      INTEGER ISUBS, SS(2), IBRCH(2), INODE       ! SS/Node/Branch/Xfmr
      INTEGER IXFMR


!---------------------------------------
! Local Indices 
!---------------------------------------


! Increment and assign runtime configuration call indices

      ICALL_NO  = NCALL_NO
      NCALL_NO  = NCALL_NO + 1

! Increment global storage indices

      ICX       = NCX
      NCX       = NCX + 11
      INODE     = NNODE + 2
      NNODE     = NNODE + 29
      IXFMR     = NXFMR
      NXFMR     = NXFMR + 3
      NCSCS     = NCSCS + 0
      NCSCR     = NCSCR + 0

! Initialize Subsystem Mapping

      ISUBS = NSUBS + 0
      NSUBS = NSUBS + 2

      DO IT_0 = 1,2
         SS(IT_0) = SUBS(ISUBS + IT_0)
      END DO

! Initialize Branch Mapping.

      IBRCH(1)     = NBRCH(SS(1))
      NBRCH(SS(1)) = NBRCH(SS(1)) + 28


      IBRCH(2)     = NBRCH(SS(2))
      NBRCH(SS(2)) = NBRCH(SS(2)) + 1

!---------------------------------------
! Electrical Node Lookup 
!---------------------------------------


!---------------------------------------
! Generated code from module definition 
!---------------------------------------


! 20:[var] Variable Input Slider 'KPg'

! 30:[var] Variable Input Slider 'Pref'

! 40:[var] Variable Input Slider 'KQg'

! 50:[var] Variable Input Slider 'Qref'

! 60:[var] Variable Input Slider 'KIg'

! 70:[const] Real Constant 
      RT_13 = 0.0

! 80:[const] Real Constant 
      RT_12 = 0.5

! 90:[var] Variable Input Slider 'Wref'

! 100:[time-sig] Output of Simulation Time 

! 110:[const] Real Constant 
      RT_15 = 2.0

! 120:[var] Variable Input Slider 'Vpcc'

! 130:[var_switch] Two State Switch 'Qcontrol'

! 140:[var] Variable Input Slider 'R_Load'

! 150:[emtconst] Commonly Used Constants (pi...) 
      RT_20 = TWO_PI

! 160:[var] Variable Input Slider 'L_Load'

! 170:[const] Real Constant 
      RT_4 = 20.0

! 180:[emtconst] Commonly Used Constants (pi...) 
      RT_7 = TWO_PI

! 240:[const] Real Constant 
      RT_3 = 5.0

! 250:[xfmr-3p2w] 3 Phase 2 Winding Transformer 
      CALL COMPONENT_ID(ICALL_NO,1490916351)
      RVD1_1 = ONE_3RD*2.0
      RVD1_2 = V_HV*SQRT_1BY3
      RVD1_3 = 0.69*SQRT_1BY3
      CALL E_TF2W_CFG((IXFMR + 1),1,RVD1_1,60.0,0.035,0.0,RVD1_2,RVD1_3,&
     &0.4)
      CALL E_TF2W_CFG((IXFMR + 2),1,RVD1_1,60.0,0.035,0.0,RVD1_2,RVD1_3,&
     &0.4)
      CALL E_TF2W_CFG((IXFMR + 3),1,RVD1_1,60.0,0.035,0.0,RVD1_2,RVD1_3,&
     &0.4)
      IF (0.0 .LT. 1.0E-6) THEN
        RVD1_5 = 0.0
        RVD1_6 = 0.0
        IVD1_1 = 0
      ELSE
        RVD1_6 = 0.0
        RVD1_4 = 6.0/(2.0*RVD1_6)
        RVD1_5 = RVD1_4*RVD1_2*RVD1_2
        RVD1_6 = RVD1_4*RVD1_3*RVD1_3
        IVD1_1 = 1
      ENDIF
      CALL E_BRANCH_CFG( (IBRCH(1)+13),SS(1),IVD1_1,0,0,RVD1_5,0.0,0.0)
      CALL E_BRANCH_CFG( (IBRCH(1)+14),SS(1),IVD1_1,0,0,RVD1_5,0.0,0.0)
      CALL E_BRANCH_CFG( (IBRCH(1)+15),SS(1),IVD1_1,0,0,RVD1_5,0.0,0.0)
      CALL E_BRANCH_CFG( (IBRCH(1)+16),SS(1),IVD1_1,0,0,RVD1_6,0.0,0.0)
      CALL E_BRANCH_CFG( (IBRCH(1)+17),SS(1),IVD1_1,0,0,RVD1_6,0.0,0.0)
      CALL E_BRANCH_CFG( (IBRCH(1)+18),SS(1),IVD1_1,0,0,RVD1_6,0.0,0.0)
      CALL TSAT2_CFG(2, (IBRCH(1)+19), (IBRCH(1)+20), (IBRCH(1)+21), (IB&
     &RCH(1)+22), (IBRCH(1)+23), (IBRCH(1)+24),0,0,0,0,0,0,SS(1),RVD1_1,&
     &0.2,1.17,60.0,0.0,0.4,0.0,0.035,0.0,0.0,0.0,0.0,0.0,RVD1_2,RVD1_3,&
     &0.0,0.0)

! 270:[var_switch] Two State Switch 'Constant VF control'

! 280:[LLTX_SCALER_pu_2]  

! 300:[Filter_L_1_1_1]  
      CALL Filter_L_1_1_1Dyn_Begin(0.000621, 700.0, 700.0, 1.332)


! 360:[mult] Multiplier 

! 370:[PQ_control_10]  
      CALL PQ_control_10Dyn_Begin()


! 380:[VF_Control_7]  
      CALL VF_Control_7Dyn_Begin()


! 390:[div] Divider 

! 400:[gain] Gain Block 

! 410:[gain] Gain Block 

! 430:[pgb] Output Channel 'Pdq'

! 440:[Converter_15]  
      CALL Converter_15Dyn_Begin()


! 450:[datatap] Scalar/Array Tap 

! 460:[datatap] Scalar/Array Tap 

! 470:[datatap] Scalar/Array Tap 

! 480:[pgb] Output Channel 'Frequency_int'

! 500:[pgb] Output Channel 'VA_Ref'

! 530:[pgb] Output Channel 'VA_Ref'

! 540:[compar] Two Input Comparator 

! 560:[select] Two Input Selector 
      RTCI(NRTCI) = 0
      NRTCI = NRTCI + 1

      RETURN
      END

!=======================================================================

      SUBROUTINE Converter_16Out_Begin(UN, V_HV)

!---------------------------------------
! Standard includes 
!---------------------------------------

      INCLUDE 'nd.h'
      INCLUDE 'emtconst.h'
      INCLUDE 's0.h'
      INCLUDE 's1.h'
      INCLUDE 's4.h'
      INCLUDE 'branches.h'
      INCLUDE 'pscadv3.h'
      INCLUDE 'radiolinks.h'
      INCLUDE 'rtconfig.h'

!---------------------------------------
! Function/Subroutine Declarations 
!---------------------------------------

!     SUBR    Filter_L_1_1_1Out_Begin  ! 
!     SUBR    PQ_control_10Out_Begin  ! 
!     SUBR    VF_Control_7Out_Begin  ! 
!     SUBR    Converter_15Out_Begin  ! 

!---------------------------------------
! Variable Declarations 
!---------------------------------------


! Subroutine Arguments
      REAL,    INTENT(IN)  :: UN, V_HV

! Electrical Node Indices
      INTEGER  NT_3(3), NT_8(3)

! Control Signals
      REAL     RT_3, RT_4, RT_7, RT_12, RT_13
      REAL     RT_15, RT_20

! Internal Variables
      INTEGER  IVD1_1

! Indexing variables
      INTEGER ICALL_NO                            ! Module call num
      INTEGER IT_0                                ! Storage Indices
      INTEGER ISUBS, SS(2), IBRCH(2), INODE       ! SS/Node/Branch/Xfmr
      INTEGER IXFMR


!---------------------------------------
! Local Indices 
!---------------------------------------


! Increment and assign runtime configuration call indices

      ICALL_NO  = NCALL_NO
      NCALL_NO  = NCALL_NO + 1

! Increment global storage indices

      NCX       = NCX + 0
      INODE     = NNODE + 2
      NNODE     = NNODE + 29
      IXFMR     = NXFMR
      NXFMR     = NXFMR + 3
      NCSCS     = NCSCS + 0
      NCSCR     = NCSCR + 0

! Initialize Subsystem Mapping

      ISUBS = NSUBS + 0
      NSUBS = NSUBS + 2

      DO IT_0 = 1,2
         SS(IT_0) = SUBS(ISUBS + IT_0)
      END DO

! Initialize Branch Mapping.

      IBRCH(1)     = NBRCH(SS(1))
      NBRCH(SS(1)) = NBRCH(SS(1)) + 28


      IBRCH(2)     = NBRCH(SS(2))
      NBRCH(SS(2)) = NBRCH(SS(2)) + 1

!---------------------------------------
! Electrical Node Lookup 
!---------------------------------------


! Array (1:3) quantities...
      DO IT_0 = 1,3
         NT_3(IT_0) = NODE(INODE + 9 + IT_0)
         NT_8(IT_0) = NODE(INODE + 17 + IT_0)
      END DO

!---------------------------------------
! Generated code from module definition 
!---------------------------------------


! 70:[const] Real Constant 
      RT_13 = 0.0

! 80:[const] Real Constant 
      RT_12 = 0.5

! 110:[const] Real Constant 
      RT_15 = 2.0

! 150:[emtconst] Commonly Used Constants (pi...) 
      RT_20 = TWO_PI

! 170:[const] Real Constant 
      RT_4 = 20.0

! 180:[emtconst] Commonly Used Constants (pi...) 
      RT_7 = TWO_PI

! 210:[multimeter] Multimeter 
      IVD1_1 = NRTCF
      NRTCF  = NRTCF + 5
      IF (ABS(2.0) .GT. 1.0E-20) THEN
        RTCF(IVD1_1) = 1.0/ABS(2.0)
      ELSE
        RTCF(IVD1_1) = 1.0
      ENDIF
      IF (ABS(0.69) .GT. 1.0E-20) THEN
        RTCF(IVD1_1+1) = 1.0/ABS(0.69)
      ELSE
        RTCF(IVD1_1+1) = 1.0
      ENDIF
      RTCF(IVD1_1+2) = 0.002
      IF (ABS(1.6735) .GT. 1.0E-20) THEN
        RTCF(IVD1_1+4) = 1.0/ABS(1.6735)
      ELSE
        RTCF(IVD1_1+4) = 1.0
      ENDIF

! 240:[const] Real Constant 
      RT_3 = 5.0

! 260:[multimeter] Multimeter 
      IVD1_1 = NRTCF
      NRTCF  = NRTCF + 5
      IF (ABS(2.0) .GT. 1.0E-20) THEN
        RTCF(IVD1_1) = 1.0/ABS(2.0)
      ELSE
        RTCF(IVD1_1) = 1.0
      ENDIF
      IF (ABS(V_HV) .GT. 1.0E-20) THEN
        RTCF(IVD1_1+1) = 1.0/ABS(V_HV)
      ELSE
        RTCF(IVD1_1+1) = 1.0
      ENDIF
      RTCF(IVD1_1+2) = 0.02
      RTCF(IVD1_1+3) = 60.0

! 290:[multimeter] Multimeter 
      IVD1_1 = NRTCF
      NRTCF  = NRTCF + 5
      IF (ABS(100.0) .GT. 1.0E-20) THEN
        RTCF(IVD1_1) = 1.0/ABS(100.0)
      ELSE
        RTCF(IVD1_1) = 1.0
      ENDIF
      IF (ABS(V_HV) .GT. 1.0E-20) THEN
        RTCF(IVD1_1+1) = 1.0/ABS(V_HV)
      ELSE
        RTCF(IVD1_1+1) = 1.0
      ENDIF
      RTCF(IVD1_1+2) = 0.02

! 300:[Filter_L_1_1_1]  
      CALL Filter_L_1_1_1Out_Begin(0.000621, 700.0, 700.0, 1.332)


! 310:[realpole] Real Pole 

! 320:[datatap] Scalar/Array Tap 

! 330:[datatap] Scalar/Array Tap 

! 340:[datatap] Scalar/Array Tap 

! 350:[tvekta] Phase-Locked Loop 
      CALL TVEKA1_CFG(1.0,60.0)

! 370:[PQ_control_10]  
      CALL PQ_control_10Out_Begin()


! 380:[VF_Control_7]  
      CALL VF_Control_7Out_Begin()


! 420:[realpole] Real Pole 

! 440:[Converter_15]  
      CALL Converter_15Out_Begin()


! 490:[pgb] Output Channel 'Pmeas'

! 510:[pgb] Output Channel 'Qmeas'

! 520:[pgb] Output Channel 'Igrid'

! 550:[pgb] Output Channel 'Irms'

! 570:[pgb] Output Channel 'I_inverter'

! 580:[pgb] Output Channel 'Fmeas'

! 590:[pgb] Output Channel 'Vgrid'

! 600:[pgb] Output Channel 'V_rms'

      RETURN
      END

