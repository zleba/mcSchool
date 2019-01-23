#Official ROOT Docker image
FROM rootproject/root-ubuntu16

# Run the following commands as super user (root):
USER root
RUN  apt-get update &&  apt-get install -y python-pip vim wget && rm -rf /var/lib/apt/lists/*

#Instal LHAPDF
WORKDIR /
COPY installLHA.sh .
RUN ./installLHA.sh
ENV PATH="/lhapdf/install/bin/:${PATH}"

ENV PYTHONPATH="/lhapdf/install/lib/python2.7/site-packages/:${PYTHONPATH}"
ENV LD_LIBRARY_PATH="/lhapdf/install/lib/:${LD_LIBRARY_PATH}"

ENV PYTHONPATH="/usr/local/lib/root:${PYTHONPATH}"
COPY requirements.txt .
RUN  sudo -H pip install --upgrade pip && sudo -H pip install --trusted-host pypi.python.org -r requirements.txt

CMD ["bash"]
