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

ENV NB_USER=jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password --gecos "Default user" \
            --uid ${NB_UID} ${NB_USER}

WORKDIR ${HOME}
USER ${NB_USER}
RUN mkdir .jupyter && echo "c.NotebookApp.token = ''" > ${HOME}/.jupyter/jupyter_notebook_config.py
RUN  mkdir -p ${HOME}/exerciseNb  -p ${HOME}/exerciseNbExec
COPY exerciseNb ${HOME}/exerciseNb
COPY exerciseNbExec ${HOME}/exerciseNbExec
#EXPOSE 8888

# When starting the container and no command is started, run bash
#CMD ["/bin/bash"]
CMD ["jupyter", "notebook",  "--ip", "0.0.0.0"]
