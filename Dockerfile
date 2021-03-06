ARG BUILDER_IMAGE=neubauergroup/centos-python3:3.9.9
FROM ${BUILDER_IMAGE} as builder

USER root
ENV HOME=/root
WORKDIR /

SHELL [ "/bin/bash", "-c" ]

# CentOS 7's version of CMake is too old (v2.8.12) so build CMake from
# source instead
ARG CMAKE_VERSION=3.20.2
RUN yum update -y && \
    yum install -y \
      gcc \
      gcc-c++ \
      git \
      make && \
    yum clean all && \
    yum autoremove -y && \
    mkdir -p /build && \
    cd /build && \
    curl -sLO "https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}.tar.gz" && \
    tar -xzf "cmake-${CMAKE_VERSION}.tar.gz" && \
    cd "cmake-${CMAKE_VERSION}" && \
    ./bootstrap && \
    make -j"$(($(nproc) - 1))" && \
    make install && \
    cd / && \
    rm -rf /build && \
    cmake --version
