FROM node:20-alpine AS build

WORKDIR /Coding-Portfolio-Project

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build -- --configuration production

FROM nginx:alpine AS runtime

RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /Coding-Portfolio-Project/dist/coding-portfolio-project/browser /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]