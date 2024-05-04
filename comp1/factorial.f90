
program factorial

        integer :: i,t
        real :: a, l, k, p
        real :: f1, f2, s
       
        k=2.0
        a=1.0
        l=1.0
        
        f1 = sqrt((a*gamma(k))/((k+l)*gamma(k+2*l+1))) 
        

        Print *, "Gamma factorial: ", f1

        !implement my new method
        p=1.0
        do i = 0, 2*l
                p = real(p*(k+2*l-i)) 
                Print *, p, i
        end do

        f2 = sqrt(a /((k+l)* p))

        Print *, "Simple factorial: ", f2

end program

