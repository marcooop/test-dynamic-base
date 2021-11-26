# build stage
FROM node:lts-alpine3.10 as build-stage
WORKDIR /app

COPY ./nuxt.config.js ./
COPY ./package*.json ./

RUN npm install
COPY ./ .
RUN npm run build

# production stage
FROM node:lts-alpine3.10 as production-stage
WORKDIR /app

COPY --from=build-stage /app/ .

EXPOSE 8080

CMD ["npm", "run", "start"]
