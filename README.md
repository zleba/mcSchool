# mcSchool
[![Build Status](https://travis-ci.org/zleba/mcSchool.svg?branch=master)](https://travis-ci.org/zleba/mcSchool)
## Online running with Jupyter

You can explore the Jupyter notebooks using nbViewer or run them on the online cluster Mybinder.
Check and run the Jupyter notebooks here: [nbViewer](https://nbviewer.jupyter.org/github/zleba/mcSchool/tree/master/exerciseNb) [myBinder](https://mybinder.org/v2/gh/zleba/mcSchool/master?filepath=exerciseNb)  
Or the executed version: [nbViewer](https://nbviewer.jupyter.org/github/zleba/mcSchool/tree/master/exerciseNbExec) [myBinder](https://mybinder.org/v2/gh/zleba/mcSchool/master?filepath=exerciseNbExec)

You can try to run in the new experimental Jupyter Lab enviroment
[jupyterLab](https://mybinder.org/v2/gh/zleba/mcSchool/master?urlpath=lab)

## Offline running with Jupyter
For the simplest off-line run docker is installed on your system the only thing is to run the command in file `runNotebook` or for the new Lab environment `runLab`.

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

Standardly compile using make and run afterwards in the docker enviroment `rd`
```
cd exerciseCpp
./rd make
./rd ./example-1
```

For the local running you may need to install docker on your computer (in case of Ubuntu):

```
sudo apt install docker.io
```


## Offline running of the programs without docker

Without the docker image the ROOT and LHAPDF needs to be installed.
Which can take take some time.

Good luck.
