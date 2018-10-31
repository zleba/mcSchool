#Docker with system environment, based on rootproject/root-ubuntu16
FROM  zleba/rootlhapdf:system  

ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password --gecos "Default user" \
            --uid ${NB_UID} ${NB_USER}

WORKDIR ${HOME}
USER ${NB_USER}
RUN  mkdir .jupyter && echo "c.NotebookApp.token = ''" > ${HOME}/.jupyter/jupyter_notebook_config.py
RUN  mkdir -p ${HOME}/exerciseNb  -p ${HOME}/exerciseNbExec  ${HOME}/exercisePy  ${HOME}/temp
COPY --chown=jovyan exerciseNb ${HOME}/exerciseNb
COPY --chown=jovyan exerciseNbExec ${HOME}/exerciseNbExec
COPY --chown=jovyan exercisePy ${HOME}/exercisePy
EXPOSE 8888

# When starting the container and no command is started, run bash
CMD ["jupyter", "notebook",  "--ip", "0.0.0.0"]
