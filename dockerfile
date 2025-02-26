
FROM instrumentisto/flutter:3.19.6 AS build-env
ARG INCLUDE_KEYCLOAK=false   #default argument when not provided in the --build-arg

RUN mkdir /app/
COPY . /app/
WORKDIR /app/
RUN if [ "$INCLUDE_KEYCLOAK" = "false" ] ; then echo 'Keycloak support is disabled'; else /app/add_keycloak.sh; fi
RUN flutter build web

FROM nginx
COPY --from=build-env /app/build/web /usr/share/nginx/html
