FROM ubuntu:10.04
MAINTAINER Toru Hisai <toru@torus.jp>

RUN apt-get update -y
RUN apt-get install -y wget gcc
RUN apt-get install -y zlib1g-dev
RUN apt-get install -y slib
RUN apt-get install -y make

WORKDIR /tmp
RUN wget http://prdownloads.sourceforge.net/gauche/Gauche-0.9.3.3.tgz
RUN tar xvfz Gauche-0.9.3.3.tgz

WORKDIR Gauche-0.9.3.3
RUN ./configure
RUN make
RUN make check
RUN make install

RUN apt-get install -y autoconf
ADD Gauche /tmp/Gauche
WORKDIR /tmp/Gauche
RUN ./DIST gen
RUN ./configure --prefix=/opt/gauche
RUN make
RUN make check
RUN make install

WORKDIR /opt
ENTRYPOINT tar cf - gauche
