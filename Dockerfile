FROM amd64/debian:buster-slim
MAINTAINER "gary@bowers1.com"

ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /usr/share/man/man1

# Required Packages
RUN apt-get update -y && \
    apt-get install -y ca-certificates \
                   apt-utils \
                   apt-transport-https \
                   binutils \
                   openssl \
                   openvpn \
                   openvpn-auth-ldap \
                   openvpn-auth-radius \
                   curl \
                   wget \
                   iptables \
                   gnupg && \
    apt-get clean -y && \
    rm -Rf /var/lib/apt/lists/*

# TUN device
RUN mkdir -p /dev/net && \
    mknod /dev/net/tun c 10 200
   

# Install EASY-RSA
ENV rsa_ver="3.0.6"
RUN wget -O /tmp/easyrsa.tgz https://github.com/OpenVPN/easy-rsa/releases/download/v${rsa_ver}/EasyRSA-unix-v${rsa_ver}.tgz && \
    tar -xvzf /tmp/easyrsa.tgz -C /etc/openvpn && \
    rm /tmp/easyrsa.tgz && \
    mv /etc/openvpn/EasyRSA-v${rsa_ver} /etc/openvpn/easy-rsa && \
    chown -R root:root /etc/openvpn/easy-rsa

