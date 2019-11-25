FROM tepickering/iraf-base:latest

MAINTAINER T. E. Pickering "te.pickering@gmail.com"

ARG USER_ID
ARG GROUP_ID
ARG WD
RUN groupadd -f -g ${GROUP_ID} bigobs && \
    useradd -l -u ${USER_ID} -g bigobs bigobs

RUN mkdir -p /home/bigobs && chown -R bigobs:bigobs /home/bigobs

ADD --chown=bigobs:bigobs ./watcher/watcher/ /home/bigobs/watcher/
ADD --chown=bigobs:bigobs ./watcher/betsy/ /home/bigobs/betsy/
ADD --chown=bigobs:bigobs ./dataclient.py /home/bigobs/dataclient.py


USER bigobs
ENV HOME /home/bigobs

RUN /bin/bash -c "/miniconda2/bin/conda init bash"
RUN /bin/bash -c 'cd /home/bigobs && source .bashrc && conda activate iraf27 && printf "xgterm\n" | mkiraf'
