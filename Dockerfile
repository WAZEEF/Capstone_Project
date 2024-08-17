FROM node:18-alpine AS build

WORKDIR /app

COPY . .

COPY install_with_manifest.sh /app/install_with_manifest.sh

RUN chmod +x /app/install_with_manifest.sh

RUN /bin/sh /app/install_with_manifest.sh

FROM nginx:alpine

COPY --from=build /app /usr/share/nginx/html

EXPOSE 80 9090

CMD sh -c "nginx -g 'daemon off;' "
