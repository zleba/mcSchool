# MC integration
Define function which we want to integrate

```python
from ROOT import gRandom
from math import sqrt
```

```python
def g0(z):
    return 3*z*z; 
```

Calculate the sum and sum2 of the function values at the random points

```python
s = s2 = 0
npoints = 1000000
for n in range(npoints):
    x0 = gRandom.Uniform()
    f  = g0(x0) 
    s += f
    s2+= f**2
```

Calculate average and average to the squared values

```python
avg  = s  / npoints
avg2 = s2 / npoints
```

Get the average deviation squared

```python
sigma2 = avg2 - avg*avg
```

The actuall error behaves as 1/sqrt(npoints)

```python
error = sqrt(sigma2/npoints) ;
```

Finally the result

```python
print " integral for 3x**2 is: ", avg, "+/-", error
print " true integral for 3x**2 is : 1.0 "
```
