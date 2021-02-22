FROM node:14.15.5 as node
WORKDIR /app
COPY package.json /app/
RUN npm i npm@latest -g
RUN npm install
COPY ./ /app/
MAINTAINER Rodrigo Brito
ARG env=prod
RUN npm run build

FROM nginx:1.13
COPY --from=node /app/dist/angular-node /usr/share/nginx/html
COPY ./nginx-custom.conf /etc/nginx/conf.d/default.conf