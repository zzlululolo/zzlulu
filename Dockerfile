FROM ubuntu:14.04

USER root

# install ubuntu packages
RUN apt-get update \
    && apt-get install -y build-essential \
        libkrb5-dev \
        curl \
        python \
    && apt-get clean

# set node version
ENV NODE_VERSION 0.12.7

# download node.js
RUN mkdir -p /opt/tools
RUN cd \
    && curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
    && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /opt/tools/ \
    && rm "node-v$NODE_VERSION-linux-x64.tar.gz" \
    && ln -s /opt/tools/node-v$NODE_VERSION-linux-x64 /opt/tools/nodejs

# set path for node realated commands
ENV PATH $PATH:/opt/tools/nodejs/bin

# set up cnpm
# RUN npm install cnpm -g --registry=https://registry.npm.taobao.org

# install strongloop globally, use npm for non-China deployment
# RUN cnpm install -g strongloop
RUN npm install -g strongloop

# set up project
RUN mkdir -p /opt/tools/sysbb/log
WORKDIR /opt/tools/sysbb
ADD . /opt/tools/sysbb

# install dependencies and fix bug, use npm for non-China deployment
# RUN cd /opt/tools/sysbb && cnpm install && ./sysbb fixbug
RUN cd /opt/tools/sysbb && npm install

EXPOSE 3000

CMD ["/opt/tools/sysbb/sysbb", "start"]
