FROM docker.io/library/ubuntu AS build
RUN apt-get update && apt-get install cbonsai

FROM quay.io/fedora/fedora-bootc:43
COPY --from=build /usr/games/cbonsai /usr/local/bin/cbonsai

