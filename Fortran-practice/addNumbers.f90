! All fortran programs start with the keyword program and end with end program, followed by the program name
program addNumbers
	! implicit none tells the compiler to make sure that all of the variables are declared properly, not implicitly
	implicit none
	
	real :: a, b, result

	a = 12.0
	b = 15.0

	result = a + b
	

	! print * prints things to the terminal, fortran code is case sensitive except for string literals
	print *, 'Total = ', result

end program addNumbers
