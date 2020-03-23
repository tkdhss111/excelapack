!===================================================
!
! User-defined Subroutine 
!
! (Input)
!   All variables defined in the main program 
!
! (Output)
!   All variables defined in the main program 
!
! Created by: Hisashi Takeda, Ph.D. on: 2020-03-23. 

!---------------------------------------------------
! LU factorization of a general matrix
!
! cf P228 mklman90_j.pdf
!
subroutine s01 ()

  integer, allocatable :: ipiv(:)
  integer i, info

  allocate ( ipiv(min(a1, a2)) )

  call getrf (ma, ipiv, info)

  if ( info /= 0 ) stop 'Error on getrf'

  do i = 1, a1

    ma(i, i:) = 0.0d0
    ma(i, i)  = 1.0d0

  end do

end subroutine

!---------------------------------------------------
! Multiplication of general matrices
!
! cf P121 mklman90_j.pdf
!
subroutine s02 ()

  call gemm ( ma, mb, mc )

end subroutine

!---------------------------------------------------
!
!
subroutine s03 ()
end subroutine

!---------------------------------------------------
!
!
subroutine s04 ()
end subroutine

!---------------------------------------------------
!
!
subroutine s05 ()
end subroutine
