FROM djavanargent/alpine:3.5
MAINTAINER djavanargent

ENV MEDIAINFO_VERSION='0.7.93'

# Install packages
RUN \
  apk add --no-cache \
    curl \
    g++ \
    gcc \
    git \
    libcurl \
    make \
    python2 \
    sqlite \
    tar \
    unrar \
    wget \
    xz \
    zlib-dev && \
  apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/testing \
    mono && \

# install mediainfo
  mkdir /build && \
  curl -o /build/MediaInfo_CLI_${MEDIAINFO_VERSION}_GNU_FromSource.tar.xz -L https://mediaarea.net/download/binary/mediainfo/${MEDIAINFO_VERSION}/MediaInfo_CLI_${MEDIAINFO_VERSION}_GNU_FromSource.tar.xz && \
  curl -o /build//MediaInfo_DLL_${MEDIAINFO_VERSION}_GNU_FromSource.tar.xz -L https://mediaarea.net/download/binary/libmediainfo0/${MEDIAINFO_VERSION}/MediaInfo_DLL_${MEDIAINFO_VERSION}_GNU_FromSource.tar.xz && \
  cd /build && \
  tar xpf MediaInfo_CLI_${MEDIAINFO_VERSION}_GNU_FromSource.tar.xz && \
  tar xpf MediaInfo_DLL_${MEDIAINFO_VERSION}_GNU_FromSource.tar.xz && \
  cd /build/MediaInfo_CLI_GNU_FromSource && \
  ./CLI_Compile.sh && \
  cd /build/MediaInfo_CLI_GNU_FromSource/MediaInfo/Project/GNU/CLI/ && \
  make install && \
  cd /build/MediaInfo_DLL_GNU_FromSource && \
  ./SO_Compile.sh && \
  cd /build/MediaInfo_DLL_GNU_FromSource/MediaInfoLib/Project/GNU/Library && \
  make install && \
  cd /build/MediaInfo_DLL_GNU_FromSource/ZenLib/Project/GNU/Library && \
  make install && \

# clean up
  apk del --purge \
    make \
    g++ \
    gcc \
    git \
    sqlite && \
  rm -rf \
    /root/.cache \
    /tmp/* \
    /build/*
