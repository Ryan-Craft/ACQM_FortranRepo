
program variables

	implicit none

	! variable declaration is done as follows -> type :: name

	!Example:

	integer :: total
	real :: average
	complex :: cx
	logical :: bool
	character(len=80) :: message ! 80 character string
	
	! assignment
	total = 20000
	average = 167.6667
	message = "Hello world"
	bool = .true.
	cx = (1,10)

	print *, total
	print *, average
	print *, bool
	print *, message
	print *, cx

end program variables
