
subroutine LaguerreSub(alpha, nr, N, rgrid, basis, k_list, l_list, num_func)
        implicit none
        
        !generate local variables
        integer*8 :: p
        integer :: i,j, num_func
        real :: l
        real*8 :: normalise
        
        !generate input and output variables
        integer, intent(in) :: nr
        integer, INTENT(IN) :: N      
        real*8, INTENT(IN) :: alpha

        !generate input and output arrays
        real*8, dimension(nr), INTENT(IN) :: rgrid
        real*8, dimension(nr,N) :: basis
        real, dimension(num_func), INTENT(IN) :: k_list
        real, dimension(num_func), INTENT(IN) :: l_list

        basis(:,1) = (2.0d0*alpha*rgrid(:))**(l_list(1)+1) *exp(-alpha*rgrid(:))
        basis(:,2) = 2.0d0*((l_list(1)+1)-alpha*rgrid(:)) * (2.0d0*alpha*rgrid(:))**(l_list(1)+1) *exp(-alpha*rgrid(:))

        do i = 3, num_func
              if(k_list(i) .eq. 1) then
                    basis(:,i) = (2.0d0*alpha*rgrid(:))**(l_list(i)+1) *exp(-alpha*rgrid(:))
              
              else if(k_list(i) .eq. 2) then
                    basis(:,i) = 2.0d0*((l_list(i)+1)-alpha*rgrid(:)) * (2.0d0*alpha*rgrid(:))**(l_list(i)+1) *exp(-alpha*rgrid(:))
              else
                    basis(:,i) = (2*(k_list(i)-1+l_list(i)-alpha*rgrid(:))*basis(:,k_list(i)-1) - (k_list(i)+2*l_list(i)-1)*basis(:,k_list(i)-2) )  / (k_list(i)-1)
              end if
        end do


        do i = 1,num_func
              p=1.0
              do j = 0, 2*l_list(i)
                       p = p*(k_list(i)+2*l_list(i)-j)
                       Print *, p, j
              end do
              !normalise = sqrt(alpha /((k_list(i)+l_list(i))* p))
              Print *, "Norm:: ", normalise
              !basis(:,i) = normalise*basis(:,i)

        end do
        


 
        return
end subroutine LaguerreSub


program main
         implicit none


         real*8 :: normalise
         real*8 :: alpha, lmax, l
         real*8 :: dr, rmax
         integer :: N, nr, ier, par, m
         integer :: i,j, num_func
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
         real*8, dimension(:,:), allocatable :: wf
          
         ! create 1D arrays to hold the k_list and l_list to know which basis go where wrt parity
         real, dimension(:), allocatable :: k_list
         real, dimension(:), allocatable :: l_list

         !open file location: hard coded for now but could become flexible
         !read stored values into relevent variables
         
         open(unit=1, file="LaguerreParams.txt", action="read")
         read(1,*) alpha, N, lmax, dr, rmax, par, m
         Print *, alpha, N, lmax, dr, rmax,  par, m
         close(1)
         !calculate rgrid params
         nr = rmax/dr + 1
         Print *, nr

         !number of basis functions is the same for each l, but the total number of basis functions for a parity is larger than N
         !seems that we still need l->lmax  and we put all of them into basis array regardles of the parity
         !the parity essentially selects which l we are going to use 
         ! I need to use num_func to figure out the memory allocations:

         num_func = 0
         do l=0, lmax
                 if((-1)**l /= par .or. l < m) cycle
                 num_func = num_func + N
         end do
         Print *, num_func

         ! lectures point out that I will essentially be using k_list and l_list to keep track of where the right basis are
         ! for a given parity. We'll see how that works out down here somewhere
         allocate(k_list(num_func), l_list(num_func))
         i=0
         do l=0, lmax
                 if((-1)**l /= par .or. l<m) cycle
                 do j=1, N
                         i = i + 1
                         k_list(i) = real(j)
                         l_list(i) = real(l)
                 end do
         end do
         Print *, k_list
         Print *, l_list 

         ! based on options from file, allocate appropriate memory to rgrid and the basis array
         allocate(rgrid(nr))
         allocate(basis(nr,num_func))
         allocate(H(num_func,num_func))
         allocate(B(num_func,num_func))
         allocate(V(num_func,num_func))
         !allocate(w(N,1)) 
         !allocate(z(N,N))
         !allocate (wf(nr,N))
         
         !create rgrid
         do i = 1, nr
                rgrid(i) = (i-1)*dr
         end do
                    

         basis =0.0d0
         CALL LaguerreSub(alpha, nr, N, rgrid, basis, k_list, l_list, num_func)    
        
         open(unit=1, file="basisout.txt", action="write")
         do i=1,nr
                 write(1, '(*(f12.8))'), rgrid(i), basis(i,:)
         end do
         close(1)

         ! B matrix
         ! its like the B matrix for a single l but they are next one another on the diagonal
         B = 0.0d0
         do i =1,num_func-1
                 B(i,i) = 1.0d0
                 l = l_list(i)
                 j = k_list(i)
                 if(l_list(i+1) /= l ) cycle
                 B(i,i+1) = -0.5d0*sqrt(1.0d0-( (l*(l+1.0d0)) / ((j+l)*(j+l+1.0d0))))
                 B(i+1,i) = B(i,i+1)
         end do
    
         do i=1,num_func
                 Print *, B(i,:)
         end do 


         ! V-matrix elements

         ! K-Matrix elements   
 
 
         ! H = K + V






 
 
         deallocate(rgrid)
         deallocate(basis)
         if (N>1) then 
            deallocate(H)
            deallocate(B)
            deallocate(V)
            !deallocate(w)
            !deallocate(z)
            !deallocate(wf)
         endif

       

end program























