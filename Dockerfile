#Official ROOT Docker image
FROM rootproject/root-ubuntu16

# Run the following commands as super user (root):
USER root

#Instal LHAPDF
WORKDIR /
COPY installLHA.sh .
RUN ./installLHA.sh
ENV PATH="/lhapdf/install/bin/:${PATH}"

ENV PYTHONPATH="/lhapdf/install/lib/python2.7/site-packages/:${PYTHONPATH}"
ENV LD_LIBRARY_PATH="/lhapdf/install/lib/:${LD_LIBRARY_PATH}"

ENV PYTHONPATH="/usr/local/lib/root:${PYTHONPATH}"
RUN  apt-get update &&  apt-get install -y python-pip
COPY requirements.txt .
RUN  sudo -H pip install --upgrade pip && sudo -H pip install --trusted-host pypi.python.org -r requirements.txt

ENV HOME=/tmp
WORKDIR ${HOME}
RUN rm -f /tmp/* && mkdir -p ${HOME}/exerciseNb  -p ${HOME}/exerciseNbDone
COPY Makefile   ${HOME}/
COPY exerciseMd ${HOME}/exerciseMd
RUN  make allRun  && rm -f Makefile

# When starting the container and no command is started, run bash
#CMD ["/bin/bash"]
CMD ["jupyter", "notebook", "--allow-root", "--ip", "0.0.0.0"]
