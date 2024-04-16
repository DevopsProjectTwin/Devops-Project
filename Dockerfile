# Utilisez une image de base Node.js avec un tag spécifique
FROM node:14-alpine as builder

# Définissez le répertoire de travail dans le conteneur
WORKDIR /app

# Copiez le package.json et le package-lock.json dans le conteneur
COPY package*.json ./

# Installez les dépendances du projet et nettoyez le cache npm
RUN npm install --quiet && npm cache clean --force

# Copiez les fichiers du projet dans le conteneur
COPY . .

# Construisez l'application Angular pour la production
RUN npm run build --prod

# Stage final : utilisez une image légère Nginx avec un tag spécifique
FROM nginx:1.21-alpine

# Définissez une variable d'environnement pour le port Nginx
ENV NGINX_PORT=85

# Copiez les fichiers de l'application construite depuis le builder stage dans l'image Nginx
COPY --from=builder /app/dist/crudtuto-front /usr/share/nginx/html

# Copiez le fichier de configuration Nginx modifié
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Exposez le port sur lequel Nginx fonctionne
EXPOSE $NGINX_PORT

# Commande pour démarrer Nginx lorsqu'un conteneur est lancé
CMD ["nginx", "-g", "daemon off;"]
