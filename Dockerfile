FROM ubuntu:22.04

# install isc-dhcp-server
RUN apt-get update && apt-get install -y isc-dhcp-server

VOLUME /data

COPY entrypoint.sh /entrypoint.sh

EXPOSE 67/udp

ENTRYPOINT ["/entrypoint.sh"]
# CMD ["/entrypoint.sh"]
