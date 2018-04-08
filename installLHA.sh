#/bin/sh
mkdir lhapdf
cd lhapdf
pwd=$PWD
mkdir install

lha=LHAPDF-6.2.1
curl -L http://www.hepforge.org/archive/lhapdf/$lha.tar.gz  | tar zx
#wget -O- http://www.hepforge.org/archive/lhapdf/$lha.tar.gz | tar zx
cd $lha

./configure --prefix=$pwd/install
make
make install

#Download few PDFs
for pdf in MRSTMCal MRST2007lomod MRST2004qed_proton
do
    curl -L http://www.hepforge.org/archive/lhapdf/pdfsets/6.2/$pdf.tar.gz  | tar xz -C $pwd/install/share/LHAPDF
done
