# mcSchool

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

Standardly compile using make
```
cd exercise1
make
./example-1
```

In case that ROOT and/or LHAPDF is not in your machine, you can use Docker image which contains everything required:
```
cd exercise1
./runDocker make
./runDocker ./example-1
```
