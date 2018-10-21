# Example on the importance sampling usage
Import what will be needed
```
from ROOT import gRandom, TMath
from math import sqrt, log
```
Define function which we want to integrate 
```
def g0(z):
    return (1 - z)**5 / z
```
The lower limit of the integration, the upper is 1
```
xmin = 1e-4
```
Generate npoints randomly with importance sampling 
```
npoints = 1000000
xg0 = xg00 = 0
for n1 in range(npoints):
    #here do the calcualtion with importance sampling
    x0 = xmin**gRandom.Uniform()
    weight = x0*log(1/xmin)
    # here do the calcualtion using linear sampling
    # x0 = xmin+(1-xmin)*gRandom.Uniform()
    # weight = 1-xmin
    f  = g0(x0) 
    ff = weight*f
    xg0  +=  ff
    xg00 +=  ff**2
```
Calculate the MC integral
```
xg0  /= npoints
xg00 /= npoints
sigma2 = xg00 - xg0*xg0
error  = sqrt(sigma2/npoints)
print " integral for g(x) = (1-x)**5/x is: ",xg0,"+/-", error
```
Get the exact value using incomplete beta function [https://en.wikipedia.org/wiki/Beta_function]
```
x = 1-xmin
a = 5
b = -0.9999999999
print "Exact value ", TMath.BetaIncomplete(x, a+1, b+1) * TMath.Beta(a+1, b+1)
```
