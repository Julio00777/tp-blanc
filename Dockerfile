FROM node:lts-alpine

ENV NODE_ENV=production
WORKDIR /home/node/app
COPY --chown=node:node package*.json ./
RUN npm ci --omit=dev && npm cache clean --force
USER node
COPY --chown=node:node . .
EXPOSE 3000
CMD ["node", "server.js"]
