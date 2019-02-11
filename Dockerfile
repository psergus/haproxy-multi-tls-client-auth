FROM ubuntu:16.04

# Author of this Dockerfile
MAINTAINER Engineering <engineering@onelogin.com>

# Update & upgrades
RUN apt-get update && apt-get dist-upgrade -y
RUN \
    apt-get update && \
    apt-get install -y haproxy curl telnet rsyslog

COPY bin/entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 443/tcp

# ENTRYPOINT ["/entrypoint.sh"]
CMD ["haproxy", "-f", "/etc/haproxy/haproxy.cfg", "-p", "/run/haproxy.pid"]
