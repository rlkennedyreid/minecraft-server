FROM openjdk:17-slim

RUN \
apt-get update --yes --quiet && \
apt-get upgrade --yes --quiet && \
apt-get install --yes --quiet wget neovim && \
apt-get autoremove --yes --quiet --purge && \
apt-get clean --yes --quiet

ARG \
SERVER_URL \
PID=911 \
PGID=911 \
USER_NAME=minecraft \
EULA=false

RUN \
set -ex && \
wget -q ${SERVER_URL} -O /opt/server.jar && \
chmod +x /opt/server.jar && \
groupadd -r -g ${PGID} ${USER_NAME} && \
useradd -r -u ${PID} -g ${USER_NAME} -d /srv ${USER_NAME} && \
chown -R ${PID}:${PGID} /srv

USER ${USER_NAME}

WORKDIR /srv

EXPOSE 25565

COPY jvm.options /etc/
COPY entrypoint.sh /usr/bin/

ENV EULA=${EULA}

ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]
