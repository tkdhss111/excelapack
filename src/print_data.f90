!=======================================================
!
! Log Printer 
!
! This prints all variables defined in the main program 
!
! (Input)
!   All variables defined in the main program 
!
! (Output)
!   None
!
! Created by: Hisashi Takeda, Ph.D. on: 2020-03-23. 

subroutine print_data (fu)

  integer, optional, intent(in) :: fu
  integer i, j, u

  1 format(a)
  2 format(a, i0)
  3 format(a, i0, a, i0)
  4 format(*(f6.2))

  if ( present(fu) ) then
    u = fu
  else
    u = 6
  end if

  write (u, 1) repeat('=', 70)
  write (u, 2) 'Subroutine no.: ', isub 

  write (u, 1) repeat('-', 70)
  write (u, 3) 'Matrix A (ma) of size ', a1, 'x',  a2

  do i = 1, a1
    write (u, 4) [ (ma(i, j), j = 1, a2) ]
  end do

  write (u, 1) repeat('-', 70)
  write (u, 3) 'Matrix B (mb) of size ', b1, 'x',  b2

  do i = 1, b1
    write (u, 4) [ (mb(i, j), j = 1, b2) ]
  end do

  write (u, 1) repeat('-', 70)
  write (u, 3) 'Matrix C (mc) of size ', c1, 'x',  c2

  do i = 1, c1
    write (u, 4) [ (mc(i, j), j = 1, c2) ]
  end do

  write (u, 1) repeat('-', 70)
  write (u, 2) 'Vector a (va) of size ',  a3
  write (u, 4) [ (va(i), i = 1, a3) ]

  write (u, 1) repeat('-', 70)
  write (u, 2) 'Vector b (vb) of size ',  b3
  write (u, 4) [ (vb(i), i = 1, b3) ]

  write (u, 1) repeat('-', 70)
  write (u, 2) 'Vector c (vc) of size ',  c3
  write (u, 4) [ (vc(i), i = 1, c3) ]

  write (u, 1) repeat('=', 70)
  write (u, 1) ''

end subroutine
