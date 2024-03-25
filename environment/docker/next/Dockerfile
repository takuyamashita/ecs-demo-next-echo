FROM node:20-alpine as build
WORKDIR /app

COPY src/next/demo/package*.json ./

RUN npm ci

COPY src/next/demo ./

RUN npm run build

FROM node:20-alpine as production

WORKDIR /app

COPY src/next/demo/package*.json ./

RUN npm ci --only=production

COPY --from=build /app/.next ./.next

COPY src/next/demo/public ./public

COPY src/next/demo/next.config.mjs ./

EXPOSE 3000

USER node

CMD ["npm", "start"]

