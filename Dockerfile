FROM node:18-alpine

# Installation des dépendances système
RUN apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev vips-dev

# Définir le répertoire de travail
WORKDIR /opt/app

# Copier les fichiers de dépendances
COPY package*.json ./

# Installer les dépendances (en utilisant npm install au lieu de npm ci)
RUN npm install --omit=dev

# Copier le reste des fichiers
COPY . .

# Variables d'environnement
ENV NODE_ENV=production

# Build de l'application
RUN npm run build

# Port exposé
EXPOSE 1337

# Commande de démarrage
CMD ["npm", "run", "start"]