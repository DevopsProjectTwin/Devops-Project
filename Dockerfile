# Utilisez une image de base contenant Node.js
FROM node:latest as angular

# Définissez le répertoire de travail dans le conteneur
WORKDIR /app

# Installez les dépendances du projet
RUN npm install

# Copiez les fichiers du projet dans le conteneur
COPY . .

# Construisez l'application Angular pour la production
RUN npm run build 

FROM httpd:latest

WORKDIR /usr/local/apache2/htdocs

COPY --from=angular /app/dist/crudtuto-front .

