FROM ubuntu:18.04

WORKDIR /app/src

ADD docker /app/docker
ADD src /app/src
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && cp /app/docker/sources.aliyun /etc/apt/sources.list \
    && apt-get update && apt-get install -y sudo wget curl gnupg2 \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -

RUN apt-get install -y nodejs \
    && apt-get install -y --no-install-recommends google-chrome-unstable \
    && apt-get purge --auto-remove \
    && rm -rf /tmp/* /var/lib/apt/lists/* \
    && rm -rf /usr/bin/google-chrome* /opt/google/chrome-unstable \
    && npm install