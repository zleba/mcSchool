# mcSchool
[![Build Status](https://travis-ci.org/zleba/mcSchool.svg?branch=master)](https://travis-ci.org/zleba/mcSchool)
## Online running with Jupyter

You can explore the Jupyter notebooks using nbViewer or run them on the online cluster Mybinder.
Check and run the Jupyter notebooks here: [nbViewer](https://nbviewer.jupyter.org/github/zleba/mcSchool/tree/master/exerciseNb) [myBinder](https://mybinder.org/v2/gh/zleba/mcSchool/master?filepath=exerciseNb)  
Or the executed version: [nbViewer](https://nbviewer.jupyter.org/github/zleba/mcSchool/tree/master/exerciseNbExec) [myBinder](https://mybinder.org/v2/gh/zleba/mcSchool/master?filepath=exerciseNbExec)

You can try to run in the new experimental Jupyter Lab environment
[jupyterLab](https://mybinder.org/v2/gh/zleba/mcSchool/master?urlpath=lab)

## Offline running with Jupyter
In case that Docker is installed on you computer the only thing is to run the command in file `runNotebook` or for the new Lab environment `runLab`.

If you want to have better control over the files, first download the git repository, by

Use
```
git clone git@github.com:zleba/mcSchool.git
```

or download the archive.
```
wget https://github.com/zleba/mcSchool/archive/master.zip
unzip master.zip
```

Then run script `./runNotebook` or `./runLab`, the environment will be ready in the browser under `localhost` address.
The `temp` directory is link to the local machine so one can edit and run the local files in the browser.

## Offline running of the Python programs

Clone the git repository as above and run any command through docker, like:

```
cd exercisePy
./rd python -i exercise-1.py
```
The `-i` is for interactive mode, which can be useful if some plots needs to be shown.

## Offline running of the C++ programs

The c++ programs are longer and need to be compiled but run faster.

Standardly compile using make and run afterwards in the docker environment `rd`
```
cd exerciseCpp
./rd make
./rd ./example-1
```

For the local running you may need to install docker on your computer (in case of Ubuntu):

```
sudo apt install docker.io
```


## Offline running of the programs without docker on system with access to CVMFS file system

In this case you can use ROOT and LHAPDF libraries installed by CERN on CVMFS.
Just call
```
source setupCVMFS.sh
```
to setup the enviroment and then simple run Python or C++ programs as above, but without `./rd` in front.

## Offline running without access to CVMFS

Without the Docker image  and access to CVMFS the ROOT and LHAPDF needs to be installed which can take take some time.

Good luck.
