FROM centos:6
LABEL maintainer="jesse@weisner.ca"

ENV RUNUSER none
ENV HOME /

RUN rm -rf /var/cache/yum/*

RUN echo "exclude=mirror.layeronline.com" >> /etc/yum/pluginconf.d/fastestmirror.conf

RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY* \
 && yum -y --setopt tsflags=nodocs --setopt timeout=5 update \
 && yum -y --setopt tsflags=nodocs --setopt timeout=5 install \
    wget \
    epel-release \
 && rm -rf /var/cache/yum/*

# Add docker-entrypoint script base
ENV DE_VERSION v1.1
ADD https://github.com/itsbcit/docker-entrypoint/releases/download/${DE_VERSION}/docker-entrypoint.tar.gz /docker-entrypoint.tar.gz
RUN tar zxvf docker-entrypoint.tar.gz && rm -f docker-entrypoint.tar.gz
RUN chmod -R 555 /docker-entrypoint.*

# Allow resolve-userid.sh script to run
RUN chmod 664 /etc/passwd /etc/group

# Add Tini
ENV TINI_VERSION v0.17.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

ENTRYPOINT ["/tini", "--", "/docker-entrypoint.sh"]
