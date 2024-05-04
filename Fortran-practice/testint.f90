
program testInt

	implicit none

	
	! integer types use 4 bytes
	integer :: largeval

	! the huge() command gives the largest number that can be held in that type
	print *, huge(largeval)

end program testInt
