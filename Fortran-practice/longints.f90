
program longints
	implicit none

	! two byte integer
	integer(kind=2) :: shortval

	! four byte integer
	integer(kind =4) :: longval

	!sixteen byte integer
	integer(kind = 16) ::  veryverylongval

	print *, huge(shortval)
	print *, huge(longval)
	print *, huge(veryverylongval)

end program longints
