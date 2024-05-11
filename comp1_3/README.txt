Hello, I noticed that my chaotic method of plotting might not be so clear so please have a look at this little descriptions
to help recreate some of the plots if thats what you want.

#main.f90:
-contains LaguerreSub subroutine and the rest of the functioning code.
- depends on rsg.f and LaguerreParams.txt

#LaguerreParams.txt:
- holds the space separated values of <alpha, N, l, dr, rmax> ie. 2 100 0 0.5 35
- read by main.f90 to get initial input parameters


#basis_test.plot:
plots the first 4 laguerre polynomials using functions in the .plot file and from data read from 'basisout.txt'
Make sure a and l in the plot file are the same as alpha and l in LaguerreParams.txt or the plots wont match up.

#boundenergies.plot:
- plots bound energies of the main.f90 output.
- Read values in from a file called analytical.txt and wout.txt.
- wout.txt must start empty for new data, and we run LaguerreParams.txt
once for every value of N in {5,10,20,30,40,50}. This will populate the wout.txt file with energies for every N.
- analytical.txt holds a finite set of the analytical energies to compare on the plot

#continuumenergies.plot:
- plots bound energies of the main.f90 output.
- Read values in from a file called wout.txt
- see #boundenergies, dont need to run the N's again if already done once.


#fixedN.plot and fixedNpos.plot
- Plots bound and contiunuum energies predicted for alphas 1-5.
- Reads files a{1..5}.txt for store values of energies created from a set of main.f90 runs for N=50.

#wf1.plot and wf2.plot
- wf1 plots the first three s states from analytical solutions and compares it with data values from main.f90 stored in
wfout.txt. 
- wf2 does the same thing but for the p states.
- wfout.txt stores the last generated wavefunctions from main, so make sure you pass the right l and alpha=1 into the LaguerreParams.txt and run before comparing with the analytical solutions or they will not match
