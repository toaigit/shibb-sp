FROM debian:bullseye-slim
MAINTAINER Toai Vo <toaivo@stanford.edu>

ARG USERUID

RUN apt-get -qq update && \
    apt-get -qq -y --no-install-recommends install \
        apache2 \
        libapache2-mod-shib && \
    mkdir /etc/apache2/certs && \
    rm -rf /var/lib/apt/lists/*  && \
    a2enmod ssl && \
    a2enmod cgi && \
    a2enmod headers && \
    a2ensite default-ssl

COPY files/apache/ports.conf /etc/apache2/ports.conf

COPY files/apache/default-ssl.conf files/apache/000-default.conf \
     /etc/apache2/sites-enabled/

COPY files/shibb/sp-cert.pem \
     files/shibb/sp-key.pem \
     files/shibb/shibboleth2.xml \
     files/shibb/attribute-map.xml \
     files/shibb/protocols.xml \
     /etc/shibboleth/

COPY files/apache/shibd-apache2 \
     /usr/local/sbin/

RUN cd /etc/shibboleth && \
    chown _shibd sp-*.pem && \
    chmod go= sp-key.pem && \
    usermod -u ${USERUID} www-data && \
    apt-get clean 

EXPOSE 80 443

ENTRYPOINT ["shibd-apache2"]
