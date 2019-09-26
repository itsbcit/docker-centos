FROM bcit/centos-baseimage:8
LABEL maintainer="jesse@weisner.ca, chriswood.ca@gmail.com"
LABEL build_id="1569531573"

ENV RUNUSER none
ENV HOME /

RUN rm -rf /var/cache/yum/* \
 && echo "exclude=mirror.layeronline.com" >> /etc/yum/pluginconf.d/fastestmirror.conf

RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY* \
 && yum -y --setopt tsflags=nodocs --setopt timeout=5 update \
 && yum -y --setopt tsflags=nodocs --setopt timeout=5 install \
    wget \
    epel-release \
    tar \
 && rm -rf /var/cache/yum/*

# Add docker-entrypoint script base
ADD https://github.com/itsbcit/docker-entrypoint/releases/download/v1.5/docker-entrypoint.tar.gz /docker-entrypoint.tar.gz
RUN tar zxvf docker-entrypoint.tar.gz && rm -f docker-entrypoint.tar.gz \
 && chmod -R 555 /docker-entrypoint.* \
 && chmod 664 /etc/passwd /etc/group /etc/shadow \
 && chown 0:0 /etc/shadow \
 && chmod 775 /etc

# Add dockerize
ADD https://github.com/jwilder/dockerize/releases/download/v0.6.0/dockerize-alpine-linux-amd64-v0.6.0.tar.gz /dockerize.tar.gz
RUN [ -d /usr/local/bin ] || mkdir -p /usr/local/bin \
 && tar zxf /dockerize.tar.gz -C /usr/local/bin \
 && chown 0:0 /usr/local/bin/dockerize \
 && chmod 0555 /usr/local/bin/dockerize \
 && rm -f /dockerize.tar.gz

ENV DOCKERIZE_ENV production

# Add Tini
ADD https://github.com/krallin/tini/releases/download/v0.18.0/tini-static-amd64 /tini
RUN chmod +x /tini

ENTRYPOINT ["/tini", "--", "/docker-entrypoint.sh"]
# Install & configure supervisor
RUN yum -y --setopt tsflags=nodocs --setopt timeout=5 install \
        https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/28/Everything/x86_64/os/Packages/s/supervisor-3.3.3-2.fc28.noarch.rpm \
        https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/28/Everything/x86_64/os/Packages/p/python3-meld3-1.0.2-6.fc28.noarch.rpm \
        https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/28/Everything/x86_64/os/Packages/p/python-meld3-1.0.2-6.fc28.noarch.rpm \
        https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/28/Everything/x86_64/os/Packages/p/python2-meld3-1.0.2-6.fc28.noarch.rpm \
 && mkdir -p /var/log/supervisor \
 && mkdir -p /etc/supervisor/conf.d
COPY supervisor.conf /etc/supervisor.conf

CMD ["supervisord", "-c", "/etc/supervisor.conf"]
