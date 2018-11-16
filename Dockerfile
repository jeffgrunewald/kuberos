FROM centos:7.5.1804

RUN yum -y --setopt=tsflags=nodocs update \
 && yum -y --setopt=tsflags=nodocs install \
    cracklib-dicts \
    expect \
    krb5-libs \
    krb5-pkinit \
    krb5-server \
 && yum clean all

COPY init_db.sh /init_db

RUN chmod a+x /init_db