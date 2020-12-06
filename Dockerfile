
FROM node:12.16.3

WORKDIR /usr/src/app
COPY package*.json ./
COPY tsconfig*.json ./
COPY ./src ./src
RUN npm ci && npm run build

FROM node:12.16.3-alpine
WORKDIR /app

COPY package*.json ./
RUN npm ci --production && npm cache clean --force
COPY --from=base /usr/src/app/dist ./dist

ENV NODE_ENV=production
EXPOSE 8080
CMD ["node", "dist/main.js"]