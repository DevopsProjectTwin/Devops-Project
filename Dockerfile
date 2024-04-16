# Utilisez une image de base Node.js
FROM node:14-alpine as builder

# Définissez le répertoire de travail dans le conteneur
WORKDIR /app

# Copiez le package.json et le package-lock.json dans le conteneur
COPY package*.json ./

# Installez les dépendances du projet
RUN npm install

# Copiez les fichiers du projet dans le conteneur
COPY . .

# Construisez l'application Angular pour la production
RUN npm run build --prod

# Stage final : utilisez une image légère Nginx pour servir l'application construite
FROM nginx:1.21-alpine

# Copiez les fichiers de l'application construite depuis le builder stage dans l'image Nginx
COPY --from=builder /app/dist/crudtuto-front /usr/share/nginx/html

# Exposez le port sur lequel Nginx fonctionne
EXPOSE 85

# Commande pour démarrer Nginx lorsqu'un conteneur est lancé
CMD ["nginx", "-g", "daemon off;"]
