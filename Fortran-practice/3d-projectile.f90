

! Program computes trajectories of 2D projectiles under earth gravity on the flat plane

program rectilinMotion
    
    implicit none
    
    real :: g
    real :: u_y, u_x, u_z, u, time, time_increment
    real :: time_temp, theta, phi
    real, dimension(100) :: time_array
    real, dimension(100) :: s_x
    real, dimension(100) :: s_y
    real, dimension(100) :: s_z
    integer :: i
     
    character(100) :: uChar
    character(100) :: timeChar
    character(100) :: thetaChar
    character(100) :: phiChar

    if(command_argument_count().NE.4) then
        Print *, "INCORRECT COMMAND LINE ARGUMENTS: PROVIDE INITIAL VELOCITY MAGNITUDE (m/s), SIMULATION TIME (S), THETA AND PHI."
        stop
    endif

    CALL get_command_argument(1,uChar)
    CALL get_command_argument(2,timeChar)
    CALL get_command_argument(3,thetaChar)
    CALL get_command_argument(4,phiChar)
    
    read(uChar,*)u
    read(timeChar,*)time
    read(thetaChar,*)theta
    read(phiChar,*)phi
    
    Print *, u
    Print *, time
    Print *, theta
    Print *, phi 


    g = 9.81
    u_x = COSD(theta)*COSD(phi)*u
    u_y = COSD(phi)*SIND(theta)*u
    u_z = SIND(phi)*u
    
    Print *, u_x
    Print *, u_y
    Print *, u_z



    time_increment = time/100
    print *, time_increment
    


    do i=1,100
        time_temp = real(time_increment*i)
        time_array(i) = time_temp      
        s_z(i) = u_z*time_temp - 0.5*g*time_temp**2
        s_x(i) = u_x*time_temp
        s_y(i) = u_y*time_temp
    end do
 
    open(1, file = '3d-project.dat', status= 'replace')
    
    do i=0,100
        write(1,*)s_x(i), s_y(i), s_z(i)
    end do
    
    close(1) 



end program
    
