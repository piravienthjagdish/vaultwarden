FROM vaultwarden/server:alpine

COPY ./content /workdir/

RUN apk add --no-cache caddy runit \
    && chmod +x /workdir/service/*/run \
    && ln -s /workdir/service/* /etc/service/

ENV PORT=8080
ENV ROCKET_ADDRESS=127.0.0.1
ENV ROCKET_PORT=60000
ENV WEBSOCKET_ADDRESS=127.0.0.1
ENV WEBSOCKET_PORT=60001
ENV WEBSOCKET_ENABLED=true
ENV SIGNUPS_ALLOWED=true
ENV IP_HEADER=X-Forwarded-For
ENV DATABASE_URL=data/db.sqlite3

EXPOSE 8080

ENTRYPOINT [ "runsvdir", "/etc/service" ]