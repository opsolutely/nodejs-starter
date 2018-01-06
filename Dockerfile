FROM node:5
MAINTAINER Kate Heddleston <kate@opsolutely.com>

ARG NPM_TOKEN
ENV NODE_ENV=production
ENV FORCE_HTTPS=true

# Authenticate private NPM registry
# RUN echo "//registry.npmjs.org/:_authToken=${NPM_TOKEN}" > ~/.npmrc

# Create app directory
RUN mkdir -p /srv/www/app
WORKDIR /srv/www/app

COPY package.json package.json
RUN npm install

RUN rm -f ~/.npmrc

COPY . .
RUN npm run build

EXPOSE 3000
CMD npm run start
