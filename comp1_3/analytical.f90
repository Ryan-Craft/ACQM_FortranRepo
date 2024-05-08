
program analytical
 
      real :: E
      integer :: i


      open(1, file='analytical.txt',action='write')
         do i =1,1000
                 E = -0.5/i**2
                 write(1, '(*(f12.8))'), 60.0d0, E
         end do



end program
