FROM alpine:3.13.5
### LABELS ###
LABEL Guillermo R. Piccoli <grpiccoli@gmail.com>
LABEL base_image="alpine"
LABEL software="FastK"
LABEL software.version="0"

### swtich to root user ###
USER root

### ENV VARS ###
ENV BIN=/usr/local/bin

RUN apk add --no-cache \
bash=5.1.0-r0 \
tzdata=2021a-r0 \
build-base=0.5-r2 \
git=2.30.2-r0 \
zlib-dev=1.2.11-r3 \
bzip2-dev=1.0.8-r1 \
xz-dev=5.2.5-r0 \
curl-dev=7.76.1-r0 \
libbz2=1.0.8-r1 \
xz=5.2.5-r0 \
curl=7.76.1-r0

#set date
RUN cp /usr/share/zoneinfo/NZ /etc/localtime
RUN echo "NZ" >  /etc/timezone

## set bash as default for root ##
RUN sed -i '1{s;/ash;/bash;}' /etc/passwd

# clone FASTK 28/04/2021
RUN mkdir -p /root/bin && \
git clone https://github.com/thegenemyers/FASTK && \
cd FASTK && \
git checkout 84b88d2a04f44c06a2bd3ffb9821de6e4ef1db89 && \
make && \
make install

#cleaning
RUN apk del tzdata build-base git curl-dev zlib-dev bzip2-dev xz-dev

WORKDIR "/root/bin"

ENTRYPOINT ["/root/bin/FastK"]