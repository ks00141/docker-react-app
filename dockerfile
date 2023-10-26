FROM node:alpine as builder
WORKDIR '/usr/src/app'
COPY package.json .
RUN npm install
RUN npm install --save-dev @babel/plugin-proposal-private-property-in-object --legacy-peer-deps
COPY ./ ./
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /usr/src/app/build /usr/share/nginx/html