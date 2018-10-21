```
from ROOT import TH1D, gRandom, TCanvas
from math import sqrt
#TH1::SetDefaultSumw2()
npoints = 10000

#Init histograms for given number of points in sum
pointsA = [1, 2, 3, 6, 12, 20, 40]
histos = {}
for p in pointsA:
    histos[p] = TH1D(str(p), str(p), 100, -6, 6);


for n in range(npoints):
    for p in pointsA:
        x = 0.
        for n2 in range(p):
            x += gRandom.Uniform()
        histos[p].Fill((x - p/2.)/sqrt(p/12.));


for p in pointsA:
    c = TCanvas(str(p));
    histos[p].SetLineColor(p+1);
    histos[p].DrawCopy("hist e");
    c.Draw()
#
#//Plot normalized into single Graph
#TCanvas *d = new TCanvas("dtest", "" , 0, 0, 1000, 500);
#for(unsigned iH = 0; iH < points.size(); ++iH) {
#    histos[iH]->Scale(1./histos[iH]->Integral());
#    histos[iH]->Draw(iH == 0 ? "hist e": "hist e same");
#}
#histos[0]->SetMaximum(0.05);
#d->BuildLegend();
#
#d->Print("example2.pdf)");
#
#
#// write histogramm out to file
#TFile file("output-example2.root","RECREATE");
#for(unsigned iH = 0; iH < points.size(); ++iH)
#    histos[iH]->Write();
#
```
