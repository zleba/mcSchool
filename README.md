# mcSchool
[![Build Status](https://travis-ci.org/zleba/mcSchool.svg?branch=master)](https://travis-ci.org/zleba/mcSchool)

Check the jupyter version of the excercise  
Check and run the Jupyter notebooks here: [nbViewer](https://nbviewer.jupyter.org/github/zleba/mcSchool/tree/master/exerciseNb) [myBinder](https://hub.mybinder.org/user/zleba-mcschool-4mdvkssa/tree/exerciseNb)  
Or the executed version: [nbViewer](https://nbviewer.jupyter.org/github/zleba/mcSchool/tree/master/exerciseNbExec) [myBinder](https://hub.mybinder.org/user/zleba-mcschool-4mdvkssa/tree/exerciseNbExec)

Use
```
git clone git@github.com:zleba/mcSchool.git
```

or download the archive.
```
wget https://github.com/zleba/mcSchool/archive/master.zip
unzip master.zip
```
Requires ROOT and in one case LHAPDF.

Standardly compile using make and run afterwards
```
cd exercise1
make
./example-1
```

In case that ROOT and/or LHAPDF is not in your machine, you can use Docker image which contains everything required:
```
cd exercise1
./rd make
./rd ./example-1
```
You may need to install docker on your computer (in case of Ubuntu):

```
sudo apt install docker.io
```
Good luck.
