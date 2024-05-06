
subroutine LaguerreSub(alpha, l, nr, N, rgrid, basis)
        implicit none

        ! initialise alpha, l, dr, rmax, N and others
        integer :: i,j
        integer, intent(in) :: nr
        integer, INTENT(IN) :: N
        real, INTENT(IN) :: alpha, l
        real, dimension(nr), INTENT(IN) :: rgrid
        real, dimension(nr,N) :: basis
        
        basis(:,1) = (2.0d0*alpha*rgrid(:))**(l+1) *exp(-alpha*rgrid(:))
        basis(:,2) = 2.0d0*(l+1-alpha*rgrid(:)) * (2.0d0*alpha*rgrid(:))**(l+1) *exp(-alpha*rgrid(:))

        !generate N laguerre basis using recurrence relation
        do i = 3, N
                basis(:,i) = (2*(i-1+l-alpha*rgrid(:))*basis(:,i-1) - (i+2*l-1)*basis(:,i-2) )  / (i-1)
        end do
        
        return
end subroutine LaguerreSub


program main
         implicit none




         real :: alpha, l
         real :: dr, rmax
         integer :: N, nr
         integer :: i,j,k
         real, dimension(:), allocatable :: rgrid
         real, dimension(:,:), allocatable :: basis
         !open file location: hard coded for now but could become flexible
         !read stored values into relevent variables
         
         open(unit=1, file="LaguerreParams.txt", action="read")
         read(1,*) alpha, N, l, dr, rmax
         Print *, alpha, N, l, dr, rmax

         !calculate rgrid params
         nr = rmax/dr + 1
         Print *, nr

         ! based on options from file, allocate appropriate memory to rgrid and the basis array
         allocate(rgrid(nr))
         allocate(basis(nr,N))
         !allocate values to the rgrid
         do i = 1, nr
                rgrid(i) = (i-1)*dr
         end do 


         !use recurrence relation to compute the basis functions
         CALL LaguerreSub(alpha, l, nr, N, rgrid, basis)
         
         Print *, "RGRID: basis 1 : basis 2 : basis 3 : basis 4 \n"
        do j = 1, nr
                Print *, rgrid(j), basis(j,1), basis(j,2), basis(j,3), basis(j,4)
        end do



end program






