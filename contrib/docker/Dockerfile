FROM alpine as builder

COPY ./contrib/docker/config.mk /config.mk

ENV VERSION=$recorder_version

RUN apk add --no-cache --virtual .build-deps \
        curl-dev libconfig-dev make \
        musl-dev mosquitto-dev wget alpine-sdk \
    && apk add --no-cache \
        libcurl libconfig-dev mosquitto-dev lmdb-dev libsodium-dev lua5.2-dev musl \
    && mkdir -p /usr/local/source

COPY . /usr/local/source/

RUN cd /usr/local/source \
    && mv /config.mk ./ \
    && make

FROM alpine

COPY --from=builder /usr/local/source/ot-recorder /usr/bin/ot-recorder
COPY --from=builder /usr/local/source/ocat /usr/bin/ocat
COPY --from=builder /usr/local/source/docroot/ /htdocs

COPY ./contrib/docker/recorder-health.sh /usr/local/sbin/recorder-health.sh
COPY ./contrib/docker/entrypoint.sh /entrypoint.sh

RUN apk add --no-cache curl jq libcurl libconfig-dev mosquitto-dev lmdb-dev libsodium-dev lua5.2-dev musl \
    && chmod 755 /usr/local/sbin/recorder-health.sh \
    && chmod 755 /entrypoint.sh \
    && chmod 755 /usr/bin/ot-recorder /usr/bin/ocat \
    && mkdir -p /store/last \
    && mkdir -p /config

COPY ./contrib/docker/ot-recorder.conf.default /config/ot-recorder.conf.default

VOLUME ["/store", "/config"]

HEALTHCHECK CMD /usr/local/sbin/recorder-health.sh

EXPOSE 8083

ENTRYPOINT ["/entrypoint.sh"]
