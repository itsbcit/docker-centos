FROM centos:6
LABEL maintainer="jesse@weisner.ca, chriswood.ca@gmail.com"

ENV RUNUSER none
ENV HOME /

RUN rm -rf /var/cache/yum/* && \
    echo "exclude=mirror.layeronline.com" >> /etc/yum/pluginconf.d/fastestmirror.conf

RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY* \
 && yum -y --setopt tsflags=nodocs --setopt timeout=5 update \
 && yum -y --setopt tsflags=nodocs --setopt timeout=5 install \
    wget \
    epel-release && \
    rm -rf /var/cache/yum/*

# Add docker-entrypoint script base
ADD https://github.com/itsbcit/docker-entrypoint/releases/download/v1.3/docker-entrypoint.tar.gz /docker-entrypoint.tar.gz
RUN tar zxvf docker-entrypoint.tar.gz \
 && rm -f docker-entrypoint.tar.gz \
 && chmod -R 555 /docker-entrypoint.* \
 && chmod 664 /etc/passwd /etc/group\
 && chmod 060 /etc/shadow

# Add Tini
ADD https://github.com/krallin/tini/releases/download/v0.18.0/tini-static-amd64 /tini
RUN chmod +x /tini

ENTRYPOINT ["/tini", "--", "/docker-entrypoint.sh"]
# Install & configure supervisor
RUN yum -y --setopt tsflags=nodocs --setopt timeout=5 install \
    supervisor && \
    mkdir -p /var/log/supervisor && \
    mkdir -p /etc/supervisor/conf.d
COPY supervisor.conf /etc/supervisor.conf

CMD ["supervisord", "-c", "/etc/supervisor.conf"]
