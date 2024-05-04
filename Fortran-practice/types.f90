
program types

	implicit none

	!Using kind you can define the number of bytes allocated to a variable
	! this enables things like integers to be extended

	integer :: i, j, intRes

	!normal ints use 4 bytes

	!The real type stores floating point numbers
	! we can also modify the real type using kind

	real :: p, q, realRes
	

	i = 2
	j = 3
	p = 2.0
	q= 3.0



	!floating point division
	
	realRes = p/q	


	!Integer division
	
	intRes = i/j

	!print the values to see the difference

	print *, 'float 2/3', realRes
	print *, 'int 2/3', intRes


	! The FORTRAN language also has complex types without the need for a library or extension
	! The 5 types are: Integer, Real (float), Complex, Logical (Boolean) and Character (strings and char)






















end program types

	
