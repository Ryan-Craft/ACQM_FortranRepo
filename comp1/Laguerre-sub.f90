

program LaguerreSub
        implicit none

        ! need int N, real alpha, real l

        real :: alpha, l
        real :: dr, rmax
        integer :: N, nr
        integer :: i,j,k
        real, dimension(:), allocatable :: rgrid
        real, dimension (:,:), allocatable :: basis


        

        open(unit=1, file="LaguerreParams.txt", action="read")

        read(1,*) alpha, N, l, dr, rmax
       
        Print *, alpha, N, l, dr, rmax

        allocate(rgrid(nr))
        allocate(basis(N,N))

        !calculate rgrid params
        nr = rmax/dr
        
        !populate the rgrid
        do i = 1, nr
                rgrid(i) = (i-1)*dr
                Print *, rgrid(i)
        end do 

        basis(:,1) = (2.0d0*alpha*rgrid(:)) ** (l+1)*exp(-alpha*rgrid(:))
        
        do j = 1, N
                Print *, basis(j,1)
        end do






end program
