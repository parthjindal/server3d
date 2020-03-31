FROM ubuntu:18.04
LABEL maintaner="robocup3d@163.com"
EXPOSE 3100/tcp
EXPOSE 3200/tcp

# domestic apt source
ADD sources.list /etc/apt/
ARG buildDeps='libfreetype6 libode6 libsdl1.2debian ruby libdevil1c2 qt4-default libboost-regex1.65.1 libboost-system1.65.1 libboost-thread1.65.1 libfreetype6-dev libode-dev libsdl-dev ruby-dev libdevil-dev libboost-dev libboost-thread-dev libboost-regex-dev libboost-system-dev libqt4-opengl-dev psmisc'
ENV DEBIAN_FRONTEND noninteractive
ARG RCSSSERVER3D_RELEASE=0.7.2

# apt install deps
RUN apt-get update && apt-get install -y --no-install-recommends ${buildDeps} \
    python3 python3-pip build-essential cmake git ssh iproute2

ADD SimSpark /tmp/SimSpark
ADD ut3d     /ut3d

# install robocup3d env
RUN cd /tmp/SimSpark && git checkout -b RCSSSERVER3D_${RCSSSERVER3D_RELEASE}_RELEASE \
    && mkdir -p /tmp/SimSpark/spark/build && cd /tmp/SimSpark/spark/build && cmake -DRVDRAW=ON .. && make -j$(nproc) \
    && make install && ldconfig && mkdir -p /tmp/SimSpark/rcssserver3d/build && cd /tmp/SimSpark/rcssserver3d/build \
    && cmake -DRVDRAW=ON .. && make -j$(nproc) && make install && ldconfig && rm -fr /tmp/SimSpark 

# test compile comaptibility
RUN cd /ut3d && git checkout walk-optim && cmake . && make -j$(nproc)
# install python, pip, 3rd module
RUN mkdir /root/.pip && echo '[global]\nindex-url = https://pypi.tuna.tsinghua.edu.cn/simple' > /root/.pip/pip.conf \
    && python3 -m pip install requests 

# clean packages 
RUN apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*
ENV LD_LIBRARY_PATH=/usr/local/lib/simspark:/usr/local/lib/rcssserver3d

# first run to generate ~/.simspark
# docker run -e TASK_BRANCH="walk-optim" -e MASTER_HOST="robocup3d.cn:65000"
ENTRYPOINT if [ ! -e ~/.simspark ]; then timeout -s 9 1 rcssserver3d || echo 'first run rcssserver3d'; fi \
    && cd /ut3d && git pull && git checkout ${TASK_BRANCH} && make -j$(nproc) && cd optimization \
    && bash prebuild.sh && bash run.sh \
    || echo 'ERROR occured!Turn into shell to debug!' && bash
