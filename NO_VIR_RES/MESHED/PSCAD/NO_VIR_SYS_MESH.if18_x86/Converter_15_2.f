!=======================================================================
! Generated by: PSCAD v5.0.1.0
! Warning:  The content of this file is automatically generated.
!           Do not modify, as any changes made here will be lost!
!-----------------------------------------------------------------------
! Component     : Converter_15_2
! Description   : 
!-----------------------------------------------------------------------


!=======================================================================

      SUBROUTINE Converter_15_2Dyn(V_ref)

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
! Variable Declarations 
!---------------------------------------


! Subroutine Arguments
      REAL,    INTENT(IN)  :: V_ref(3)

! Electrical Node Indices

! Control Signals
      REAL     Vc, Vb, Va

! Internal Variables
      REAL     RVD1_1, RVD1_2, RVD1_3, RVD1_4

! Indexing variables
      INTEGER ICALL_NO                            ! Module call num
      INTEGER ISTOF, IT_0                         ! Storage Indices
      INTEGER ISUBS, SS(1), IBRCH(1), INODE       ! SS/Node/Branch/Xfmr


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
      NSTOF     = NSTOF + 6
      INODE     = NNODE + 2
      NNODE     = NNODE + 5
      NCSCS     = NCSCS + 0
      NCSCR     = NCSCR + 0

! Initialize Subsystem Mapping

      ISUBS = NSUBS + 0
      NSUBS = NSUBS + 1

      DO IT_0 = 1,1
         SS(IT_0) = SUBS(ISUBS + IT_0)
      END DO

! Initialize Branch Mapping.

      IBRCH(1)     = NBRCH(SS(1))
      NBRCH(SS(1)) = NBRCH(SS(1)) + 3

!---------------------------------------
! Transfers from storage arrays 
!---------------------------------------

      Vc       = STOF(ISTOF + 4)
      Vb       = STOF(ISTOF + 5)
      Va       = STOF(ISTOF + 6)


!---------------------------------------
! Electrical Node Lookup 
!---------------------------------------


!---------------------------------------
! Configuration of Models 
!---------------------------------------

      IF ( TIMEZERO ) THEN
         FILENAME = 'Converter_15_2.dta'
         CALL EMTDC_OPENFILE
         SECTION = 'DATADSD:'
         CALL EMTDC_GOTOSECTION
      ENDIF
!---------------------------------------
! Generated code from module definition 
!---------------------------------------


! 20:[datatap] Scalar/Array Tap 
      Va = V_ref(1)

! 30:[datatap] Scalar/Array Tap 
      Vb = V_ref(2)

! 40:[datatap] Scalar/Array Tap 
      Vc = V_ref(3)

! 50:[source_1] Single Phase Voltage Source Model 2 'Source1'
! Externally controlled DC source: Type: Ideal
      RVD1_1 = Vc
      RVD1_2 = 0.0
      RVD1_3 = RTCF(NRTCF)
      RVD1_4 = RTCF(NRTCF+1)
      NRTCF  = NRTCF + 2
      CALL EMTDC_1PVSRC(SS(1), (IBRCH(1)+3),RVD1_4,0,RVD1_1,RVD1_2,RVD1_&
     &3)

! 60:[source_1] Single Phase Voltage Source Model 2 'Source1'
! Externally controlled DC source: Type: Ideal
      RVD1_1 = Vb
      RVD1_2 = 0.0
      RVD1_3 = RTCF(NRTCF)
      RVD1_4 = RTCF(NRTCF+1)
      NRTCF  = NRTCF + 2
      CALL EMTDC_1PVSRC(SS(1), (IBRCH(1)+2),RVD1_4,0,RVD1_1,RVD1_2,RVD1_&
     &3)

! 70:[source_1] Single Phase Voltage Source Model 2 'Source1'
! Externally controlled DC source: Type: Ideal
      RVD1_1 = Va
      RVD1_2 = 0.0
      RVD1_3 = RTCF(NRTCF)
      RVD1_4 = RTCF(NRTCF+1)
      NRTCF  = NRTCF + 2
      CALL EMTDC_1PVSRC(SS(1), (IBRCH(1)+1),RVD1_4,0,RVD1_1,RVD1_2,RVD1_&
     &3)

!---------------------------------------
! Feedbacks and transfers to storage 
!---------------------------------------

      STOF(ISTOF + 4) = Vc
      STOF(ISTOF + 5) = Vb
      STOF(ISTOF + 6) = Va

! Array (1:3) quantities...
      DO IT_0 = 1,3
         STOF(ISTOF + 0 + IT_0) = V_ref(IT_0)
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

      SUBROUTINE Converter_15_2Out()

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
! Variable Declarations 
!---------------------------------------


! Electrical Node Indices

! Control Signals

! Internal Variables

! Indexing variables
      INTEGER ICALL_NO                            ! Module call num
      INTEGER ISTOL, ISTOI, ISTOF, ISTOC, IT_0    ! Storage Indices
      INTEGER ISUBS, SS(1), IBRCH(1), INODE       ! SS/Node/Branch/Xfmr


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

      INODE     = NNODE + 2
      NNODE     = NNODE + 5
      NCSCS     = NCSCS + 0
      NCSCR     = NCSCR + 0

! Initialize Subsystem Mapping

      ISUBS = NSUBS + 0
      NSUBS = NSUBS + 1

      DO IT_0 = 1,1
         SS(IT_0) = SUBS(ISUBS + IT_0)
      END DO

! Initialize Branch Mapping.

      IBRCH(1)     = NBRCH(SS(1))
      NBRCH(SS(1)) = NBRCH(SS(1)) + 3

!---------------------------------------
! Transfers from storage arrays 
!---------------------------------------



!---------------------------------------
! Electrical Node Lookup 
!---------------------------------------


!---------------------------------------
! Configuration of Models 
!---------------------------------------

      IF ( TIMEZERO ) THEN
         FILENAME = 'Converter_15_2.dta'
         CALL EMTDC_OPENFILE
         SECTION = 'DATADSO:'
         CALL EMTDC_GOTOSECTION
      ENDIF
!---------------------------------------
! Generated code from module definition 
!---------------------------------------


!---------------------------------------
! Feedbacks and transfers to storage 
!---------------------------------------



!---------------------------------------
! Close Model Data read 
!---------------------------------------

      IF ( TIMEZERO ) CALL EMTDC_CLOSEFILE
      RETURN
      END

!=======================================================================

      SUBROUTINE Converter_15_2Dyn_Begin()

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
! Variable Declarations 
!---------------------------------------


! Subroutine Arguments

! Electrical Node Indices

! Control Signals

! Internal Variables

! Indexing variables
      INTEGER ICALL_NO                            ! Module call num
      INTEGER IT_0                                ! Storage Indices
      INTEGER ISUBS, SS(1), IBRCH(1), INODE       ! SS/Node/Branch/Xfmr


!---------------------------------------
! Local Indices 
!---------------------------------------


! Increment and assign runtime configuration call indices

      ICALL_NO  = NCALL_NO
      NCALL_NO  = NCALL_NO + 1

! Increment global storage indices

      INODE     = NNODE + 2
      NNODE     = NNODE + 5
      NCSCS     = NCSCS + 0
      NCSCR     = NCSCR + 0

! Initialize Subsystem Mapping

      ISUBS = NSUBS + 0
      NSUBS = NSUBS + 1

      DO IT_0 = 1,1
         SS(IT_0) = SUBS(ISUBS + IT_0)
      END DO

! Initialize Branch Mapping.

      IBRCH(1)     = NBRCH(SS(1))
      NBRCH(SS(1)) = NBRCH(SS(1)) + 3

!---------------------------------------
! Electrical Node Lookup 
!---------------------------------------


!---------------------------------------
! Generated code from module definition 
!---------------------------------------


! 20:[datatap] Scalar/Array Tap 

! 30:[datatap] Scalar/Array Tap 

! 40:[datatap] Scalar/Array Tap 

! 50:[source_1] Single Phase Voltage Source Model 2 'Source1'
      RTCF(NRTCF) = 0.0
      RTCF(NRTCF+1) = 0.0
      NRTCF = NRTCF + 2

! 60:[source_1] Single Phase Voltage Source Model 2 'Source1'
      RTCF(NRTCF) = 0.0
      RTCF(NRTCF+1) = 0.0
      NRTCF = NRTCF + 2

! 70:[source_1] Single Phase Voltage Source Model 2 'Source1'
      RTCF(NRTCF) = 0.0
      RTCF(NRTCF+1) = 0.0
      NRTCF = NRTCF + 2

      RETURN
      END

!=======================================================================

      SUBROUTINE Converter_15_2Out_Begin()

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
! Variable Declarations 
!---------------------------------------


! Subroutine Arguments

! Electrical Node Indices

! Control Signals

! Internal Variables

! Indexing variables
      INTEGER ICALL_NO                            ! Module call num
      INTEGER IT_0                                ! Storage Indices
      INTEGER ISUBS, SS(1), IBRCH(1), INODE       ! SS/Node/Branch/Xfmr


!---------------------------------------
! Local Indices 
!---------------------------------------


! Increment and assign runtime configuration call indices

      ICALL_NO  = NCALL_NO
      NCALL_NO  = NCALL_NO + 1

! Increment global storage indices

      INODE     = NNODE + 2
      NNODE     = NNODE + 5
      NCSCS     = NCSCS + 0
      NCSCR     = NCSCR + 0

! Initialize Subsystem Mapping

      ISUBS = NSUBS + 0
      NSUBS = NSUBS + 1

      DO IT_0 = 1,1
         SS(IT_0) = SUBS(ISUBS + IT_0)
      END DO

! Initialize Branch Mapping.

      IBRCH(1)     = NBRCH(SS(1))
      NBRCH(SS(1)) = NBRCH(SS(1)) + 3

!---------------------------------------
! Electrical Node Lookup 
!---------------------------------------


!---------------------------------------
! Generated code from module definition 
!---------------------------------------


      RETURN
      END

