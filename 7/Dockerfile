FROM centos:7
LABEL maintainer="jesse@weisner.ca, chriswood.ca@gmail.com"
LABEL build_id="1668808617"

ENV TZ America/Vancouver
ENV RUNUSER none
ENV HOME /

RUN rm -rf /var/cache/yum/* \
 && echo "exclude=mirror.layeronline.com" >> /etc/yum/pluginconf.d/fastestmirror.conf

COPY 7yum.conf /etc/yum.conf

RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY* \
 && yum -y --setopt tsflags=nodocs --setopt timeout=5 update \
 && yum -y --setopt tsflags=nodocs --setopt timeout=5 install \
    wget \
    epel-release \
    tar \
    rsync \
 && rm -rf /var/cache/yum/*

# Add docker-entrypoint script base
ADD https://github.com/itsbcit/docker-entrypoint/releases/download/v1.6/docker-entrypoint.tar.gz /docker-entrypoint.tar.gz
RUN tar zxvf docker-entrypoint.tar.gz && rm -f docker-entrypoint.tar.gz \
 && chmod -R 555 /docker-entrypoint.* \
 && echo "UTC" > /etc/timezone \
 && ln -sf /usr/share/zoneinfo/UTC /etc/localtime \
 && chmod 664 /etc/passwd \
              /etc/group \
              /etc/shadow \
              /etc/timezone \
              /etc/localtime \
 && chown 0:0 /etc/shadow \
 && chmod 775 /etc

# Add dockerize
ADD https://github.com/jwilder/dockerize/releases/download/v0.6.1/dockerize-alpine-linux-amd64-v0.6.1.tar.gz /dockerize.tar.gz
RUN [ -d /usr/local/bin ] || mkdir -p /usr/local/bin \
 && tar zxf /dockerize.tar.gz -C /usr/local/bin \
 && chown 0:0 /usr/local/bin/dockerize \
 && chmod 0555 /usr/local/bin/dockerize \
 && rm -f /dockerize.tar.gz

ENV DOCKERIZE_ENV production

# Add Tini
ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini-static-amd64 /tini
RUN chmod +x /tini \
 && ln -s /tini /sbin/tini 

RUN rm -rf /var/log/* \
 && chmod 1777 /var/log \
 && ln -svf "/usr/share/zoneinfo/${TZ}" /etc/localtime \
 && echo "${TZ}" > /etc/timezone \
 && chmod 664 /etc/timezone /etc/localtime

ENTRYPOINT ["/tini", "--", "/docker-entrypoint.sh"]
