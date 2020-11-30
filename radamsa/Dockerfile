FROM ubuntu:18.04

# docker hardcoded sh
SHELL ["/bin/bash", "-c"]

# env setup
ENV DEBIAN_FRONTEND=noninteractive

# install proper tools
RUN apt-get update && \
    apt-get install -yq sudo vim htop

RUN sudo apt-get update -qq && sudo apt-get -y install \
    autoconf \
    automake \
    build-essential \
    cmake \
    git-core \
    ffmpeg \
    curl \
    wget

# Copy startup script
COPY ./screen.sh /root/screen.sh
RUN chmod +x /root/screen.sh

# Install Radamza
RUN git clone https://gitlab.com/akihe/radamsa.git && \
    cd radamsa && \
    make && sudo make install

ENTRYPOINT ["/root/screen.sh"]
