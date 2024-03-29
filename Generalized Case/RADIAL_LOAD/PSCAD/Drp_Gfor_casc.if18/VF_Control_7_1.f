!=======================================================================
! Generated by: PSCAD v5.0.0.0
! Warning:  The content of this file is automatically generated.
!           Do not modify, as any changes made here will be lost!
!-----------------------------------------------------------------------
! Component     : VF_Control_7_1
! Description   : 
!-----------------------------------------------------------------------


!=======================================================================

      SUBROUTINE VF_Control_7_1Dyn(Vref, Igrid, Vgrid, I_inv, W,        &
     &   UFqref, Wgrid, Pdq, Qdq, Wref, VratedLLrms, Iratedphrms,       &
     &   Wrated, Lf, Cf)

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

      REAL    EMTDC_XINT    ! 'Integrator /w Interpolation'
!     SUBR    TRDQO         ! DQ0 transformation
      REAL    EMTDC_XPI     ! 'Proportional-Integral Controller /w Interpolation'
!     SUBR    Current_Limiter_3_1Dyn  ! 
      REAL    REALPOLE      ! Real Pole

!---------------------------------------
! Variable Declarations 
!---------------------------------------


! Subroutine Arguments
      REAL,    INTENT(IN)  :: Igrid(3), Vgrid(3)
      REAL,    INTENT(IN)  :: I_inv(3), W, UFqref
      REAL,    INTENT(IN)  :: Wref, VratedLLrms
      REAL,    INTENT(IN)  :: Iratedphrms, Wrated
      REAL,    INTENT(IN)  :: Lf, Cf
      REAL,    INTENT(OUT) :: Vref(3), Wgrid, Pdq
      REAL,    INTENT(OUT) :: Qdq

! Electrical Node Indices

! Control Signals
      REAL     RT_1, RT_2, RT_3, RT_4, RT_5, RT_6
      REAL     Err, RT_7, RT_8, RT_9, RT_10
      REAL     RT_11, RT_12, RT_13, RT_14, RT_15
      REAL     Ucd, RT_16, Ucq, RT_17, RT_18
      REAL     RT_19, RT_20(3), RT_21, RT_22
      REAL     RT_23, RT_24, RT_25, RT_26, RT_27
      REAL     RT_28, RT_29, RT_30, RT_31, RT_32
      REAL     RT_33, RT_34, RT_35, RT_36
      REAL     Delta_Vc, RT_37, RT_38, Theta_ref
      REAL     RT_39, RT_40, RT_41, RT_42
      REAL     Delta_Vf, RT_43, RT_44, RT_45
      REAL     RT_46, UFq, UFd, IWd, IWq, ISq
      REAL     ISd, Theta, RT_47, RT_48, RT_49
      REAL     RT_50, RT_51(3), RT_52(3), Vbase
      REAL     RT_53(3), Ibase, RT_54, RT_55
      REAL     RT_56, RT_57, RT_58, MVAbase
      REAL     wLf_pu, RT_59, RT_60, wCf_pu
      REAL     Zbase, RT_61, RT_62, Cbase, RT_63
      REAL     RT_64, RT_65, RT_66, RT_67, RT_68
      REAL     RT_69, RT_70, RT_71, RT_72, RT_73
      REAL     RT_74, RT_75, KpI, TiI, RT_76
      REAL     RT_77, KpV, RT_78, RT_79, TiV
      REAL     RT_80, Lbase

! Internal Variables
      REAL     RVD1_1, RVD2_1(2), RVD2_2(2)

! Indexing variables
      INTEGER ICALL_NO                            ! Module call num
      INTEGER ISTOF, IT_0                         ! Storage Indices
      INTEGER IPGB                                ! Control/Monitoring
      INTEGER ISUBS                               ! SS/Node/Branch/Xfmr


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
      NSTOF     = NSTOF + 136
      IPGB      = NPGB
      NPGB      = NPGB + 21
      NNODE     = NNODE + 2
      NCSCS     = NCSCS + 0
      NCSCR     = NCSCR + 0

!---------------------------------------
! Transfers from storage arrays 
!---------------------------------------

      Wgrid    = STOF(ISTOF + 15)
      Pdq      = STOF(ISTOF + 16)
      Qdq      = STOF(ISTOF + 17)
      RT_1     = STOF(ISTOF + 24)
      RT_2     = STOF(ISTOF + 25)
      RT_3     = STOF(ISTOF + 26)
      RT_4     = STOF(ISTOF + 27)
      RT_5     = STOF(ISTOF + 28)
      RT_6     = STOF(ISTOF + 29)
      Err      = STOF(ISTOF + 30)
      RT_7     = STOF(ISTOF + 31)
      RT_8     = STOF(ISTOF + 32)
      RT_9     = STOF(ISTOF + 33)
      RT_10    = STOF(ISTOF + 34)
      RT_11    = STOF(ISTOF + 35)
      RT_12    = STOF(ISTOF + 36)
      RT_13    = STOF(ISTOF + 37)
      RT_14    = STOF(ISTOF + 38)
      RT_15    = STOF(ISTOF + 39)
      Ucd      = STOF(ISTOF + 40)
      RT_16    = STOF(ISTOF + 41)
      Ucq      = STOF(ISTOF + 42)
      RT_17    = STOF(ISTOF + 43)
      RT_18    = STOF(ISTOF + 44)
      RT_19    = STOF(ISTOF + 45)
      RT_21    = STOF(ISTOF + 49)
      RT_22    = STOF(ISTOF + 50)
      RT_23    = STOF(ISTOF + 51)
      RT_24    = STOF(ISTOF + 52)
      RT_25    = STOF(ISTOF + 53)
      RT_26    = STOF(ISTOF + 54)
      RT_27    = STOF(ISTOF + 55)
      RT_28    = STOF(ISTOF + 56)
      RT_29    = STOF(ISTOF + 57)
      RT_30    = STOF(ISTOF + 58)
      RT_31    = STOF(ISTOF + 59)
      RT_32    = STOF(ISTOF + 60)
      RT_33    = STOF(ISTOF + 61)
      RT_34    = STOF(ISTOF + 62)
      RT_35    = STOF(ISTOF + 63)
      RT_36    = STOF(ISTOF + 64)
      Delta_Vc = STOF(ISTOF + 65)
      RT_37    = STOF(ISTOF + 66)
      RT_38    = STOF(ISTOF + 67)
      Theta_ref = STOF(ISTOF + 68)
      RT_39    = STOF(ISTOF + 69)
      RT_40    = STOF(ISTOF + 70)
      RT_41    = STOF(ISTOF + 71)
      RT_42    = STOF(ISTOF + 72)
      Delta_Vf = STOF(ISTOF + 73)
      RT_43    = STOF(ISTOF + 74)
      RT_44    = STOF(ISTOF + 75)
      RT_45    = STOF(ISTOF + 76)
      RT_46    = STOF(ISTOF + 77)
      UFq      = STOF(ISTOF + 78)
      UFd      = STOF(ISTOF + 79)
      IWd      = STOF(ISTOF + 80)
      IWq      = STOF(ISTOF + 81)
      ISq      = STOF(ISTOF + 82)
      ISd      = STOF(ISTOF + 83)
      Theta    = STOF(ISTOF + 84)
      RT_47    = STOF(ISTOF + 85)
      RT_48    = STOF(ISTOF + 86)
      RT_49    = STOF(ISTOF + 87)
      RT_50    = STOF(ISTOF + 88)
      Vbase    = STOF(ISTOF + 95)
      Ibase    = STOF(ISTOF + 99)
      RT_54    = STOF(ISTOF + 100)
      RT_55    = STOF(ISTOF + 101)
      RT_56    = STOF(ISTOF + 102)
      RT_57    = STOF(ISTOF + 103)
      RT_58    = STOF(ISTOF + 104)
      MVAbase  = STOF(ISTOF + 105)
      wLf_pu   = STOF(ISTOF + 106)
      RT_59    = STOF(ISTOF + 107)
      RT_60    = STOF(ISTOF + 108)
      wCf_pu   = STOF(ISTOF + 109)
      Zbase    = STOF(ISTOF + 110)
      RT_61    = STOF(ISTOF + 111)
      RT_62    = STOF(ISTOF + 112)
      Cbase    = STOF(ISTOF + 113)
      RT_63    = STOF(ISTOF + 114)
      RT_64    = STOF(ISTOF + 115)
      RT_65    = STOF(ISTOF + 116)
      RT_66    = STOF(ISTOF + 117)
      RT_67    = STOF(ISTOF + 118)
      RT_68    = STOF(ISTOF + 119)
      RT_69    = STOF(ISTOF + 120)
      RT_70    = STOF(ISTOF + 121)
      RT_71    = STOF(ISTOF + 122)
      RT_72    = STOF(ISTOF + 123)
      RT_73    = STOF(ISTOF + 124)
      RT_74    = STOF(ISTOF + 125)
      RT_75    = STOF(ISTOF + 126)
      KpI      = STOF(ISTOF + 127)
      TiI      = STOF(ISTOF + 128)
      RT_76    = STOF(ISTOF + 129)
      RT_77    = STOF(ISTOF + 130)
      KpV      = STOF(ISTOF + 131)
      RT_78    = STOF(ISTOF + 132)
      RT_79    = STOF(ISTOF + 133)
      TiV      = STOF(ISTOF + 134)
      RT_80    = STOF(ISTOF + 135)
      Lbase    = STOF(ISTOF + 136)

! Array (1:3) quantities...
      DO IT_0 = 1,3
         Vref(IT_0) = STOF(ISTOF + 0 + IT_0)
         RT_20(IT_0) = STOF(ISTOF + 45 + IT_0)
         RT_51(IT_0) = STOF(ISTOF + 88 + IT_0)
         RT_52(IT_0) = STOF(ISTOF + 91 + IT_0)
         RT_53(IT_0) = STOF(ISTOF + 95 + IT_0)
      END DO


!---------------------------------------
! Electrical Node Lookup 
!---------------------------------------


!---------------------------------------
! Configuration of Models 
!---------------------------------------

      IF ( TIMEZERO ) THEN
         FILENAME = 'VF_Control_7_1.dta'
         CALL EMTDC_OPENFILE
         SECTION = 'DATADSD:'
         CALL EMTDC_GOTOSECTION
      ENDIF
!---------------------------------------
! Generated code from module definition 
!---------------------------------------


! 20:[emtconst] Commonly Used Constants (pi...) 
      RT_45 = PI_BY2

! 30:[const] Real Constant 
      RT_36 = 0.0

! 60:[const] Real Constant 
      RT_44 = 0.0

! 70:[const] Real Constant 
      RT_8 = 0.0

! 90:[emtconst] Commonly Used Constants (pi...) 
      RT_40 = PI_BY2

! 100:[const] Real Constant 
      RT_46 = 0.0

! 110:[const] Real Constant 
      RT_11 = 0.0

! 160:[emtconst] Commonly Used Constants (pi...) 
      RT_50 = SQRT_3

! 170:[emtconst] Commonly Used Constants (pi...) 
      RT_49 = SQRT_2

! 180:[const] Real Constant 
      RT_80 = 1.0

! 210:[emtconst] Commonly Used Constants (pi...) 
      RT_47 = SQRT_2

! 230:[emtconst] Commonly Used Constants (pi...) 
      RT_37 = TWO_PI

! 260:[const] Real Constant 
      RT_59 = 1.0

! 280:[emtconst] Commonly Used Constants (pi...) 
      RT_57 = SQRT_3

! 300:[const] Real Constant 
      KpI = 5.0

! 310:[const] Real Constant 
      RT_23 = 1.0

! 320:[const] Real Constant 
      KpV = 1.0

! 330:[const] Real Constant 
      RT_76 = 1.0

! 340:[const] Real Constant 
      RT_79 = 1.0

! 350:[const] Real Constant 
      RT_77 = 5.0

! 360:[const] Real Constant 
      RT_78 = 10.0

! 370:[const] Real Constant 
      RT_22 = 1.0

! 410:[const] Real Constant 
      RT_63 = 1.0

! 430:[gain] Gain Block 
!  Gain
      Wgrid = Wrated * W

! 440:[integral] Interpolated Integrator 
      RVD1_1 = RTCF(NRTCF) ! Initial Output
      NRTCF = NRTCF + 1
      RVD2_1(1) = Wgrid
      RVD2_1(2) = 0.0
      RVD2_2(1) = 0.0
      RVD2_2(2) = 0.0
      Theta = EMTDC_XINT(0, 0, 0, RVD1_1, 1.0, 0.0, -1.0e+22, 1.0e+22, R&
     &VD2_2, RVD2_1)

! 450:[div] Divider 
      IF (ABS(RT_50) .LT. 1.0E-100) THEN
         IF (RT_50 .LT. 0.0)  THEN
            RT_48 = -1.0E100 * VratedLLrms
         ELSE
            RT_48 =  1.0E100 * VratedLLrms
         ENDIF
      ELSE
         RT_48 = VratedLLrms / RT_50
      ENDIF

! 460:[mult] Multiplier 
      Vbase = RT_48 * RT_49

! 470:[square] Square 
      RT_58 = VratedLLrms * VratedLLrms

! 480:[mult] Multiplier 
      Ibase = Iratedphrms * RT_47

! 490:[mult] Multiplier 
      RT_38 = Wref * RT_37

! 500:[integral] Interpolated Integrator 
      RVD1_1 = RTCF(NRTCF) ! Initial Output
      NRTCF = NRTCF + 1
      RVD2_1(1) = RT_38
      RVD2_1(2) = 0.0
      RVD2_2(1) = 0.0
      RVD2_2(2) = 0.0
      Theta_ref = EMTDC_XINT(0, 0, 0, RVD1_1, 1.0, 0.0, -1.0e+22, 1.0e+2&
     &2, RVD2_2, RVD2_1)

! 510:[mult] Multiplier 
      RT_56 = VratedLLrms * Iratedphrms

! 520:[mult] Multiplier 
      MVAbase = RT_56 * RT_57

! 530:[div] Divider 
      IF (ABS(RT_77) .LT. 1.0E-100) THEN
         IF (RT_77 .LT. 0.0)  THEN
            TiI = -1.0E100 * RT_76
         ELSE
            TiI =  1.0E100 * RT_76
         ENDIF
      ELSE
         TiI = RT_76 / RT_77
      ENDIF

! 540:[div] Divider 
      IF (ABS(RT_78) .LT. 1.0E-100) THEN
         IF (RT_78 .LT. 0.0)  THEN
            TiV = -1.0E100 * RT_79
         ELSE
            TiV =  1.0E100 * RT_79
         ENDIF
      ELSE
         TiV = RT_79 / RT_78
      ENDIF

! 550:[gain] Gain Block 
!  Gain
      RT_54 = Wrated * Lf

! 560:[gain] Gain Block 
!  Gain
      RT_55 = Wrated * Cf

! 570:[div] Divider 
      IF (ABS(Ibase) .LT. 1.0E-100) THEN
         IF (Ibase .LT. 0.0)  THEN
            RT_51 = -1.0E100 * I_inv
         ELSE
            RT_51 =  1.0E100 * I_inv
         ENDIF
      ELSE
         RT_51 = I_inv / Ibase
      ENDIF

! 580:[datatap] Scalar/Array Tap 
      RT_64 = RT_51(1)

! 590:[datatap] Scalar/Array Tap 
      RT_65 = RT_51(2)

! 600:[datatap] Scalar/Array Tap 
      RT_66 = RT_51(3)

! 610:[div] Divider 
      IF (ABS(Vbase) .LT. 1.0E-100) THEN
         IF (Vbase .LT. 0.0)  THEN
            RT_52 = -1.0E100 * Vgrid
         ELSE
            RT_52 =  1.0E100 * Vgrid
         ENDIF
      ELSE
         RT_52 = Vgrid / Vbase
      ENDIF

! 620:[datatap] Scalar/Array Tap 
      RT_68 = RT_52(1)

! 630:[datatap] Scalar/Array Tap 
      RT_69 = RT_52(2)

! 640:[datatap] Scalar/Array Tap 
      RT_70 = RT_52(3)

! 650:[div] Divider 
      IF (ABS(Ibase) .LT. 1.0E-100) THEN
         IF (Ibase .LT. 0.0)  THEN
            RT_53 = -1.0E100 * Igrid
         ELSE
            RT_53 =  1.0E100 * Igrid
         ENDIF
      ELSE
         RT_53 = Igrid / Ibase
      ENDIF

! 660:[datatap] Scalar/Array Tap 
      RT_72 = RT_53(1)

! 670:[datatap] Scalar/Array Tap 
      RT_73 = RT_53(2)

! 680:[datatap] Scalar/Array Tap 
      RT_74 = RT_53(3)

! 690:[div] Divider 
      IF (ABS(MVAbase) .LT. 1.0E-100) THEN
         IF (MVAbase .LT. 0.0)  THEN
            Zbase = -1.0E100 * RT_58
         ELSE
            Zbase =  1.0E100 * RT_58
         ENDIF
      ELSE
         Zbase = RT_58 / MVAbase
      ENDIF

! 700:[mult] Multiplier 
      RT_60 = Wrated * Zbase

! 710:[div] Divider 
      IF (ABS(Zbase) .LT. 1.0E-100) THEN
         IF (Zbase .LT. 0.0)  THEN
            wLf_pu = -1.0E100 * RT_54
         ELSE
            wLf_pu =  1.0E100 * RT_54
         ENDIF
      ELSE
         wLf_pu = RT_54 / Zbase
      ENDIF

! 720:[mult] Multiplier 
      wCf_pu = RT_55 * Zbase

! 730:[abcdq0] abc dq0 transformation 
!ABC to DQ0 transformation
      CALL TRDQO(RT_64,RT_65,RT_66,IWd,IWq,RT_67,Theta,1)

! 740:[abcdq0] abc dq0 transformation 
!ABC to DQ0 transformation
      CALL TRDQO(RT_68,RT_69,RT_70,UFd,UFq,RT_71,Theta,1)

! 750:[abcdq0] abc dq0 transformation 
!ABC to DQ0 transformation
      CALL TRDQO(RT_72,RT_73,RT_74,ISd,ISq,RT_75,Theta,1)

! 760:[sumjct] Summing/Differencing Junctions 
      RT_9 = + RT_11 - UFd

! 770:[pi_ctlr] PI Controller \w Interpolation 
      RVD1_1 = RTCF(NRTCF)
      NRTCF = NRTCF + 1
      RVD2_1(1) = RT_9
      RVD2_1(2) = 0.0
      RT_10 = EMTDC_XPI(0,KpV,TiV,-10000000000.0,10000000000.0,RVD1_1,RV&
     &D2_1)

! 780:[gain] Gain Block 
!  Gain
      RT_13 = wCf_pu * UFq

! 790:[gain] Gain Block 
!  Gain
      RT_12 = wCf_pu * UFd

! 800:[gain] Gain Block 
!  Gain
      RT_15 = wLf_pu * IWq

! 810:[sumjct] Summing/Differencing Junctions 
      Err = + UFqref - UFq

! 820:[gain] Gain Block 
!  Gain
      RT_16 = wLf_pu * IWd

! 830:[pi_ctlr] PI Controller \w Interpolation 
      RVD1_1 = RTCF(NRTCF)
      NRTCF = NRTCF + 1
      RVD2_1(1) = Err
      RVD2_1(2) = 0.0
      RT_7 = EMTDC_XPI(0,KpV,TiV,-10000000000.0,10000000000.0,RVD1_1,RVD&
     &2_1)

! 840:[sumjct] Summing/Differencing Junctions 
      RT_3 = + ISq + RT_7 - RT_12

! 850:[div] Divider 
      IF (ABS(RT_60) .LT. 1.0E-100) THEN
         IF (RT_60 .LT. 0.0)  THEN
            Cbase = -1.0E100 * RT_59
         ELSE
            Cbase =  1.0E100 * RT_59
         ENDIF
      ELSE
         Cbase = RT_59 / RT_60
      ENDIF

! 860:[mult] Multiplier 
      RT_28 = IWd * UFq

! 870:[mult] Multiplier 
      RT_29 = IWq * UFd

! 880:[mult] Multiplier 
      RT_30 = IWd * UFd

! 890:[mult] Multiplier 
      RT_31 = UFq * IWq

! 900:[sumjct] Summing/Differencing Junctions 
      RT_4 = + ISd + RT_10 + RT_13

! 910:[Current_Limiter_3_1]  
      CALL Current_Limiter_3_1Dyn(RT_1, RT_2, RT_3, RT_4, Theta)


! 920:[sumjct] Summing/Differencing Junctions 
      RT_5 = + RT_1 - IWq

! 930:[pi_ctlr] PI Controller \w Interpolation 
      RVD1_1 = RTCF(NRTCF)
      NRTCF = NRTCF + 1
      RVD2_1(1) = RT_5
      RVD2_1(2) = 0.0
      RT_6 = EMTDC_XPI(0,KpI,TiI,-10000000000.0,10000000000.0,RVD1_1,RVD&
     &2_1)

! 940:[sumjct] Summing/Differencing Junctions 
      Ucq = + UFq + RT_6 - RT_16

! 950:[sumjct] Summing/Differencing Junctions 
      RT_21 = + RT_2 - IWd

! 960:[pi_ctlr] PI Controller \w Interpolation 
      RVD1_1 = RTCF(NRTCF)
      NRTCF = NRTCF + 1
      RVD2_1(1) = RT_21
      RVD2_1(2) = 0.0
      RT_14 = EMTDC_XPI(0,KpI,TiI,-10000000000.0,10000000000.0,RVD1_1,RV&
     &D2_1)

! 970:[sumjct] Summing/Differencing Junctions 
      Ucd = + UFd + RT_14 + RT_15

! 980:[polar_rec] Polar Rectangular coordinate converter 
      RT_33 = SQRT(Ucd*Ucd+Ucq*Ucq)
      IF ((ABS(Ucd).GT.1.0E-20).OR.(ABS(Ucq).GT.1.0E-20)) THEN
        RT_35 = ATAN2(Ucq,Ucd)
      ELSE
        RT_35 = 0.0
      ENDIF

! 990:[polar_rec] Polar Rectangular coordinate converter 
      RT_32 = RT_33*COS(RT_35)
      RT_34 = RT_33*SIN(RT_35)

! 1000:[sumjct] Summing/Differencing Junctions 
      RT_25 = + RT_30 + RT_31

! 1010:[sumjct] Summing/Differencing Junctions 
      RT_27 = - RT_28 + RT_29

! 1020:[abcdq0] abc dq0 transformation 
!DQ0 to ABC transformation
      CALL TRDQO(RT_17,RT_18,RT_19,RT_32,RT_34,RT_8,Theta,-1)

! 1030:[polar_rec] Polar Rectangular coordinate converter 
      RT_42 = SQRT(UFd*UFd+UFq*UFq)
      IF ((ABS(UFd).GT.1.0E-20).OR.(ABS(UFq).GT.1.0E-20)) THEN
        RT_41 = ATAN2(UFq,UFd)
      ELSE
        RT_41 = 0.0
      ENDIF

! 1040:[div] Divider 
      IF (ABS(Cbase) .LT. 1.0E-100) THEN
         IF (Cbase .LT. 0.0)  THEN
            RT_62 = -1.0E100 * Cf
         ELSE
            RT_62 =  1.0E100 * Cf
         ENDIF
      ELSE
         RT_62 = Cf / Cbase
      ENDIF

! 1050:[mult] Multiplier 
      RT_24 = RT_25 * RT_22

! 1060:[mult] Multiplier 
      RT_26 = RT_27 * RT_23

! 1070:[datamerge] Merges data signals into an array 
      RT_20(1) = RT_17
      RT_20(2) = RT_18
      RT_20(3) = RT_19

! 1080:[sumjct] Summing/Differencing Junctions 
      Delta_Vf = - RT_41 + RT_45

! 1090:[mult] Multiplier 
      RT_61 = RT_62 * RT_63

! 1100:[realpole] Real Pole 
!  Real_Pole
      Pdq = REALPOLE(0,1,0,1.0,0.001,RT_24,0.0,-1.0E20,1.0E20)

! 1110:[realpole] Real Pole 
!  Real_Pole
      Qdq = REALPOLE(0,1,0,1.0,0.001,RT_26,0.0,-1.0E20,1.0E20)

! 1120:[sumjct] Summing/Differencing Junctions 
      RT_39 = + Theta - Theta_ref

! 1130:[gain] Gain Block 
!  Gain
      Vref = Vbase * RT_20

! 1140:[sumjct] Summing/Differencing Junctions 
      Delta_Vc = - RT_35 + RT_40

! 1150:[sumjct] Summing/Differencing Junctions 
      RT_43 = + Delta_Vc - Delta_Vf

! 1160:[pgb] Output Channel '1'

      PGB(IPGB+1) = RT_61

! 1170:[pgb] Output Channel 'Isq'

      PGB(IPGB+2) = ISq

! 1180:[pgb] Output Channel 'Isd'

      PGB(IPGB+3) = ISd

! 1190:[pgb] Output Channel 'Ufq'

      PGB(IPGB+4) = UFq

! 1200:[pgb] Output Channel 'Ufd'

      PGB(IPGB+5) = UFd

! 1210:[pgb] Output Channel '2'

      PGB(IPGB+6) = wCf_pu

! 1220:[pgb] Output Channel 'Icq'

      PGB(IPGB+7) = IWq

! 1230:[pgb] Output Channel 'Icd'

      PGB(IPGB+8) = IWd

! 1250:[pgb] Output Channel 'P'

      PGB(IPGB+9) = Pdq

! 1270:[pgb] Output Channel 'Q'

      PGB(IPGB+10) = Qdq

! 1280:[pgb] Output Channel 'wt'

      PGB(IPGB+11) = 57.29577951 * Theta_ref

! 1290:[pgb] Output Channel 'Theta_int'

      PGB(IPGB+12) = RT_39

! 1300:[div] Divider 
      IF (ABS(Wrated) .LT. 1.0E-100) THEN
         IF (Wrated .LT. 0.0)  THEN
            Lbase = -1.0E100 * Zbase
         ELSE
            Lbase =  1.0E100 * Zbase
         ENDIF
      ELSE
         Lbase = Zbase / Wrated
      ENDIF

! 1310:[pgb] Output Channel 'erri'

      PGB(IPGB+13) = RT_5

! 1320:[pgb] Output Channel 'errv'

      PGB(IPGB+14) = Err

! 1330:[pgb] Output Channel 'Untitled'

      PGB(IPGB+15) = Zbase

! 1350:[pgb] Output Channel 'id'

      PGB(IPGB+16) = ISd

! 1370:[pgb] Output Channel 'Delta_Vc'

      PGB(IPGB+17) = Delta_Vc

! 1380:[pgb] Output Channel 'Ucq'

      PGB(IPGB+18) = Ucq

! 1390:[pgb] Output Channel 'Ucd'

      PGB(IPGB+19) = Ucd

! 1400:[pgb] Output Channel 'Delta_delta_VfVc'

      PGB(IPGB+20) = RT_43

! 1410:[pgb] Output Channel 'Delta_Vf'

      PGB(IPGB+21) = Delta_Vf

!---------------------------------------
! Feedbacks and transfers to storage 
!---------------------------------------

      STOF(ISTOF + 13) = W
      STOF(ISTOF + 14) = UFqref
      STOF(ISTOF + 15) = Wgrid
      STOF(ISTOF + 16) = Pdq
      STOF(ISTOF + 17) = Qdq
      STOF(ISTOF + 18) = Wref
      STOF(ISTOF + 19) = VratedLLrms
      STOF(ISTOF + 20) = Iratedphrms
      STOF(ISTOF + 21) = Wrated
      STOF(ISTOF + 22) = Lf
      STOF(ISTOF + 23) = Cf
      STOF(ISTOF + 24) = RT_1
      STOF(ISTOF + 25) = RT_2
      STOF(ISTOF + 26) = RT_3
      STOF(ISTOF + 27) = RT_4
      STOF(ISTOF + 28) = RT_5
      STOF(ISTOF + 29) = RT_6
      STOF(ISTOF + 30) = Err
      STOF(ISTOF + 31) = RT_7
      STOF(ISTOF + 32) = RT_8
      STOF(ISTOF + 33) = RT_9
      STOF(ISTOF + 34) = RT_10
      STOF(ISTOF + 35) = RT_11
      STOF(ISTOF + 36) = RT_12
      STOF(ISTOF + 37) = RT_13
      STOF(ISTOF + 38) = RT_14
      STOF(ISTOF + 39) = RT_15
      STOF(ISTOF + 40) = Ucd
      STOF(ISTOF + 41) = RT_16
      STOF(ISTOF + 42) = Ucq
      STOF(ISTOF + 43) = RT_17
      STOF(ISTOF + 44) = RT_18
      STOF(ISTOF + 45) = RT_19
      STOF(ISTOF + 49) = RT_21
      STOF(ISTOF + 50) = RT_22
      STOF(ISTOF + 51) = RT_23
      STOF(ISTOF + 52) = RT_24
      STOF(ISTOF + 53) = RT_25
      STOF(ISTOF + 54) = RT_26
      STOF(ISTOF + 55) = RT_27
      STOF(ISTOF + 56) = RT_28
      STOF(ISTOF + 57) = RT_29
      STOF(ISTOF + 58) = RT_30
      STOF(ISTOF + 59) = RT_31
      STOF(ISTOF + 60) = RT_32
      STOF(ISTOF + 61) = RT_33
      STOF(ISTOF + 62) = RT_34
      STOF(ISTOF + 63) = RT_35
      STOF(ISTOF + 64) = RT_36
      STOF(ISTOF + 65) = Delta_Vc
      STOF(ISTOF + 66) = RT_37
      STOF(ISTOF + 67) = RT_38
      STOF(ISTOF + 68) = Theta_ref
      STOF(ISTOF + 69) = RT_39
      STOF(ISTOF + 70) = RT_40
      STOF(ISTOF + 71) = RT_41
      STOF(ISTOF + 72) = RT_42
      STOF(ISTOF + 73) = Delta_Vf
      STOF(ISTOF + 74) = RT_43
      STOF(ISTOF + 75) = RT_44
      STOF(ISTOF + 76) = RT_45
      STOF(ISTOF + 77) = RT_46
      STOF(ISTOF + 78) = UFq
      STOF(ISTOF + 79) = UFd
      STOF(ISTOF + 80) = IWd
      STOF(ISTOF + 81) = IWq
      STOF(ISTOF + 82) = ISq
      STOF(ISTOF + 83) = ISd
      STOF(ISTOF + 84) = Theta
      STOF(ISTOF + 85) = RT_47
      STOF(ISTOF + 86) = RT_48
      STOF(ISTOF + 87) = RT_49
      STOF(ISTOF + 88) = RT_50
      STOF(ISTOF + 95) = Vbase
      STOF(ISTOF + 99) = Ibase
      STOF(ISTOF + 100) = RT_54
      STOF(ISTOF + 101) = RT_55
      STOF(ISTOF + 102) = RT_56
      STOF(ISTOF + 103) = RT_57
      STOF(ISTOF + 104) = RT_58
      STOF(ISTOF + 105) = MVAbase
      STOF(ISTOF + 106) = wLf_pu
      STOF(ISTOF + 107) = RT_59
      STOF(ISTOF + 108) = RT_60
      STOF(ISTOF + 109) = wCf_pu
      STOF(ISTOF + 110) = Zbase
      STOF(ISTOF + 111) = RT_61
      STOF(ISTOF + 112) = RT_62
      STOF(ISTOF + 113) = Cbase
      STOF(ISTOF + 114) = RT_63
      STOF(ISTOF + 115) = RT_64
      STOF(ISTOF + 116) = RT_65
      STOF(ISTOF + 117) = RT_66
      STOF(ISTOF + 118) = RT_67
      STOF(ISTOF + 119) = RT_68
      STOF(ISTOF + 120) = RT_69
      STOF(ISTOF + 121) = RT_70
      STOF(ISTOF + 122) = RT_71
      STOF(ISTOF + 123) = RT_72
      STOF(ISTOF + 124) = RT_73
      STOF(ISTOF + 125) = RT_74
      STOF(ISTOF + 126) = RT_75
      STOF(ISTOF + 127) = KpI
      STOF(ISTOF + 128) = TiI
      STOF(ISTOF + 129) = RT_76
      STOF(ISTOF + 130) = RT_77
      STOF(ISTOF + 131) = KpV
      STOF(ISTOF + 132) = RT_78
      STOF(ISTOF + 133) = RT_79
      STOF(ISTOF + 134) = TiV
      STOF(ISTOF + 135) = RT_80
      STOF(ISTOF + 136) = Lbase

! Array (1:3) quantities...
      DO IT_0 = 1,3
         STOF(ISTOF + 0 + IT_0) = Vref(IT_0)
         STOF(ISTOF + 3 + IT_0) = Igrid(IT_0)
         STOF(ISTOF + 6 + IT_0) = Vgrid(IT_0)
         STOF(ISTOF + 9 + IT_0) = I_inv(IT_0)
         STOF(ISTOF + 45 + IT_0) = RT_20(IT_0)
         STOF(ISTOF + 88 + IT_0) = RT_51(IT_0)
         STOF(ISTOF + 91 + IT_0) = RT_52(IT_0)
         STOF(ISTOF + 95 + IT_0) = RT_53(IT_0)
      END DO


!---------------------------------------
! Transfer to Exports
!---------------------------------------
      !Vref     is output
      !Wgrid    is output
      !Pdq      is output
      !Qdq      is output

!---------------------------------------
! Close Model Data read 
!---------------------------------------

      IF ( TIMEZERO ) CALL EMTDC_CLOSEFILE
      RETURN
      END

!=======================================================================

      SUBROUTINE VF_Control_7_1Out()

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

!     SUBR    Current_Limiter_3_1Out  ! 

!---------------------------------------
! Variable Declarations 
!---------------------------------------


! Electrical Node Indices

! Control Signals
      REAL     RT_8, RT_11, RT_22, RT_23, RT_36
      REAL     RT_37, RT_40, RT_44, RT_45, RT_46
      REAL     RT_47, RT_49, RT_50, RT_57, RT_59
      REAL     RT_63, KpI, RT_76, RT_77, KpV
      REAL     RT_78, RT_79, RT_80

! Internal Variables

! Indexing variables
      INTEGER ICALL_NO                            ! Module call num
      INTEGER ISTOL, ISTOI, ISTOF, ISTOC          ! Storage Indices
      INTEGER ISUBS                               ! SS/Node/Branch/Xfmr


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

      NPGB      = NPGB + 21
      NNODE     = NNODE + 2
      NCSCS     = NCSCS + 0
      NCSCR     = NCSCR + 0

!---------------------------------------
! Transfers from storage arrays 
!---------------------------------------

      RT_8     = STOF(ISTOF + 32)
      RT_11    = STOF(ISTOF + 35)
      RT_22    = STOF(ISTOF + 50)
      RT_23    = STOF(ISTOF + 51)
      RT_36    = STOF(ISTOF + 64)
      RT_37    = STOF(ISTOF + 66)
      RT_40    = STOF(ISTOF + 70)
      RT_44    = STOF(ISTOF + 75)
      RT_45    = STOF(ISTOF + 76)
      RT_46    = STOF(ISTOF + 77)
      RT_47    = STOF(ISTOF + 85)
      RT_49    = STOF(ISTOF + 87)
      RT_50    = STOF(ISTOF + 88)
      RT_57    = STOF(ISTOF + 103)
      RT_59    = STOF(ISTOF + 107)
      RT_63    = STOF(ISTOF + 114)
      KpI      = STOF(ISTOF + 127)
      RT_76    = STOF(ISTOF + 129)
      RT_77    = STOF(ISTOF + 130)
      KpV      = STOF(ISTOF + 131)
      RT_78    = STOF(ISTOF + 132)
      RT_79    = STOF(ISTOF + 133)
      RT_80    = STOF(ISTOF + 135)


!---------------------------------------
! Electrical Node Lookup 
!---------------------------------------


!---------------------------------------
! Configuration of Models 
!---------------------------------------

      IF ( TIMEZERO ) THEN
         FILENAME = 'VF_Control_7_1.dta'
         CALL EMTDC_OPENFILE
         SECTION = 'DATADSO:'
         CALL EMTDC_GOTOSECTION
      ENDIF
!---------------------------------------
! Generated code from module definition 
!---------------------------------------


! 20:[emtconst] Commonly Used Constants (pi...) 
      RT_45 = PI_BY2

! 30:[const] Real Constant 

      RT_36 = 0.0

! 60:[const] Real Constant 

      RT_44 = 0.0

! 70:[const] Real Constant 

      RT_8 = 0.0

! 90:[emtconst] Commonly Used Constants (pi...) 
      RT_40 = PI_BY2

! 100:[const] Real Constant 

      RT_46 = 0.0

! 110:[const] Real Constant 

      RT_11 = 0.0

! 160:[emtconst] Commonly Used Constants (pi...) 
      RT_50 = SQRT_3

! 170:[emtconst] Commonly Used Constants (pi...) 
      RT_49 = SQRT_2

! 180:[const] Real Constant 

      RT_80 = 1.0

! 210:[emtconst] Commonly Used Constants (pi...) 
      RT_47 = SQRT_2

! 230:[emtconst] Commonly Used Constants (pi...) 
      RT_37 = TWO_PI

! 260:[const] Real Constant 

      RT_59 = 1.0

! 280:[emtconst] Commonly Used Constants (pi...) 
      RT_57 = SQRT_3

! 300:[const] Real Constant 

      KpI = 5.0

! 310:[const] Real Constant 

      RT_23 = 1.0

! 320:[const] Real Constant 

      KpV = 1.0

! 330:[const] Real Constant 

      RT_76 = 1.0

! 340:[const] Real Constant 

      RT_79 = 1.0

! 350:[const] Real Constant 

      RT_77 = 5.0

! 360:[const] Real Constant 

      RT_78 = 10.0

! 370:[const] Real Constant 

      RT_22 = 1.0

! 410:[const] Real Constant 

      RT_63 = 1.0

! 910:[Current_Limiter_3_1]  
      CALL Current_Limiter_3_1Out()


!---------------------------------------
! Feedbacks and transfers to storage 
!---------------------------------------

      STOF(ISTOF + 32) = RT_8
      STOF(ISTOF + 35) = RT_11
      STOF(ISTOF + 50) = RT_22
      STOF(ISTOF + 51) = RT_23
      STOF(ISTOF + 64) = RT_36
      STOF(ISTOF + 66) = RT_37
      STOF(ISTOF + 70) = RT_40
      STOF(ISTOF + 75) = RT_44
      STOF(ISTOF + 76) = RT_45
      STOF(ISTOF + 77) = RT_46
      STOF(ISTOF + 85) = RT_47
      STOF(ISTOF + 87) = RT_49
      STOF(ISTOF + 88) = RT_50
      STOF(ISTOF + 103) = RT_57
      STOF(ISTOF + 107) = RT_59
      STOF(ISTOF + 114) = RT_63
      STOF(ISTOF + 127) = KpI
      STOF(ISTOF + 129) = RT_76
      STOF(ISTOF + 130) = RT_77
      STOF(ISTOF + 131) = KpV
      STOF(ISTOF + 132) = RT_78
      STOF(ISTOF + 133) = RT_79
      STOF(ISTOF + 135) = RT_80


!---------------------------------------
! Close Model Data read 
!---------------------------------------

      IF ( TIMEZERO ) CALL EMTDC_CLOSEFILE
      RETURN
      END

!=======================================================================

      SUBROUTINE VF_Control_7_1Dyn_Begin()

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

!     SUBR    Current_Limiter_3_1Dyn_Begin  ! 

!---------------------------------------
! Variable Declarations 
!---------------------------------------


! Subroutine Arguments

! Electrical Node Indices

! Control Signals
      REAL     RT_8, RT_11, RT_22, RT_23, RT_36
      REAL     RT_37, RT_40, RT_44, RT_45, RT_46
      REAL     RT_47, RT_49, RT_50, RT_57, RT_59
      REAL     RT_63, KpI, RT_76, RT_77, KpV
      REAL     RT_78, RT_79, RT_80

! Internal Variables

! Indexing variables
      INTEGER ICALL_NO                            ! Module call num
      INTEGER ISUBS                               ! SS/Node/Branch/Xfmr


!---------------------------------------
! Local Indices 
!---------------------------------------


! Increment and assign runtime configuration call indices

      ICALL_NO  = NCALL_NO
      NCALL_NO  = NCALL_NO + 1

! Increment global storage indices

      NNODE     = NNODE + 2
      NCSCS     = NCSCS + 0
      NCSCR     = NCSCR + 0

!---------------------------------------
! Electrical Node Lookup 
!---------------------------------------


!---------------------------------------
! Generated code from module definition 
!---------------------------------------


! 20:[emtconst] Commonly Used Constants (pi...) 
      RT_45 = PI_BY2

! 30:[const] Real Constant 
      RT_36 = 0.0

! 60:[const] Real Constant 
      RT_44 = 0.0

! 70:[const] Real Constant 
      RT_8 = 0.0

! 90:[emtconst] Commonly Used Constants (pi...) 
      RT_40 = PI_BY2

! 100:[const] Real Constant 
      RT_46 = 0.0

! 110:[const] Real Constant 
      RT_11 = 0.0

! 160:[emtconst] Commonly Used Constants (pi...) 
      RT_50 = SQRT_3

! 170:[emtconst] Commonly Used Constants (pi...) 
      RT_49 = SQRT_2

! 180:[const] Real Constant 
      RT_80 = 1.0

! 210:[emtconst] Commonly Used Constants (pi...) 
      RT_47 = SQRT_2

! 230:[emtconst] Commonly Used Constants (pi...) 
      RT_37 = TWO_PI

! 260:[const] Real Constant 
      RT_59 = 1.0

! 280:[emtconst] Commonly Used Constants (pi...) 
      RT_57 = SQRT_3

! 300:[const] Real Constant 
      KpI = 5.0

! 310:[const] Real Constant 
      RT_23 = 1.0

! 320:[const] Real Constant 
      KpV = 1.0

! 330:[const] Real Constant 
      RT_76 = 1.0

! 340:[const] Real Constant 
      RT_79 = 1.0

! 350:[const] Real Constant 
      RT_77 = 5.0

! 360:[const] Real Constant 
      RT_78 = 10.0

! 370:[const] Real Constant 
      RT_22 = 1.0

! 410:[const] Real Constant 
      RT_63 = 1.0

! 430:[gain] Gain Block 

! 440:[integral] Interpolated Integrator 
      RTCF(NRTCF) = 0.0
      NRTCF = NRTCF + 1

! 450:[div] Divider 

! 460:[mult] Multiplier 

! 470:[square] Square 

! 480:[mult] Multiplier 

! 490:[mult] Multiplier 

! 500:[integral] Interpolated Integrator 
      RTCF(NRTCF) = 0.0
      NRTCF = NRTCF + 1

! 510:[mult] Multiplier 

! 520:[mult] Multiplier 

! 530:[div] Divider 

! 540:[div] Divider 

! 550:[gain] Gain Block 

! 560:[gain] Gain Block 

! 570:[div] Divider 

! 580:[datatap] Scalar/Array Tap 

! 590:[datatap] Scalar/Array Tap 

! 600:[datatap] Scalar/Array Tap 

! 610:[div] Divider 

! 620:[datatap] Scalar/Array Tap 

! 630:[datatap] Scalar/Array Tap 

! 640:[datatap] Scalar/Array Tap 

! 650:[div] Divider 

! 660:[datatap] Scalar/Array Tap 

! 670:[datatap] Scalar/Array Tap 

! 680:[datatap] Scalar/Array Tap 

! 690:[div] Divider 

! 700:[mult] Multiplier 

! 710:[div] Divider 

! 720:[mult] Multiplier 

! 730:[abcdq0] abc dq0 transformation 

! 740:[abcdq0] abc dq0 transformation 

! 750:[abcdq0] abc dq0 transformation 

! 760:[sumjct] Summing/Differencing Junctions 

! 770:[pi_ctlr] PI Controller \w Interpolation 
      RTCF(NRTCF) = 0.0
      NRTCF = NRTCF + 1

! 780:[gain] Gain Block 

! 790:[gain] Gain Block 

! 800:[gain] Gain Block 

! 810:[sumjct] Summing/Differencing Junctions 

! 820:[gain] Gain Block 

! 830:[pi_ctlr] PI Controller \w Interpolation 
      RTCF(NRTCF) = 0.0
      NRTCF = NRTCF + 1

! 840:[sumjct] Summing/Differencing Junctions 

! 850:[div] Divider 

! 860:[mult] Multiplier 

! 870:[mult] Multiplier 

! 880:[mult] Multiplier 

! 890:[mult] Multiplier 

! 900:[sumjct] Summing/Differencing Junctions 

! 910:[Current_Limiter_3_1]  
      CALL Current_Limiter_3_1Dyn_Begin()


! 920:[sumjct] Summing/Differencing Junctions 

! 930:[pi_ctlr] PI Controller \w Interpolation 
      RTCF(NRTCF) = 0.0
      NRTCF = NRTCF + 1

! 940:[sumjct] Summing/Differencing Junctions 

! 950:[sumjct] Summing/Differencing Junctions 

! 960:[pi_ctlr] PI Controller \w Interpolation 
      RTCF(NRTCF) = 0.0
      NRTCF = NRTCF + 1

! 970:[sumjct] Summing/Differencing Junctions 

! 980:[polar_rec] Polar Rectangular coordinate converter 

! 990:[polar_rec] Polar Rectangular coordinate converter 

! 1000:[sumjct] Summing/Differencing Junctions 

! 1010:[sumjct] Summing/Differencing Junctions 

! 1020:[abcdq0] abc dq0 transformation 

! 1030:[polar_rec] Polar Rectangular coordinate converter 

! 1040:[div] Divider 

! 1050:[mult] Multiplier 

! 1060:[mult] Multiplier 

! 1070:[datamerge] Merges data signals into an array 

! 1080:[sumjct] Summing/Differencing Junctions 

! 1090:[mult] Multiplier 

! 1100:[realpole] Real Pole 

! 1110:[realpole] Real Pole 

! 1120:[sumjct] Summing/Differencing Junctions 

! 1130:[gain] Gain Block 

! 1140:[sumjct] Summing/Differencing Junctions 

! 1150:[sumjct] Summing/Differencing Junctions 

! 1160:[pgb] Output Channel '1'

! 1170:[pgb] Output Channel 'Isq'

! 1180:[pgb] Output Channel 'Isd'

! 1190:[pgb] Output Channel 'Ufq'

! 1200:[pgb] Output Channel 'Ufd'

! 1210:[pgb] Output Channel '2'

! 1220:[pgb] Output Channel 'Icq'

! 1230:[pgb] Output Channel 'Icd'

! 1250:[pgb] Output Channel 'P'

! 1270:[pgb] Output Channel 'Q'

! 1280:[pgb] Output Channel 'wt'

! 1290:[pgb] Output Channel 'Theta_int'

! 1300:[div] Divider 

! 1310:[pgb] Output Channel 'erri'

! 1320:[pgb] Output Channel 'errv'

! 1330:[pgb] Output Channel 'Untitled'

! 1350:[pgb] Output Channel 'id'

! 1370:[pgb] Output Channel 'Delta_Vc'

! 1380:[pgb] Output Channel 'Ucq'

! 1390:[pgb] Output Channel 'Ucd'

! 1400:[pgb] Output Channel 'Delta_delta_VfVc'

! 1410:[pgb] Output Channel 'Delta_Vf'

      RETURN
      END

!=======================================================================

      SUBROUTINE VF_Control_7_1Out_Begin()

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

!     SUBR    Current_Limiter_3_1Out_Begin  ! 

!---------------------------------------
! Variable Declarations 
!---------------------------------------


! Subroutine Arguments

! Electrical Node Indices

! Control Signals
      REAL     RT_8, RT_11, RT_22, RT_23, RT_36
      REAL     RT_37, RT_40, RT_44, RT_45, RT_46
      REAL     RT_47, RT_49, RT_50, RT_57, RT_59
      REAL     RT_63, KpI, RT_76, RT_77, KpV
      REAL     RT_78, RT_79, RT_80

! Internal Variables

! Indexing variables
      INTEGER ICALL_NO                            ! Module call num
      INTEGER ISUBS                               ! SS/Node/Branch/Xfmr


!---------------------------------------
! Local Indices 
!---------------------------------------


! Increment and assign runtime configuration call indices

      ICALL_NO  = NCALL_NO
      NCALL_NO  = NCALL_NO + 1

! Increment global storage indices

      NNODE     = NNODE + 2
      NCSCS     = NCSCS + 0
      NCSCR     = NCSCR + 0

!---------------------------------------
! Electrical Node Lookup 
!---------------------------------------


!---------------------------------------
! Generated code from module definition 
!---------------------------------------


! 20:[emtconst] Commonly Used Constants (pi...) 
      RT_45 = PI_BY2

! 30:[const] Real Constant 
      RT_36 = 0.0

! 60:[const] Real Constant 
      RT_44 = 0.0

! 70:[const] Real Constant 
      RT_8 = 0.0

! 90:[emtconst] Commonly Used Constants (pi...) 
      RT_40 = PI_BY2

! 100:[const] Real Constant 
      RT_46 = 0.0

! 110:[const] Real Constant 
      RT_11 = 0.0

! 160:[emtconst] Commonly Used Constants (pi...) 
      RT_50 = SQRT_3

! 170:[emtconst] Commonly Used Constants (pi...) 
      RT_49 = SQRT_2

! 180:[const] Real Constant 
      RT_80 = 1.0

! 210:[emtconst] Commonly Used Constants (pi...) 
      RT_47 = SQRT_2

! 230:[emtconst] Commonly Used Constants (pi...) 
      RT_37 = TWO_PI

! 260:[const] Real Constant 
      RT_59 = 1.0

! 280:[emtconst] Commonly Used Constants (pi...) 
      RT_57 = SQRT_3

! 300:[const] Real Constant 
      KpI = 5.0

! 310:[const] Real Constant 
      RT_23 = 1.0

! 320:[const] Real Constant 
      KpV = 1.0

! 330:[const] Real Constant 
      RT_76 = 1.0

! 340:[const] Real Constant 
      RT_79 = 1.0

! 350:[const] Real Constant 
      RT_77 = 5.0

! 360:[const] Real Constant 
      RT_78 = 10.0

! 370:[const] Real Constant 
      RT_22 = 1.0

! 410:[const] Real Constant 
      RT_63 = 1.0

! 910:[Current_Limiter_3_1]  
      CALL Current_Limiter_3_1Out_Begin()


      RETURN
      END

