!=======================================================
!
! Test Data 
!
! This data are used for debugging purpose 
!
! (Input)
!   All variables defined in the main program 
!
! (Output)
!   All variables defined in the main program 
!
! Created by: Hisashi Takeda, Ph.D. on: 2020-03-23. 

subroutine set_test_data ()

  isub = 1

  a1 = 3
  a2 = 3

  b1 = 3
  b2 = 3

  c1 = 3
  c2 = 3

  a3 = 3
  b3 = 3
  c3 = 3

  allocate ( ma(a1, a2) )
  allocate ( mb(b1, b2) )
  allocate ( mc(c1, c2) )
  allocate ( va(a3), vb(b3), vc(c3) )

  ma = reshape([1, 4, 7, 2, 5, 8, 3, 6, 0], shape = [a1, a2])
  mb = reshape([1, 1, 1, 1, 1, 1, 1, 1, 1], shape = [b1, b2])
  mc = reshape([1, 1, 1, 1, 1, 1, 1, 1, 1], shape = [c1, c2])

  va = [1, 2, 3]
  vb = [1, 1, 1]
  vc = [7, 8, 9]

  !**********************************
  ! Overwrite unused variables w/ NA
  mb = NA
  mc = NA
  va = NA
  vc = NA
  !**********************************

end subroutine
