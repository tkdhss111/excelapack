!===================================================
!
! Excel VBA API (Dynamic link library)
!
! This communicates w/ Excel <-> lapack.exe
!
! (Input)
!    Variables from Excel VBA/spread sheet
!
! (Output)
!    Variables for Excel VBA/spread sheet
!
! Created by: Hisashi Takeda, Ph.D. on: 2020-03-23. 

subroutine lapack ( isub, a1, b1, c1, a2, b2, c2, a3, b3, c3, ma, mb, mc, va, vb, vc )
    
  !DEC$ ATTRIBUTES DLLEXPORT, STDCALL :: lapack
  
  integer, intent(inout) :: isub       ! Subroutine no. in Fortran exe
  integer, intent(inout) :: a1, b1, c1 ! Matrix size rows
  integer, intent(inout) :: a2, b2, c2 ! Matrix size cols
  integer, intent(inout) :: a3, b3, c3 ! Vector size
  real(8), intent(inout) :: ma(a1, a2) ! Matrix A
  real(8), intent(inout) :: mb(b1, b2) ! Matrix B
  real(8), intent(inout) :: mc(c1, c2) ! Matrix C
  real(8), intent(inout) :: va(a3), vb(b3), vc(c3) ! Vectors a, b and c
  integer u

  !
  ! Write input data for BLAS / LAPACK
  !
  open ( newunit = u,  file = 'lapack_input', form = 'unformatted' )

  write (u) isub
  write (u) a1, b1, c1
  write (u) a2, b2, c2
  write (u) a3, b3, c3
  write (u) ma, mb, mc
  write (u) va, vb, vc

  close (u)

  !
  ! Perform BLAS / LAPACK calculation
  !
  call execute_command_line ( 'cmd /c lapack.exe> lapack.log 2>&1' )

  !
  ! Read calculation results of BLAS / LAPACK
  !
  open ( newunit = u,  file = 'lapack_output', form = 'unformatted' )

  read (u) isub
  read (u) a1, b1, c1
  read (u) a2, b2, c2
  read (u) a3, b3, c3
  read (u) ma, mb, mc
  read (u) va, vb, vc

  close (u)

end subroutine
