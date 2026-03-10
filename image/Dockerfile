FROM alpine:latest AS builder
RUN apk add --no-cache gcc musl-dev git make linux-headers libpcap-dev
RUN cd / \
    && git clone https://github.com/xelerance/xl2tpd.git \
    && cd xl2tpd \
    && sed -i '1iLDFLAGS=-static' Makefile \
    && make

FROM alpine
LABEL maintainer="Milan Simanek milan.simanek@misisoft.net"
RUN    apk add ppp \
    && mknod /dev/ppp c 108 0 \
    && mkdir -p /var/run/xl2tpd /etc/xl2tpd
COPY --from=builder /xl2tpd/xl2tpd /xl2tpd/xl2tpd-control /bin
COPY ip-up ip-down networks options.* /etc/ppp
COPY xl2tpd.client.example xl2tpd.server.example /etc/xl2tpd
COPY start.sh /bin
CMD [ "/bin/start.sh" ]
