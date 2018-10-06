FROM nvidia/opengl:1.0-glvnd-devel

ARG ROBOVIZ_RELEASE=1.4.0

RUN buildDeps='rsync openjdk-8-jdk git'; \
    apt-get update \
    && apt-get install -y --no-install-recommends openjdk-8-jre \
    && apt-get install -y --no-install-recommends $buildDeps \
    && git clone --branch $ROBOVIZ_RELEASE --depth 1 https://github.com/magmaOffenburg/RoboViz.git /tmp/RoboViz \
    && /tmp/RoboViz/scripts/build-linux64.sh \
    && mv /tmp/RoboViz/bin/linux-amd64/ /roboviz \
    && rm -r /tmp/RoboViz \
    && apt-get purge -y --auto-remove $buildDeps && rm -rf /var/lib/apt/lists/*
    
ENTRYPOINT ["/roboviz/roboviz.sh"]
