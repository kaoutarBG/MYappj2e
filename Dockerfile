# --------------- DÉBUT COUCHE OS -------------------
FROM debian:stable-slim
# --------------- FIN COUCHE OS ---------------------


# MÉTADONNÉES DE L'IMAGE
LABEL version="1.0" maintainer="khlifi houcem <houcemkhlifi.devops@gmail.com>"


# VARIABLES TEMPORAIRES
ARG APT_FLAGS="-q -y"
ARG DOCUMENTROOT="/var/www/html"



# --------------- DÉBUT COUCHE APACHE ---------------
RUN apt-get update && \
    apt-get install -y --no-install-recommends apache2=2.4.52-1ubuntu4.18 &&  \
    rm -rf /var/lib/apt/lists/*
# --------------- FIN COUCHE APACHE -----------------



# --------------- DÉBUT COUCHE MYSQL ----------------
RUN apt-get install -y --no-install-recommends mariadb-server=1:10.6.23-0ubuntu0.22.04.1 && \
    rm -rf /var/lib/apt/lists/*

COPY db/articles.sql /
# --------------- FIN COUCHE MYSQL ------------------



# --------------- DÉBUT COUCHE PHP ------------------
RUN apt-get install -y --no-install-recommends ${APT_FLAGS} \
    php-mysql \
    php && \
    rm -f ${DOCUMENTROOT}/index.html && \
    apt-get autoclean -y

COPY app ${DOCUMENTROOT}
# --------------- FIN COUCHE PHP --------------------


# OUVERTURE DU PORT HTTP
EXPOSE 80


# RÉPERTOIRE DE TRAVAIL
WORKDIR  ${DOCUMENTROOT}


# DÉMARRAGE DES SERVICES LORS DE L'EXÉCUTION DE L'IMAGE
ENTRYPOINT ["sh", "c", "service mariadb start && mysql < /articles.sql && apache2ctl -D FOREGROUND"]
