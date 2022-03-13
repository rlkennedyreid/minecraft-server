FROM openjdk:17-slim

RUN \
apt-get update --yes --quiet && \
apt-get upgrade --yes --quiet && \
apt-get install --yes --quiet wget neovim && \
apt-get autoremove --yes --quiet --purge && \
apt-get clean --yes --quiet

ARG \
PROXY_URL \
PID=911 \
PGID=911 \
USER_NAME=mc_proxy

RUN \
set -ex && \
wget -q ${PROXY_URL} -O /opt/proxy.jar && \
chmod +x /opt/proxy.jar && \
groupadd -r -g ${PGID} ${USER_NAME} && \
useradd -r -u ${PID} -g ${USER_NAME} -d /srv ${USER_NAME} && \
chown -R ${PID}:${PGID} /srv

USER ${USER_NAME}

WORKDIR /srv

EXPOSE 25577

COPY jvm.options /etc/

ENTRYPOINT [ "java", "@/etc/jvm.options", "-jar", "/opt/proxy.jar" ]
