FROM node:23-alpine
WORKDIR /syrlex2mqtt
ADD syrlex2mqtt .
RUN npm install
COPY register-and-run.sh /usr/local/bin/
CMD [ "register-and-run.sh" ]
