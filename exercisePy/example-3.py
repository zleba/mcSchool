# ---
# jupyter:
#   kernelspec:
#     name: python2
#     display_name: Python 2
# ---

# # MC integration
# Define function which we want to integrate

from ROOT import gRandom
from math import sqrt

def g0(z):
    return 3*z*z; 

# Calculate the sum and sum2 of the function values at the random points

s = s2 = 0
npoints = 1000000
for n in range(npoints):
    x0 = gRandom.Uniform()
    f  = g0(x0) 
    s += f
    s2+= f**2

# Calculate average and average to the squared values

avg  = s  / npoints
avg2 = s2 / npoints

# Get the average deviation squared

sigma2 = avg2 - avg*avg

# The actuall error behaves as 1/sqrt(npoints)

error = sqrt(sigma2/npoints) ;

# Finally the result

print " integral for 3x**2 is: ", avg, "+/-", error
print " true integral for 3x**2 is : 1.0 "
