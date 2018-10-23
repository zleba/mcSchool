# Calculation of the DY cross section
First import from ROOT libraries which  are needed

```python
from  ROOT import TH1D, TCanvas, gRandom
from  math import log, sqrt, pi
import  lhapdf
```

Define the cross section formula for DY q + qb -> mu+ mu-, without  the charge of the quark, according to formula (48.3) in [pdgReview](http://pdg.lbl.gov/2014/reviews/rpp2014-rev-cross-section-formulae.pdf), notice different color factor due to the inverted process

```python
def sigma(shat):
    Nc = 3 #number of colors 
    aem = 1./137 #alphaEM
    ge2mb = 0.389379 #from natural units to mb
    return 1./Nc * 4*pi*aem**2/(3*shat) *ge2mb
```

Define PDF to be used

```python
name = "MRST2007lomod"	
pdf = lhapdf.getPDFSet(name).mkPDF(0)
```


Define histograms to be filed

```python
hEta  = TH1D("eta", "Eta", 20, -12, 12)
hMass = TH1D("mass", "Mass", 20, 40, 60)
```

Define the beam eneryg of the protons

```python
Eb = 6500
xmin = 1e-5
xmax = pdf.xMax
```

Define the number of points to be generated

```python
npoints = 1000000
```

Generate npoint pairs of random numbers with congruent generator and fill it to 2D histogram

```python
s1 = s2 = 0
for n in range(npoints):
    #Importance sampling in x1 and x2
    x1 = xmin * (xmax/xmin)**gRandom.Uniform()
    x2 = xmin * (xmax/xmin)**gRandom.Uniform()
    wgt = log(xmax/xmin)**2 * x1 * x2
    
    #mass and eta of DY
    m   = 2*Eb*sqrt(x1*x2) 
    eta = 1./2*log(x1/x2)
    #Accepted mass range
    if m < 40 or m > 60:
        continue

    #to simplify calculation
    def q1(id):
        return pdf.xfxQ(id, x1, m) / x1
    def q2(id):
        return pdf.xfxQ(id, x2, m) / x2

    # u*ub + c*cb
    UPqqb = q1(2)*q2(-2) + q1(4)*q2(-4)
    # d*db + s*sb + b*bb 
    DNqqb = q1(1)*q2(-1) + q1(3)*q2(-3) + q1(5)*q2(-5)
    # for 1 <-> 2
    UPqbq = q1(-2)*q2(2) + q1(-4)*q2(4)
    DNqbq = q1(-1)*q2(1) + q1(-3)*q2(3) + q1(-5)*q2(5)

    #apply charges of quarks
    res = ( (2./3)**2 * (UPqqb + UPqbq) + (1./3)**2 * (DNqqb + DNqbq) ) * sigma(m*m)
    f = res * wgt

    #fill histograms
    hEta.Fill(eta, f)
    hMass.Fill(m,  f)
    s1 += f
    s2 += f**2
```

Divide by npoints

```python
avg  = s1/npoints
avg2 = s2/npoints
```

Calculate the error

```python
sigma2 = avg2 - avg**2
err = sqrt(sigma2/npoints)
```

Print the x-section

```python
print 'Cross section for pp -> mu+mu- is ', avg, '+-', err, 'mb'
```

Plot histograms

```python
c = TCanvas()
hEta.Scale(1./npoints, "width")
hEta.Draw()
c.Draw()
d = TCanvas()
hMass.Scale(1./npoints, "width")
hMass.Draw()
d.Draw()
```
