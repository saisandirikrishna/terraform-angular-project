# Build Stage
FROM node:22.22.3 AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Runtime Stage
FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*

COPY --from=build /app/dist/terraform-angular-project/browser/ /usr/share/nginx/html/

# RUN cp /usr/share/nginx/html/index.csr.html \
#        /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]