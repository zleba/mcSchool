## Correlations between random numbers
First import from ROOT libraries which
are needed

```python
from  ROOT import TH2D, TCanvas, gRandom
```

Define the 2D histograms to display the correlation between random numbers

```python
histo1 = TH2D("congruental random numbers","congruental random numbers ",100, 0, 1, 100, 0, 1)
histo2 = TH2D("RANLUX","RANLUX",100, 0, 1, 100, 0, 1)
```

Define our first congruent generator

```python
def randCon():
    im = 139968
    randCon.r = (205*randCon.r+29573) % im #get next random number
    return float(randCon.r) / im #return normalized one
randCon.r = 4771 #Starting value (seed)
```

Number of points to be generated

```python
npoints = 100000
```

Generate npoint pairs of random numbers

```python
for n in range(npoints):
    #Generate 2 random numbers with our generator
    xC = randCon()
    yC = randCon()
    histo1.Fill(xC, yC)

    #Generate 2 random numbers with our RANLUX
    xRL = gRandom.Uniform()
    yRL = gRandom.Uniform()
    histo2.Fill(xRL, yRL)
```

Plotting the results

```python
c = TCanvas()
histo1.Draw()
c.Draw()
```

```python
histo2.Draw()
c.Draw()
```
