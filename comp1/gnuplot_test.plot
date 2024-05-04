
l=1
a=1

expo(x) = 2*a*x
base(x) = (2*a*x)**(l+1) * exp(-a*x)


L0(x) =  1
L1(x) = -expo(x) + 2*(l+1)
L2(x) = (expo(x)**2)/2 - expo(x)*(2*l+3) + (2*l+2)*(2*l+3)/2
L3(x) = -(expo(x)**3)/6 + ((2*l+4)*expo(x)**2)/2 - ((2*l+3)*(2*l+4)*expo(x))/2 + ((2*l+2)*(2*l+3)*(2*l+4))/6

psi11(x) = base(x) * L0(x)
psi21(x) = base(x) * L1(x)
psi31(x) = base(x) * L2(x)
psi41(x) = base(x) * L3(x)


set xrange [-0.1:20]
set yrange [-12:12]
set grid


plot psi11(x), psi21(x), psi31(x), psi41(x)



