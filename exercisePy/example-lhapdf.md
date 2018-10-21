Imprort ROOT, math functions, lhapdf
```
from ROOT import gRandom
from math import sqrt, log
import lhapdf
```
Import the pdf by name, try also "MRST2004nlo" or "MRST2007lomod" (LO)
```
name = "MRSTMCal"	
pdf = lhapdf.getPDFSet(name).mkPDF(0)
```
We will evaluate the sum rule at scale 10 GeV 
```
Q = 10.0
```
Get the xmin and xmin from info in the PDF set
```
xmin, xmax = pdf.xMin, pdf.xMax
```
MC integration with importance sampling 1/x
```
npoints = 10000
sum0 = sum00 = 0
for n in range(npoints):
    # for simple integration
    # x = xmin + (xmax-xmin)*Rand();
    # for importance sampling
    x = xmin * (xmax/xmin)**gRandom.Uniform()
    #  sum over all flavors for mom sum rule
    f=0
    for fl in range(-6, 7):
        f += pdf.xfxQ(fl, x, Q)

    ff = f*x*log(xmax/xmin)
    sum0  +=  ff
    sum00 +=  ff**2
```
Normalize to npoints and calculate the error
```
sum0  /= npoints
sum00 /= npoints
sigma2 = sum00 - sum0*sum0
error = sqrt(sigma2/npoints)
```
And finally result:
```
print " momentum sum rule is: ", sum0, "+/-", error
```
