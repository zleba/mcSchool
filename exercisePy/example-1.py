#!/usr/bin/env  python
# ---
# jupyter:
#   kernelspec:
#     name: python2
#     display_name: Python 2
# ---

# # Correlations between random numbers
# First import from ROOT libraries which are needed

from  ROOT import TH2D, TCanvas, gRandom

# Define the 2D histograms to display the correlation between random numbers

hConguent= TH2D("Congruent", "congruental random numbers ",100, 0, 1, 100, 0, 1)
hRANLUX = TH2D("RANLUX", "RANLUX",100, 0, 1, 100, 0, 1)

# Define our first congruent generator

def randCon():
    im = 139968
    randCon.r = (205*randCon.r+29573) % im #get next random number
    return float(randCon.r) / im #return normalized one
randCon.r = 4771 #Starting value (seed)

# Number of points to be generated

npoints = 100000

# Generate npoint pairs of random numbers with congruent generator and fill it to 2D histogram

for n in range(npoints):
    xC = randCon()
    yC = randCon()
    hConguent.Fill(xC, yC)

# Do the same for the more advanced random number generator

for n in range(npoints):
    xRL = gRandom.Uniform()
    yRL = gRandom.Uniform()
    hRANLUX.Fill(xRL, yRL)

# Plotting the results

c = TCanvas()
hConguent.Draw()
c.Draw()

d = TCanvas()
hRANLUX.Draw()
d.Draw()
