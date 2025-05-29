FROM node:20.19.1-alpine
WORKDIR KP/app/frontend/front
COPY package.json .
RUN npm install
COPY . .
EXPOSE 8020
CMD [ "npm", "run", "dev" ]