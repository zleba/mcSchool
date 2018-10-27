# ---
# jupyter:
#   kernelspec:
#     name: python2
#     display_name: Python 2
# ---

# # Demonstration of hit & miss method
# Import what is needed

from ROOT import gRandom
from math import sqrt

# Loop over random points in the 2D space

nhit = 0
npoints = 2000000
for n in range(npoints):
    x,y = gRandom.Uniform(), gRandom.Uniform()
    #accept if y < x
    if y < x:
        nhit += 1

# Calculate the integral

Int = float(nhit)/npoints

# And error using binomial formula

sigma2 = (1. - Int)/nhit
error = sqrt(sigma2)*Int

# Show the results

print " integral for  is: ", Int, "+/-", error
print " true integral  is : 0.5 "
