FROM node:23-alpine
WORKDIR /syrlex2mqtt
ADD syrlex2mqtt .
RUN npm install
CMD [ "node", "syrlex2mqtt.js" ]