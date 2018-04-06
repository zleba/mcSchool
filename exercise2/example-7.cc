#include "ranlxd.h"
#include <cmath>
#include "TH1.h"
#include "TFile.h" 
#include "TCanvas.h"
#include <TApplication.h>
#include <TStyle.h>
#include <TROOT.h>
#include <iostream>

using namespace std;

/*
   Parton evolution:
     1. generate starting distribution in x and add intrisnic transverse mom.
     2. evolve sarting distribution to large values of t

   Plot starting distribution and intrinsic kt
   Plot evolved distribution as function of x and kt

   The random number generator is RANLUX by M. Luescher.
   M. Lüscher, A portable high-quality random number generator 
   for lattice field theory simulations, 
   Computer Physics Communications 79 (1994) 100  
   http://luscher.web.cern.ch/luscher/ranlux/index.html      

*/


double gauss ( double mean, double sigma )
{	
    const int npoints = 12;

    double rvec[npoints];
    ranlxd(rvec, npoints);

    double r = 0;
    for (int n1 = 0; n1 < npoints; n1++ )
        r += rvec[n1];

    double result = mean + sigma * (r - 6.);
    return abs(result); //why abs?
}

void get_starting_pdf(double xmin, double q2, double& weightx, double& x, double& kx, double& ky, double& kt2)
{
    const double xmax = 1;
    double pdf;
    double phi;

    double rvec[2];
    ranlxd(rvec,2);

    // get x value according to g(x)\sim 1/x            
    x = xmin*pow(xmax/xmin,rvec[0]);
    // use: xg(x) = 3 (1-x)**5

    pdf     = pow(1-x, 5) * 3./x;
    weightx = x*log(xmax/xmin) * pdf ;

    // now generate instrinsic kt according to a gauss distribution  
    kt2 = gauss(0,0.7);
    phi = 2. * M_PI * rvec[1];            
    kx = sqrt(kt2)*cos(phi);
    ky = sqrt(kt2)*sin(phi);
    // cout << "in getpdf:  x " << x << " kx " << kx <<" ky " << ky <<endl; 
}

void sudakov(double t0, double& t)
{
//  here we calculate  from the sudakov form factor the next t > t0
    double epsilon = 0.1;
    double as2pi = 0.1/2./M_PI,Ca=3.;
    double Pint;
// for Pgg use fact = 2*Ca

    double fac=2.*Ca; 
    double r1,t2;
    double rvec[1];
    ranlxd(rvec,1);
    // use fixed alphas and only the 1/(1-z) term of the splitting fct
    r1 = rvec[0];
    Pint=log((1.-epsilon)/epsilon); /* for 1/(1-z) splitting fct */
    t2 = -log(r1)/fac/as2pi/Pint;
    t2 = t0 * exp(t2);
    t = t2;   
    // cout << " t0= "<<t0<< " t= "<<t2<< " epsilon= "<<epsilon <<endl;
    if (t2 < t0) {        
        cout << "FATAL t0 > t:  t0= "<<t0<< "t= "<<t2<< "epsilon= "<<epsilon <<endl;
    }
}

void splitting(double& z, double& weightz)
{
    const double epsilon = 0.1;

    double as2pi = 0.1/2./M_PI;

    double rvec[2];
    ranlxd(rvec,2);
//		here we calculate  the splitting variable z for 1/z and  1/(1-z)
//		use Pgg=6 (1./z + 1./(1.-z))

    double g0 = 6.*as2pi * log((1.-epsilon)/epsilon);
    double g1 = 6.*as2pi * log((1.-epsilon)/epsilon);
    double gtot = g0 + g1 ;

    double zmin = epsilon;
    double zmax = 1.-epsilon;

    double r1 = rvec[0];
    double r2 = rvec[1];

    z = zmin*pow((zmax/zmin),r2);
    if (r1 > g0/gtot)
        z = 1. - z;
//
    weightz = 1.;		
}

void evolve_pdf(double xmin, double q2, double x0, double kx0, double ky0, double kt20,  double& weightx, double& x, double& kx, double& ky, double& kt2)
{
    double t0=1.,t1, tcut,phi;
    double z=0, weightz;
    double ratio_splitting;
    double rvec[2];
    x = x0;
    kx = kx0;
    ky = ky0;
    kt2 = kt20;
    weightx = 1. ;
    t1 = t0 ;
    tcut = q2;
    while (t1 < tcut ) {
        ranlxd(rvec,2);
        // here we do now the evolution
        // first we generate t
        t0 = t1;
        sudakov(t0, t1) ;
        // now we generate z
        splitting(z, weightz);
                  /* 
                    since the sudakov involves only the 1/(1-z) part 
                    of the splitting fct, we need to weight each branching
                    by the ratio of the intgral of the full and 
                    approximate splitting fct
                  */
			ratio_splitting= 2; /* for using Pgg*/

                  if ( t1 < tcut ) { 
                     x = x*z;
                     weightx = weightx *weightz*ratio_splitting;
      	         phi = 2*M_PI*rvec[0];  
                     /* 
                     use here the angular ordering condition: sqrt(t1) = qt/(1-z) 
                     and apply this also to the propagator gluons
                     */
                     kx = kx + sqrt(t1)*cos(phi)*(1.-z);
                     ky = ky + sqrt(t1)*sin(phi)*(1.-z);                     
//                     kx = kx + sqrt(t1)*cos(phi);
//                     ky = ky + sqrt(t1)*sin(phi);                     
                     kt2 = kx*kx + ky*ky ;
                     }
            }
// cout << " evolve end  t= "<< t<< " q2 " <<q2 << " x0 = " <<x0 << "x =" << x <<endl;
}



int main(int argc,char **argv)
{
    TApplication* gMyRootApp = new TApplication("My ROOT Application", &argc, argv);
    const int npoints = 1e7;


    double xmin = 0.00001, q2=100*100;
    double x , kx, ky, kt2, weightx ;
    double x0, kx0, ky0, kt20, weightx0 ;

    double a,b, binwidth1,binwidth2;

    // initialise random number generator: rlxd_init( luxory level, seed )
    rlxd_init(2,32767);

    // book histograms: TH1D("label","title",nr of bins, xlow,xhigh )
    TH1D *histo1  = new TH1D("x0","x0",100, -5, 0.);
    TH1D *histo10 = new TH1D(*histo1); 
    binwidth1=5./100.;
    TH1D *histo2  = new TH1D("kt0 ","kt0 ",100, 0, 10.);
    TH1D *histo20 = new TH1D(*histo2); 
    binwidth2=1000./1000;
    TH1D *histo3  = new TH1D("x","x",100, -5, 0.);
    TH1D *histo30 = new TH1D(*histo3); 
    TH1D *histo4  = new TH1D("kt ","kt ",1000, 0, 1000.);
    TH1D *histo40 = new TH1D(*histo4); 


    for (int n1 = 0; n1 < npoints; n1++ ) {

        // generate starting distribution in x and kt
        get_starting_pdf(xmin, q2, weightx0, x0, kx0, ky0, kt20);
        // now do the evolution	
        evolve_pdf(xmin, q2, x0, kx0, ky0, kt20, weightx, x, kx, ky, kt2);   
        weightx = weightx0 * weightx;         
        if (x < 1) {
            // weighting with 1/x0:
            // plot dxg(x)/dlogx *Jacobian, Jacobian dlogx/dx = 1/x
            // log(x) = 2.3026 log10(x)
            histo1->Fill(log10(x0), weightx0/2.3026);
            histo2->Fill(sqrt(kt20),weightx0);
            histo3->Fill(log10(x),  weightx/2.3026);
            histo4->Fill(sqrt(kt2), weightx);
        }
    }          
//                                  

    // write histogramm out to file
    TFile file("output-example-7.root","RECREATE");
    // general root settings 
    gROOT->Reset();
    gROOT->SetStyle("Plain");
    gStyle->SetPadTickY(1); // ticks at right side
    gStyle->SetOptStat(0); // get rid of statistics box
    TCanvas *c = new TCanvas("ctest", "" ,0, 0, 500, 500);
    // divide the canvas in 1 parts in x and 1 in y
    c -> Divide(2,2);
    a=1./npoints/binwidth1; 
    b=0; 

    c->cd(1);
    histo10->Add(histo1,histo1,a,b); 
    // histo1->Write();
    histo10->Write();
    // gPad->SetLogy();
    histo10->Draw();

    c->cd(2);
    a=1./npoints/binwidth1; 
    histo30->Add(histo3,histo3,a,b); 
    histo30->Write();
    histo30->Draw();


    c->cd(3);
    a=1./npoints/binwidth2; 
    histo20->Add(histo2,histo2,a,b); 
    histo20->Write();
    gPad->SetLogy();
    histo20->Draw();


    c->cd(4);
    a=1./npoints/binwidth1; 
    histo40->Add(histo4,histo4,a,b); 
    histo40->Write();
    gPad->SetLogy();
    histo40 -> Draw();

    c-> Draw();
    c->WaitPrimitive();
    c-> Print("example7.pdf");
    gMyRootApp->SetReturnFromRun(true);
    file.Close();
    return EXIT_SUCCESS;
}
