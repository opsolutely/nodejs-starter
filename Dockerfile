FROM node:argon
MAINTAINER Kate Heddleston <kate@opsolutely.com>

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY ./docker_files/package.json /usr/src/app/
RUN npm install

EXPOSE 8080

CMD supervisord -c /etc/supervisor/conf.d/supervisord.conf
