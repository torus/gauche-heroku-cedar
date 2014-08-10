FROM ubuntu:10.04
MAINTAINER Toru Hisai <toru@torus.jp>

RUN apt-get update -y
RUN apt-get install -y wget gcc
RUN apt-get install -y zlib1g-dev slib
RUN apt-get install -y make autoconf

# Gauche-gl-related packages

RUN apt-get install -y freeglut3-dev libglew1.5-dev
RUN apt-get install -y libxmu-dev libxi-dev libxext-dev libx11-dev

# Gauche released version

WORKDIR /tmp
RUN wget http://prdownloads.sourceforge.net/gauche/Gauche-0.9.4.tgz
RUN tar xvfz Gauche-0.9.4.tgz

WORKDIR Gauche-0.9.4
RUN ./configure
RUN make
RUN make check
RUN make install

# Gauche HEAD

ADD Gauche /tmp/Gauche
WORKDIR /tmp/Gauche
RUN ./DIST gen
RUN ./configure --prefix=/opt/gauche
RUN make
RUN make check
RUN make install
ENV PATH /opt/gauche/bin:$PATH

# Gauche-makiki

ADD Gauche-makiki /tmp/Gauche-makiki
WORKDIR /tmp
WORKDIR /tmp/Gauche-makiki
RUN ./DIST gen
RUN sh -c `gauche-config --reconfigure`
RUN make
RUN make check
RUN make install

# Gauche-redis

ADD Gauche-redis /tmp/Gauche-redis
WORKDIR /tmp/Gauche-redis
RUN ./DIST gen
RUN sh -c `gauche-config --reconfigure`
RUN make
#RUN make check
RUN make install

# Gauche-gl

ADD Gauche-gl /tmp/Gauche-gl
WORKDIR /tmp/Gauche-gl
RUN ./DIST gen
RUN sh -c `gauche-config --reconfigure`
RUN make
RUN make check
RUN make install


WORKDIR /opt
ENTRYPOINT tar cf - gauche
