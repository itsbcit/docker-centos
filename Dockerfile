FROM centos:7
LABEL maintainer="jesse@weisner.ca"

ENV RUNUSER none
ENV HOME /

RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY* \
 && yum -y --setopt tsflags=nodocs -d0 update \
 && yum -y --setopt tsflags=nodocs -d0 install vim-enhanced wget epel-release \
 && rm -rf /var/cache/yum

ADD docker-entrypoint.sh /docker-entrypoint.sh
ADD docker-entrypoint.d /docker-entrypoint.d
RUN chmod -R 555 /docker-entrypoint.*

# Allow resolve-userid.sh script to run
RUN chmod 664 /etc/passwd /etc/group

# Add Tini
ENV TINI_VERSION v0.17.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

ENTRYPOINT ["/tini", "--", "/docker-entrypoint.sh"]
