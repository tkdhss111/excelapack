!===================================================
!
! BALS and LAPACK Console Application Program
!
! This reads binary input data from Excel API
!  and performs user-defined sunroutine
!  and writes results as binary file for Excel API.
!
! (Input)
!    Binary data from Excel VBA API (DLL)
!    (e.g.,  lapack_input)
!
! (Output)
!    Binary data for Excel VBA API (DLL)
!    (e.g.,  lapack_output)
!
! (Include)
!   1. Release mode
!     lapack_sub.f90    : User-defined subroutine
!     print_data.f90    : Print test data
!     
!   2. Debug mode
!     Release mode files +
!     set_test_data.f90 : Test data
!
! Created by: Hisashi Takeda, Ph.D. on: 2020-03-23. 

program main

  use blas95
  use lapack95

  implicit none

  integer              :: isub                         ! Subroutine no. in Fortran exe
  integer              :: a1, b1, c1                   ! Matrix size rows
  integer              :: a2, b2, c2                   ! Matrix size cols
  integer              :: a3, b3, c3                   ! Vector size
  real(8), allocatable :: ma(:, :), mb(:, :), mc(:, :) ! Matrix
  real(8), allocatable :: va(:), vb(:), vc(:)          ! Vector
  real(8), parameter   :: NA = -999.9d0
  character(255)       :: dir = ''
  integer u

#ifdef debug
  dir = '../bin/'

  call set_test_data

  call write_data (trim(dir)//'lapack_input')

  print *, ''
  print *, 'BEFORE'
  call print_data

  deallocate ( ma, mb, mc )
  deallocate ( va, vb, vc )
#endif

  call read_data (trim(dir)//'lapack_input')

  call calc_blaslapack

  call write_data (trim(dir)//'lapack_output')

#ifdef debug
  print *, 'AFTER'
  call print_data
#endif

contains

  include 'print_data.f90'

#ifdef debug
  include 'set_test_data.f90'
#endif

  include 'lapack_sub.f90'

  subroutine calc_blaslapack ()

    select case ( isub )

      case (1)
        call s01

      case (2)
        call s02

      case (3)
        call s03

      case (4)
        call s04

      case (5)
        call s05

      case default
        stop 'No such subroutine no.'

    end select

  end subroutine

  subroutine write_data (file)

    character(*), intent(in) :: file

    open ( newunit = u, file = file, form = 'unformatted' )

    write (u) isub
    write (u) a1, b1, c1
    write (u) a2, b2, c2
    write (u) a3, b3, c3
    write (u) ma, mb, mc
    write (u) va, vb, vc

    close (u)

    print *, 'After LAPACK calculation'
    call print_data

  end subroutine

  subroutine read_data (file)

    character(*), intent(in) :: file

    open ( newunit = u, file = file, form = 'unformatted' )

    read (u) isub
    read (u) a1, b1, c1
    read (u) a2, b2, c2
    read (u) a3, b3, c3

    allocate ( ma(a1, a2) )
    allocate ( mb(b1, b2) )
    allocate ( mc(c1, c2) )
    allocate ( va(a3), vb(b3), vc(c3) )

    read (u) ma, mb, mc
    read (u) va, vb, vc

    close (u)

    print *, 'Before LAPACK calculation'
    call print_data

  end subroutine

end program
