!=======================================================================
! Generated by: PSCAD v5.0.1.0
! Warning:  The content of this file is automatically generated.
!           Do not modify, as any changes made here will be lost!
!-----------------------------------------------------------------------
! Component     : PWM_1
! Description   : 
!-----------------------------------------------------------------------


!=======================================================================

      SUBROUTINE PWM_1Dyn(Ref, GT, freq, Cfreq)

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

!     SUBR    EMTDC_X2COMP  ! 'Comparator with Interpolation'
!     SUBR    EMTDC_XLGATE  ! 'Multiple Input Logic Gate /w Interpolation'

!---------------------------------------
! Variable Declarations 
!---------------------------------------


! Subroutine Arguments
      REAL,    INTENT(IN)  :: Ref(4), freq, Cfreq
      REAL,    INTENT(OUT) :: GT(12)

! Electrical Node Indices

! Control Signals
      INTEGER  DBlk
      REAL     RT_1, RT_2(2), Trig, RT_3, RT_4(2)
      REAL     RT_5(2), RT_6(2), gt11(2), gt31(2)
      REAL     gt51(2), gt1(2), gt2(2), gt3(2)
      REAL     gt4(2), gt5(2), gt6(2), Varef
      REAL     Vbref, Vcref, RT_7

! Internal Variables
      INTEGER  I_9, IVD1_1
      REAL     RVD18_1(18)

! Indexing variables
      INTEGER ICALL_NO                            ! Module call num
      INTEGER ISTOI, ISTOF, IT_0                  ! Storage Indices
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

      ISTOI     = NSTOI
      NSTOI     = NSTOI + 1
      ISTOF     = NSTOF
      NSTOF     = NSTOF + 51
      IPGB      = NPGB
      NPGB      = NPGB + 11
      NNODE     = NNODE + 2
      NCSCS     = NCSCS + 0
      NCSCR     = NCSCR + 0

!---------------------------------------
! Transfers from storage arrays 
!---------------------------------------

      RT_1     = STOF(ISTOF + 19)
      Trig     = STOF(ISTOF + 22)
      RT_3     = STOF(ISTOF + 23)
      Varef    = STOF(ISTOF + 48)
      Vbref    = STOF(ISTOF + 49)
      Vcref    = STOF(ISTOF + 50)
      RT_7     = STOF(ISTOF + 51)
      DBlk     = STOI(ISTOI + 1)

! Array (1:2) quantities...
      DO IT_0 = 1,2
         RT_2(IT_0) = STOF(ISTOF + 19 + IT_0)
         RT_4(IT_0) = STOF(ISTOF + 23 + IT_0)
         RT_5(IT_0) = STOF(ISTOF + 25 + IT_0)
         RT_6(IT_0) = STOF(ISTOF + 27 + IT_0)
         gt11(IT_0) = STOF(ISTOF + 29 + IT_0)
         gt31(IT_0) = STOF(ISTOF + 31 + IT_0)
         gt51(IT_0) = STOF(ISTOF + 33 + IT_0)
         gt1(IT_0) = STOF(ISTOF + 35 + IT_0)
         gt2(IT_0) = STOF(ISTOF + 37 + IT_0)
         gt3(IT_0) = STOF(ISTOF + 39 + IT_0)
         gt4(IT_0) = STOF(ISTOF + 41 + IT_0)
         gt5(IT_0) = STOF(ISTOF + 43 + IT_0)
         gt6(IT_0) = STOF(ISTOF + 45 + IT_0)
      END DO

! Array (1:12) quantities...
      DO IT_0 = 1,12
         GT(IT_0) = STOF(ISTOF + 4 + IT_0)
      END DO


!---------------------------------------
! Electrical Node Lookup 
!---------------------------------------


!---------------------------------------
! Configuration of Models 
!---------------------------------------

      IF ( TIMEZERO ) THEN
         FILENAME = 'PWM_1.dta'
         CALL EMTDC_OPENFILE
         SECTION = 'DATADSD:'
         CALL EMTDC_GOTOSECTION
      ENDIF
!---------------------------------------
! Generated code from module definition 
!---------------------------------------


! 40:[datatap] Scalar/Array Tap 
      Varef = Ref(1)

! 50:[datatap] Scalar/Array Tap 
      Vbref = Ref(2)

! 60:[datatap] Scalar/Array Tap 
      Vcref = Ref(3)

! 70:[datatap] Scalar/Array Tap 
      RT_7 = Ref(4)

! 80:[unity] Type/Shape conversion block 
! real -> nearest integer
      DBlk = NINT(RT_7)

! 90:[pgb] Output Channel 'RefA'

      PGB(IPGB+1) = Varef

! 100:[pgb] Output Channel 'RefB'

      PGB(IPGB+2) = Vbref

! 110:[pgb] Output Channel 'RefC'

      PGB(IPGB+3) = Vcref

! 120:[mult] Multiplier 
      RT_3 = freq * Cfreq

! 130:[sig_gen] Variable Frequency Sawtooth Generator 
      CALL SAWTOOTH1_EXE(RT_3,Trig)
!

! 140:[const] Real Constant 
      RT_1 = 0.0

! 150:[pgb] Output Channel 'Carrier'

      PGB(IPGB+4) = Trig

! 160:[datamerge] Merges data signals into an array 
      RT_2(1) = REAL(DBlk)
      RT_2(2) = RT_1

! 170:[compar] Two Input Comparator 
!
      CALL EMTDC_X2COMP(1,0,Varef,Trig,1.0,0.0,0.0,gt11)

! 180:[compar] Two Input Comparator 
!
      CALL EMTDC_X2COMP(1,0,Vbref,Trig,1.0,0.0,0.0,gt31)

! 190:[compar] Two Input Comparator 
!
      CALL EMTDC_X2COMP(1,0,Vcref,Trig,1.0,0.0,0.0,gt51)

! 200:[logic_mult] Multiple Input Logic Gate 
!
! Multi input, interpolated AND gate
!
      RVD18_1(1)  = gt11(1)
      RVD18_1(2)  = RT_2(1)
      RVD18_1(10) = gt11(2)
      RVD18_1(11) = RT_2(2)
      DO I_9 = 3,9
        RVD18_1(I_9) = 0.0
        RVD18_1(I_9+9) = 0.0
      ENDDO
      CALL EMTDC_XLGATE(0,2,RVD18_1,gt1)
!

! 210:[inv] Interpolated Logic Inverter 
      IF (NINT(gt11(1)) .NE. 0) THEN
         RT_4(1) = 0.0
      ELSE
         RT_4(1) = 1.0
      ENDIF
      RT_4(2) = gt11(2)

! 220:[logic_mult] Multiple Input Logic Gate 
!
! Multi input, interpolated AND gate
!
      RVD18_1(1)  = RT_4(1)
      RVD18_1(2)  = RT_2(1)
      RVD18_1(10) = RT_4(2)
      RVD18_1(11) = RT_2(2)
      DO I_9 = 3,9
        RVD18_1(I_9) = 0.0
        RVD18_1(I_9+9) = 0.0
      ENDDO
      CALL EMTDC_XLGATE(0,2,RVD18_1,gt4)
!

! 230:[logic_mult] Multiple Input Logic Gate 
!
! Multi input, interpolated AND gate
!
      RVD18_1(1)  = gt31(1)
      RVD18_1(2)  = RT_2(1)
      RVD18_1(10) = gt31(2)
      RVD18_1(11) = RT_2(2)
      DO I_9 = 3,9
        RVD18_1(I_9) = 0.0
        RVD18_1(I_9+9) = 0.0
      ENDDO
      CALL EMTDC_XLGATE(0,2,RVD18_1,gt3)
!

! 240:[inv] Interpolated Logic Inverter 
      IF (NINT(gt31(1)) .NE. 0) THEN
         RT_5(1) = 0.0
      ELSE
         RT_5(1) = 1.0
      ENDIF
      RT_5(2) = gt31(2)

! 250:[logic_mult] Multiple Input Logic Gate 
!
! Multi input, interpolated AND gate
!
      RVD18_1(1)  = RT_5(1)
      RVD18_1(2)  = RT_2(1)
      RVD18_1(10) = RT_5(2)
      RVD18_1(11) = RT_2(2)
      DO I_9 = 3,9
        RVD18_1(I_9) = 0.0
        RVD18_1(I_9+9) = 0.0
      ENDDO
      CALL EMTDC_XLGATE(0,2,RVD18_1,gt6)
!

! 260:[logic_mult] Multiple Input Logic Gate 
!
! Multi input, interpolated AND gate
!
      RVD18_1(1)  = gt51(1)
      RVD18_1(2)  = RT_2(1)
      RVD18_1(10) = gt51(2)
      RVD18_1(11) = RT_2(2)
      DO I_9 = 3,9
        RVD18_1(I_9) = 0.0
        RVD18_1(I_9+9) = 0.0
      ENDDO
      CALL EMTDC_XLGATE(0,2,RVD18_1,gt5)
!

! 270:[inv] Interpolated Logic Inverter 
      IF (NINT(gt51(1)) .NE. 0) THEN
         RT_6(1) = 0.0
      ELSE
         RT_6(1) = 1.0
      ENDIF
      RT_6(2) = gt51(2)

! 280:[logic_mult] Multiple Input Logic Gate 
!
! Multi input, interpolated AND gate
!
      RVD18_1(1)  = RT_6(1)
      RVD18_1(2)  = RT_2(1)
      RVD18_1(10) = RT_6(2)
      RVD18_1(11) = RT_2(2)
      DO I_9 = 3,9
        RVD18_1(I_9) = 0.0
        RVD18_1(I_9+9) = 0.0
      ENDDO
      CALL EMTDC_XLGATE(0,2,RVD18_1,gt2)
!

! 290:[datamerge] Merges data signals into an array 
      GT(1 : 2) = gt1
      GT(3 : 4) = gt2
      GT(5 : 6) = gt3
      GT(7 : 8) = gt4
      GT(9 : 10) = gt5
      GT(11 : 12) = gt6

! 300:[pgb] Output Channel 'pulse3'

      DO IVD1_1 = 1, 2
         PGB(IPGB+5+IVD1_1-1) = gt51(IVD1_1)
      ENDDO

! 310:[pgb] Output Channel 'pulse2'

      DO IVD1_1 = 1, 2
         PGB(IPGB+7+IVD1_1-1) = gt31(IVD1_1)
      ENDDO

! 320:[pgb] Output Channel 'Carrier'

      PGB(IPGB+9) = Trig

! 330:[pgb] Output Channel 'pulse1'

      DO IVD1_1 = 1, 2
         PGB(IPGB+10+IVD1_1-1) = gt11(IVD1_1)
      ENDDO

!---------------------------------------
! Feedbacks and transfers to storage 
!---------------------------------------

      STOF(ISTOF + 17) = freq
      STOF(ISTOF + 18) = Cfreq
      STOF(ISTOF + 19) = RT_1
      STOF(ISTOF + 22) = Trig
      STOF(ISTOF + 23) = RT_3
      STOF(ISTOF + 48) = Varef
      STOF(ISTOF + 49) = Vbref
      STOF(ISTOF + 50) = Vcref
      STOF(ISTOF + 51) = RT_7
      STOI(ISTOI + 1) = DBlk

! Array (1:2) quantities...
      DO IT_0 = 1,2
         STOF(ISTOF + 19 + IT_0) = RT_2(IT_0)
         STOF(ISTOF + 23 + IT_0) = RT_4(IT_0)
         STOF(ISTOF + 25 + IT_0) = RT_5(IT_0)
         STOF(ISTOF + 27 + IT_0) = RT_6(IT_0)
         STOF(ISTOF + 29 + IT_0) = gt11(IT_0)
         STOF(ISTOF + 31 + IT_0) = gt31(IT_0)
         STOF(ISTOF + 33 + IT_0) = gt51(IT_0)
         STOF(ISTOF + 35 + IT_0) = gt1(IT_0)
         STOF(ISTOF + 37 + IT_0) = gt2(IT_0)
         STOF(ISTOF + 39 + IT_0) = gt3(IT_0)
         STOF(ISTOF + 41 + IT_0) = gt4(IT_0)
         STOF(ISTOF + 43 + IT_0) = gt5(IT_0)
         STOF(ISTOF + 45 + IT_0) = gt6(IT_0)
      END DO

! Array (1:4) quantities...
      DO IT_0 = 1,4
         STOF(ISTOF + 0 + IT_0) = Ref(IT_0)
      END DO

! Array (1:12) quantities...
      DO IT_0 = 1,12
         STOF(ISTOF + 4 + IT_0) = GT(IT_0)
      END DO


!---------------------------------------
! Transfer to Exports
!---------------------------------------
      !GT       is output

!---------------------------------------
! Close Model Data read 
!---------------------------------------

      IF ( TIMEZERO ) CALL EMTDC_CLOSEFILE
      RETURN
      END

!=======================================================================

      SUBROUTINE PWM_1Out()

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


!---------------------------------------
! Variable Declarations 
!---------------------------------------


! Electrical Node Indices

! Control Signals
      REAL     RT_1

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

      NPGB      = NPGB + 11
      NNODE     = NNODE + 2
      NCSCS     = NCSCS + 0
      NCSCR     = NCSCR + 0

!---------------------------------------
! Transfers from storage arrays 
!---------------------------------------

      RT_1     = STOF(ISTOF + 19)


!---------------------------------------
! Electrical Node Lookup 
!---------------------------------------


!---------------------------------------
! Configuration of Models 
!---------------------------------------

      IF ( TIMEZERO ) THEN
         FILENAME = 'PWM_1.dta'
         CALL EMTDC_OPENFILE
         SECTION = 'DATADSO:'
         CALL EMTDC_GOTOSECTION
      ENDIF
!---------------------------------------
! Generated code from module definition 
!---------------------------------------


! 140:[const] Real Constant 

      RT_1 = 0.0

!---------------------------------------
! Feedbacks and transfers to storage 
!---------------------------------------

      STOF(ISTOF + 19) = RT_1


!---------------------------------------
! Close Model Data read 
!---------------------------------------

      IF ( TIMEZERO ) CALL EMTDC_CLOSEFILE
      RETURN
      END

!=======================================================================

      SUBROUTINE PWM_1Dyn_Begin()

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


!---------------------------------------
! Variable Declarations 
!---------------------------------------


! Subroutine Arguments

! Electrical Node Indices

! Control Signals
      REAL     RT_1

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


! 40:[datatap] Scalar/Array Tap 

! 50:[datatap] Scalar/Array Tap 

! 60:[datatap] Scalar/Array Tap 

! 70:[datatap] Scalar/Array Tap 

! 80:[unity] Type/Shape conversion block 

! 90:[pgb] Output Channel 'RefA'

! 100:[pgb] Output Channel 'RefB'

! 110:[pgb] Output Channel 'RefC'

! 120:[mult] Multiplier 

! 130:[sig_gen] Variable Frequency Sawtooth Generator 
      CALL COMPONENT_ID(ICALL_NO,577592328)
      CALL SAWTOOTH1_CFG(1.0,-1.0)

! 140:[const] Real Constant 
      RT_1 = 0.0

! 150:[pgb] Output Channel 'Carrier'

! 160:[datamerge] Merges data signals into an array 

! 170:[compar] Two Input Comparator 

! 180:[compar] Two Input Comparator 

! 190:[compar] Two Input Comparator 

! 210:[inv] Interpolated Logic Inverter 

! 240:[inv] Interpolated Logic Inverter 

! 270:[inv] Interpolated Logic Inverter 

! 290:[datamerge] Merges data signals into an array 

! 300:[pgb] Output Channel 'pulse3'

! 310:[pgb] Output Channel 'pulse2'

! 320:[pgb] Output Channel 'Carrier'

! 330:[pgb] Output Channel 'pulse1'

      RETURN
      END

!=======================================================================

      SUBROUTINE PWM_1Out_Begin()

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


!---------------------------------------
! Variable Declarations 
!---------------------------------------


! Subroutine Arguments

! Electrical Node Indices

! Control Signals
      REAL     RT_1

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


! 140:[const] Real Constant 
      RT_1 = 0.0

      RETURN
      END

