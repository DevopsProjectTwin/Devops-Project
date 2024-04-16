# Utilisez une image de base contenant Node.js
FROM node:latest

# Définissez le répertoire de travail dans le conteneur
WORKDIR /usr/src/app

# Copiez le package.json et package-lock.json (si présent)
COPY package*.json ./

# Installez les dépendances du projet
RUN npm install

# Copiez les fichiers du projet dans le conteneur
COPY . .

# Construisez l'application Angular pour la production
RUN npm run build --prod

# Exposez le port sur lequel l'application Angular fonctionne (8089 dans votre cas)
EXPOSE 8085

# Commande pour démarrer l'application Angular
CMD ["npm", "start"]
