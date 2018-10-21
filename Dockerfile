#Official ROOT Docker image
FROM rootproject/root-ubuntu16

# Run the following commands as super user (root):
USER root

#Instal LHAPDF
WORKDIR /
#COPY installLHA.sh .
#RUN ./installLHA.sh
#ENV PATH="/lhapdf/install/bin/:${PATH}"
ENV PYTHONPATH="/usr/local/lib/root:${PYTHONPATH}"
RUN  apt-get update &&  apt-get install -y python-pip
COPY requirements.txt .
RUN  sudo -H pip install --upgrade pip && sudo -H pip install --trusted-host pypi.python.org -r requirements.txt

ENV HOME=/tmp
WORKDIR ${HOME}
RUN rm -f /tmp/*
COPY exercisePy/*.md  exercisePy/Makefile ${HOME}/
RUN  make all && rm -f Makefile *.md

# When starting the container and no command is started, run bash
#CMD ["/bin/bash"]
CMD ["jupyter", "notebook", "--allow-root", "--ip", "0.0.0.0"]
