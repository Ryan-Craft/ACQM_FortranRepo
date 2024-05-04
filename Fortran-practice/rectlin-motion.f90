

! Program computes trajectories of 2D projectiles under earth gravity on the flat plane

program rectilinMotion
    
    implicit none
    
    real :: g
    real :: u_y, u_x, u, time, time_increment
    real :: time_temp, angle
    real, dimension(100) :: time_array
    real, dimension(100) :: s_x
    real, dimension(100) :: s_y
    integer :: i
     
    character(100) :: uChar
    character(100) :: timeChar
    character(100) :: angleChar

    if(command_argument_count().NE.3) then
        Print *, "INCORRECT COMMAND LINE ARGUMENTS: PROVIDE INITIAL VELOCITY (m/s), INCLINE ANGLE (DEG) and SIMULATION TIME (s)"
        stop
    endif

    CALL get_command_argument(1,uChar)
    CALL get_command_argument(3,timeChar)
    CALL get_command_argument(2,angleChar)
    
    read(uChar,*)u
    read(timeChar,*)time
    read(angleChar,*)angle
  
    g = 9.81
    u_x = u*cos(angle)
    u_y = u*sin(angle)
    
    time_increment = time/100
    print *, time_increment
    do i=1,100
        time_temp = real(time_increment*i)
        time_array(i) = time_temp      
        s_y(i) = u_y*time_temp - 0.5*g*time_temp**2
        s_x(i) = u_x*time_temp
    end do
 
    open(1, file = 'output.dat', status= 'replace')
    
    do i=1,100
        write(1,*) time_array(i), s_y(i), s_x(i) 
    end do
    
    close(1) 



end program
    
