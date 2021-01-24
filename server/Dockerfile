# start from node latest
FROM node:lts-alpine as base

# set working directory
WORKDIR /usr/src/app

# copy and install packages
COPY package*.json ./

# install production only
RUN npm install --only=production

# copy src code
COPY . .

# run server
ENTRYPOINT [ "node", "./src/index.js" ]
