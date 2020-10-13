FROM ubuntu:18.04

LABEL maintainer="Katerinati"
# https://docs.docker.com/engine/reference/builder/
# RUN apt-get update && apt-get install -y wget
# RUN apt-get install -y gcc
# RUN apt-get install -y gawk
# RUN apt-get install -y zlib1g-dev
# RUN apt-get install -y libbz2-dev
# RUN apt-get install -y make
# RUN ./configure --prefix=/SOFT/ --without-curses --disable-lzma \

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y r-base-core && apt-get install -y wget

RUN mkdir /SOFT/ \
 && cd /SOFT/ \
 && wget https://github.com/samtools/samtools/releases/download/1.11/samtools-1.11.tar.bz2 \
 && tar xjf samtools-1.11.tar.bz2 \
 && rm samtools-1.11.tar.bz2 \
 && cd samtools-1.11 \
 && ./configure --prefix=/SOFT/ \
 && make \
 && make install

RUN cd /SOFT \
 && wget https://github.com/samtools/htslib/releases/download/1.11/htslib-1.11.tar.bz2 \
 && tar xjf htslib-1.11.tar.bz2 \
 && rm htslib-1.11.tar.bz2 \
 && ./configure \
 && make \
 && make install \
 
WORKDIR /SOFT/

ENTRYPOINT ["/bin/sh"]