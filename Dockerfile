FROM node:22.18.0-alpine3.22 AS build

RUN apk add --no-cache git

WORKDIR /app

COPY package.json yarn.lock ./
# node:22 已自带 yarn 1.x，无需再 npm i -g yarn
RUN yarn install --frozen-lockfile

COPY . .
RUN yarn build

FROM nginx:1.24-alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
