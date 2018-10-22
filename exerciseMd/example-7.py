from math import pi, sin, cos, sqrt, log, exp
from ROOT import gRandom, TCanvas, TH1D, TLorentzVector

def gauss2D(sigma):
    kT  = sigma * sqrt(-2*log(gRandom.Uniform()));
    phi = 2*pi * gRandom.Uniform()
    kx, ky = kT*cos(phi), kT*sin(phi)
    return (kx, ky)


Eb = 3500 # Beam energy
def getpdf(q2):
    xmin = 0.00001
    xmax = 0.999
    x = xmin*pow(xmax/xmin, gRandom.Uniform())
    weightx =  x*log(xmax/xmin) 
    # this is for the simple case            
    pdf = 3.*pow((1-x),5)/x

    weight = weightx * pdf
    kx, ky = gauss2D(0.7)
    pVec = TLorentzVector()
    pVec.SetXYZM(kx, ky, x*Eb, 0.)
    return pVec, weight


def sudakov(t0):
#   here we calculate  from the sudakov form factor the next t > t0
    epsilon = 0.1
    as2pi = 0.1/2./pi
    Ca = 3.
# for Pgg use fact = 2*Ca
    fac=2.*Ca 
    # use fixed alphas and only the 1/(1-z) term of the splitting fct

    r1 = gRandom.Uniform()
    Pint=log((1.-epsilon)/epsilon) # for 1/(1-z) splitting fct 
    t2 = -log(r1)/fac/as2pi/Pint
    t2 = t0 * exp(t2)
    t = t2   
    assert(t2 < t0)
    return t

def splitting():
    epsilon = 0.1

    #error ~ C / sqrt(Nevents)
    #z = epsilon + (1 - 2*epsilon) *Rand()
    #weightz = as2pi* 6 (1./z + 1./(1.-z))
    #return

    as2pi = 0.1/2./pi

#		here we calculate  the splitting variable z for 1/z and  1/(1-z)
#		use Pgg=6./z 
# + 6./(1.-z))  // z -> 1-z

    g0 = 6.*as2pi * log((1.-epsilon)/epsilon)
    g1 = 6.*as2pi * log((1.-epsilon)/epsilon)
    gtot = g0 + g1 

    zmin = epsilon
    zmax = 1.-epsilon

    r1 = gRandom.Uniform()
    r2 = gRandom.Uniform()

    z = zmin*pow((zmax/zmin),r2)
    if (r1 > g0/gtot):
        z = 1. - z
    weightz = 1.
    return z


def evolve_pdf(q20, q2, p0):
    x = p0.Pz()/Eb
    kx = p0.Px()
    ky = p0.Py()
    weightx = 1.
    t1 = q20
    tcut = q2
    while t1 < tcut:
        # here we do now the evolution
        # first we generate t
        t0 = t1
        t1 = sudakov(t0) 
        # now we generate z
        z = splitting()
        #   since the sudakov involves only the 1/(1-z) part 
        #   of the splitting fct, we need to weight each branching
        #   by the ratio of the intgral of the full and 
        #   approximate splitting fct

        ratio_splitting = 2 # for using Pgg

        if  t1 < tcut:
            x = x*z
            weightx = weightx *ratio_splitting
            # 
            # use here the angular ordering condition: sqrt(t1) = qt/(1-z) 
            # and apply this also to the propagator gluons
            #
            phi = 2*pi*gRandom.Uniform()
            kx +=  sqrt(t1)*cos(phi)*(1.-z)
            ky +=  sqrt(t1)*sin(phi)*(1.-z)                     
            #   kx += sqrt(t1)*cos(phi)
            #   ky += sqrt(t1)*sin(phi)                     
    p1 = TLorentzVector()
    p1.SetXYZM(kx, ky, x*Eb, 0.)
    return p1, weightx


npoints = 100000
q20 = 1
q2  = 100**2

# book histograms: TH1D("label","title",nr of bins, xlow,xhigh )
histo1  =  TH1D("x0","x0",100, -5, 0.)
histo2  =  TH1D("kt0 ","kt0 ",100, 0, 10.)
histo3  =  TH1D("x","x",100, -5, 0.)
histo4  =  TH1D("kt ","kt ",1000, 0, 1000.)


for n1 in range(npoints):
	# generate starting distribution in x and kt
	p0, weightx0 = getpdf(q20)
	# now do the evolution	
	p, weightx = evolve_pdf(q20, q2, p0)   
	weight = weightx0 * weightx         

	if x < 1:
		# weighting with 1/x0:
		# plot dxg(x)/dlogx *Jacobian, Jacobian dlogx/dx = 1/x
		# log(x) = 2.3026 log10(x)
		kt0 = p0.Pt()
		kt  = p.Pt()
		x   = p.Pz()/Eb
		x0  = p0.Pz()/Eb

		histo1.Fill(log10(x0), weightx0/log(10))
		histo2.Fill(kt0,weightx0)
		histo3.Fill(log10(x),  weight/log(10))
		histo4.Fill(kt, weight)


gStyle.SetOptStat(0) # get rid of statistics box
c = TCanvas();
# divide the canvas in 2 parts in x and 2 in y
c.Divide(2,2);
c.cd(1);
histo1.Scale(1./npoints, "width");
# gPad.SetLogy();
histo1.Draw("hist e");

c.cd(2);
histo3.Scale(1./npoints, "width");
histo3.Draw("hist e");


c.cd(3);
histo2.Scale(1./npoints, "width");
gPad.SetLogy();
histo2.Draw("hist e");


c.cd(4);
histo4.Scale(1./npoints, "width");
gPad.SetLogy();
histo4.Draw("hist e");

c.Draw();
