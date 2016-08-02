FROM node:argon
MAINTAINER Kate Heddleston <kate@opsolutely.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get update --fix-missing && apt-get install -y build-essential supervisor rsyslog wget nginx

# stop supervisor service as we'll run it manually
RUN service supervisor stop

ARG NPM_TOKEN

# Add logging conf file
RUN wget -O ./remote_syslog.tar.gz https://github.com/papertrail/remote_syslog2/releases/download/v0.17/remote_syslog_linux_amd64.tar.gz && tar xzf ./remote_syslog.tar.gz && cp ./remote_syslog/remote_syslog /usr/bin/remote_syslog && rm ./remote_syslog.tar.gz && rm -rf ./remote_syslog/

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY ./docker_files/package.json /usr/src/app/
RUN npm install

EXPOSE 80

CMD supervisord -c /etc/supervisor/conf.d/supervisord.conf
