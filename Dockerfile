FROM erlang:20-alpine

ARG UID
ARG GID

RUN apk add --no-cache make git && \
  addgroup -S -g "$UID" app && \
  adduser -S -u "$UID" -G app app

WORKDIR /home/app/src

USER app