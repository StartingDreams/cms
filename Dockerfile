FROM node:6.3.0-onbuild

WORKDIR /usr/src/app

RUN mkdir -p /usr/src/app
RUN mkdir -p /entrypoints

COPY ./entrypoints /entrypoints
COPY ./gulp /usr/src/app/
COPY ./gulpfile.js /usr/src/app/
COPY ./package.json /usr/src/app/

RUN npm install -g gulp-cli
RUN npm install

COPY . /usr/src/app/build

EXPOSE 3000
EXPOSE 3443

CMD [ "/entrypoints/entrypoint.sh" ]
