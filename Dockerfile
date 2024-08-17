FROM node:18-alpine AS build

WORKDIR /app

COPY . .

COPY install_with_manifest.sh /app/install_with_manifest.sh

RUN chmod +x /app/install_with_manifest.sh

RUN ls /app/

RUN /bin/sh /app/install_with_manifest.sh

FROM prom/prometheus:v2.46.0 as prometheus

COPY prometheus.yml /etc/prometheus/prometheus.yml

FROM nginx:alpine

COPY --from=build /app /usr/share/nginx/html

EXPOSE 80 9090

CMD sh -c "nginx -g 'daemon off;' & /usr/local/bin/prometheus --config.file=/etc/prometheus/prometheus.yml --web.listen-address=:9090 & tail -f /dev/null"
