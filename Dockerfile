FROM node:18-alpine
# Installation des dépendances système nécessaires
RUN apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev vips-dev > /dev/null 2>&1

WORKDIR /opt/
COPY package.json package-lock.json ./
RUN npm config set network-timeout 600000 -g && npm install

WORKDIR /opt/app
COPY . .
ENV NODE_ENV production
RUN npm run build

EXPOSE 1337
CMD ["npm", "run", "start"]