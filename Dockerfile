FROM debian:jessie

ENV GUILE_AUTO_COMPILE 0

WORKDIR /tmp

RUN apt-get update -y \
 # mdk requirements
 && apt-get install intltool -y \
 && apt-get install make -y \
 && apt-get install flex=2.5.39-8+deb8u2 -y \
 && apt-get install libglib2.0-0 libglib2.0-dev -y \
 && apt-get install guile-2.0 guile-2.0-dev -y \
 && apt-get install curl -y \
 # mdk from ftp
 && curl 'ftp://ftp.gnu.org/pub/gnu/mdk/v1.2.10/mdk-1.2.10.tar.gz' -o mdk-1.2.10.tar.gz

WORKDIR /opt

RUN tar xfzv /tmp/mdk-1.2.10.tar.gz \
 && cd mdk-1.2.10 \
 && ./configure --disable-dependency-tracking \
 && make && make install

WORKDIR /home

#CMD mixvm
ENTRYPOINT ["mixvm"]
