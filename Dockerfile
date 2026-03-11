FROM node:20-alpine

# Définition de l'environnement de production
ENV NODE_ENV=production

# On travaille dans le répertoire personnel de l'utilisateur node
WORKDIR /home/node/app

# Copie des fichiers de dépendances avec les bonnes permissions
# On le fait AVANT le reste du code pour profiter du cache Docker
COPY --chown=node:node package*.json ./

# Installation des dépendances de PROD uniquement (--omit=dev)
# npm ci est plus rapide et plus strict que npm install pour la CI
RUN npm ci --omit=dev && npm cache clean --force

# Changement d'utilisateur pour la suite des opérations
USER node

# Copie du reste du code source
COPY --chown=node:node . .

# L'application écoute sur le port 3000
EXPOSE 3000

# Lancement de l'application
CMD ["node", "server.js"]
