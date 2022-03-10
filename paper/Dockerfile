FROM openjdk:17-slim

RUN apt-get update     --yes --quiet && \
    apt-get upgrade    --yes --quiet && \
    apt-get install    --yes --quiet wget && \
    apt-get autoremove --yes --quiet --purge && \
    apt-get clean      --yes --quiet

ARG PAPER_URL=https://papermc.io/api/v2/projects/paper/versions/1.18.1/builds/216/downloads/paper-1.18.1-216.jar \
    PID=911 \
    PGID=911

ENV MC_USER=minecraft \
    MC_SERVER_DIR=/srv/minecraft

RUN groupadd -r -g ${PGID} ${MC_USER} && \
    useradd -r -u ${PID} -g ${MC_USER} -d ${MC_SERVER_DIR} ${MC_USER}

RUN mkdir -p ${MC_SERVER_DIR} && chown -R ${MC_USER}:${MC_USER} ${MC_SERVER_DIR}

USER ${MC_USER}

WORKDIR ${MC_SERVER_DIR}

RUN mkdir world jars

RUN wget -q ${PAPER_URL} -O ${MC_SERVER_DIR}/jars/paper.jar

WORKDIR ${MC_SERVER_DIR}/world

EXPOSE 25565

COPY --chown=${MC_USER} jvm.options /etc/

# see https://docs.papermc.io/paper/aikars-flags
ENTRYPOINT [ "java", "@/etc/jvm.options", "-jar", "../jars/paper.jar" ]

CMD [ "--nogui" ]
