FROM ubuntu:18.04

ARG ROBOVIZ_RELEASE=1.7.0
ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Asia/Kolkata

RUN buildDeps='rsync openjdk-8-jdk git wget'; \
    apt-get update \
    && apt-get install -y --no-install-recommends openjdk-8-jre mesa-utils xserver-xorg-video-all\
    && apt-get install -y --no-install-recommends $buildDeps \
    && wget https://github.com/magmaOffenburg/RoboViz/releases/download/${ROBOVIZ_RELEASE}/RoboViz.tar.gz -P /tmp/RoboViz \
    && tar -xf /tmp/RoboViz/RoboViz.tar.gz -C /tmp/RoboViz/ \
    && mv /tmp/RoboViz/bin/ /roboviz/ \
    && rm -r /tmp/RoboViz \
    && apt-get purge -y --auto-remove $buildDeps && rm -rf /var/lib/apt/lists/*
    
ENTRYPOINT ["/roboviz/roboviz.sh"]
