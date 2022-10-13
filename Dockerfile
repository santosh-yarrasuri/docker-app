FROM node:16-alpine as builder

WORKDIR '/home/app'

COPY package.json .
RUN npm install
RUN mkdir node_modules/.cache && chmod -R 777 node_modules/.cache

COPY . .
RUN npm run build

FROM nginx
copy --from=builder /home/app/build /usr/share/niginx/html
