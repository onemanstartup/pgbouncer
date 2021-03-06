FROM alpine:3.7

MAINTAINER onemanstartup@gmail.com

RUN apk update && \
    apk upgrade && \
    apk --update add git build-base automake libtool m4 autoconf libevent-dev openssl-dev c-ares-dev \
        bash bash-doc bash-completion util-linux pciutils usbutils coreutils binutils findutils grep py-docutils && \
	git clone https://github.com/pgbouncer/pgbouncer.git && \
	cd pgbouncer                    && \
	git checkout pgbouncer_1_8_1    && \
	git submodule init              && \
	git submodule update            && \
	./autogen.sh                    && \
	./configure --prefix=/usr/local --with-libevent=/usr/lib && \
	make && make install && \
	apk del git build-base automake autoconf libtool m4 py-docutils && \
	rm -f /var/cache/apk/* \
        && cd .. && rm -Rf pgbouncer

ADD entrypoint.sh ./

ENTRYPOINT ["./entrypoint.sh"]
