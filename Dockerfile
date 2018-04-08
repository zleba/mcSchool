#Official ROOT Docker image
FROM rootproject/root-ubuntu16

# Run the following commands as super user (root):
USER root

#Instal LHAPDF
WORKDIR /
COPY installLHA.sh .
RUN ./installLHA.sh
ENV PATH="/lhapdf/install/bin/:${PATH}"

# When starting the container and no command is started, run bash
CMD ["/bin/bash"]
