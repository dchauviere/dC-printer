FROM nginx:1.21-alpine AS build

RUN mkdir -p /opt/mainsail \
  && cd /opt/mainsail \
  && wget -q -O mainsail.zip https://github.com/mainsail-crew/mainsail/releases/latest/download/mainsail.zip && unzip mainsail.zip && rm mainsail.zip

COPY mainsail.site.conf /etc/nginx/conf.d/default.conf 
COPY upstreams.conf /etc/nginx/conf.d/upstreams.conf
COPY common_vars.conf /etc/nginx/conf.d/common_vars.conf

