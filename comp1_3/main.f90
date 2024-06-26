
subroutine LaguerreSub(alpha, l, nr, N, rgrid, basis)
        implicit none

        ! initialise alpha, l, dr, rmax, N and others
        integer :: i,j
        integer, intent(in) :: nr
        integer, INTENT(IN) :: N
        real*8, INTENT(IN) :: alpha, l
        real*8, dimension(nr), INTENT(IN) :: rgrid
        real*8, dimension(nr,N) :: basis
        
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


         real*8 :: normalise
         real*8 :: alpha, l
         real*8 :: dr, rmax
         integer*8 :: p
         integer :: N, nr, ier
         integer :: i,j
         real, dimension(:), allocatable :: rgrid
         real, dimension(:,:), allocatable :: basis
         
         !add in overlap and hamiltonian
         real*8, dimension(:,:), allocatable :: H
         real*8, dimension(:,:), allocatable :: B
         real*8, dimension(:,:), allocatable :: K
         ! energies and expansion coefficients
         real*8, dimension(:,:), allocatable :: w
         real*8, dimension(:,:), allocatable :: z
         real*8, dimension(:,:), allocatable :: V
         ! create array for wavefunctions
         real,dimension(:,:), allocatable :: wf

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
         allocate(H(N,N))
         allocate(B(N,N))
         allocate(V(N,N))
         allocate(w(N,1)) 
         allocate(z(N,N))
         allocate (wf(nr,N))

         !allocate values to the rgrid
         do i = 1, nr
                rgrid(i) = (i-1)*dr
         end do 


         !use recurrence relation to compute the basis functions
         CALL LaguerreSub(alpha, l, nr, N, rgrid, basis)
        
         !implement normalisation condition using simplified factorial
         do i = 1, N
                 p=1.0
                 do j = 0, 2*l
                         p = p*(i+2*l-j)
                         !Print *, p, j
                 end do
                 normalise = sqrt(alpha /((i+l)* p))
                 !Print *, "Norm:: ", normalise
                 basis(:,i) = normalise*basis(:,i)  
         end do

 
 
         !write basis to file for plotting 
         
         open(1, file='basisout.txt', action='write')
         do i =1,nr
                         write(1, '(*(f12.8))'), rgrid(i), basis(i,:)
         end do
         close(1)
        
         !calculate overlap matrix
         B = 0.0d0
         do i =1, N-1
                 B(i,i) = 1.0d0
                 ! basis function matrix elements are real valued, thus dot product is the same as inner prouct here
                 B(i,i+1) = -0.5d0*sqrt(1.0d0-( (l*(l+1.0d0)) / ((i+l)*(i+l+1.0d0))))
                 B(i+1,i) = B(i,i+1)
         end do
         B(N,N) = 1.0d0 
         
         !calculate V matrix:
         V = 0.0d0
         do i=1,N
                 V(i,i) = -(alpha/(i+l))
         end do
         
         !compute H-matrix Elements
         H = (-alpha**2/2.0) * B
         do i =1,N
                 H(i,i) = H(i,i) + alpha**2 - (alpha/(i+l)) 
         end do
         
         CALL rsg(N,N,H,B,w,1,z,ier)


         !recover wavefunctions:
         wf = 0.0d0
         do i =1,N
                 do j = 1,N
                         wf(:,i) = z(j,i)*basis(:,j) + wf(:,i)
                         !Print *, wf(:,i)
                 end do
         end do
         

         open(1, file='wfout.txt', action='write')
         do i =1,nr
                         write(1, '(*(f12.8))'), rgrid(i), wf(i,:)
         end do
         close(1)
         
         open(1, file='wout.txt',action='write', access='append')
         do i =1,N
                 write(1, '(*(f12.8))'), real(N), w(i,1)
         end do
 
         deallocate(rgrid)
         deallocate(basis)
         if (N>1) then
            deallocate(H)
            deallocate(B)
            deallocate(V)
            deallocate(w)
            deallocate(z)
            deallocate(wf)
         endif

       

end program























