FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY  /dist/crudtuto-Front  /usr/share/nginx/html



