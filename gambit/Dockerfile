FROM debian:12-slim AS BUILD
RUN apt-get update && apt-get -y --no-install-recommends install build-essential ghostscript texinfo && rm -rf /var/lib/apt/lists/*

WORKDIR /build
COPY checksum checksum
ADD https://gambitscheme.org/latest/gambit-v4_9_5.tgz gambit.tgz
RUN sha256sum gambit.tgz && sha256sum -c checksum
RUN mkdir gambit && tar -C gambit --strip-components 1 -xf gambit.tgz

WORKDIR /build/gambit
RUN ./configure --prefix=/usr/local --enable-single-host --enable-march=native --enable-dynamic-clib
RUN make -j$(nproc) 
RUN make install

FROM debian:12-slim AS FINAL
RUN apt-get update && apt-get -y --no-install-recommends install gcc libc-dev && rm -rf /var/lib/apt/lists/*
COPY --from=BUILD /usr/local /usr/local
CMD ["gsi"]
