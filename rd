#/bin/sh
image=zleba/rootlhapdf  #rootproject/root-ubuntu16

if [ ! -z "$DISPLAY" ]
then
    sudo docker run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $PWD:/excercise --rm -it --user $(id -u) $image /bin/bash -c "cd /excercise/; $*"
else
    sudo docker run  -v $PWD:/excercise --rm -it --user $(id -u) $image /bin/bash -c "cd /excercise/; $*"
fi
