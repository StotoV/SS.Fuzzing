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
    libass-dev \
    libfreetype6-dev \
    libsdl2-dev \
    libtool \
    libva-dev \
    libvdpau-dev \
    libvorbis-dev \
    libxcb1-dev \
    libxcb-shm0-dev \
    libxcb-xfixes0-dev \
    pkg-config \
    texinfo \
    wget \
    zlib1g-dev \
    yasm \
    nasm \
    libx264-dev \ 
    libx265-dev \
    libnuma-dev \
    libvpx-dev \ 
    libfdk-aac-dev \ 
    libmp3lame-dev \ 
    libopus-dev \
    python3 \
    python3-pip \
    python2.7 \
    python-pip \
    screen \
    ffmpeg

# install pip / update
RUN pip install --upgrade pip && pip3 install --upgrade pip

# Copy startup script
COPY ./screen.sh /root/screen.sh
RUN chmod +x /root/screen.sh

# Install Radamza
RUN git clone https://gitlab.com/akihe/radamsa.git && \
    cd radamsa && \
    make && sudo make install

ENTRYPOINT ["/root/screen.sh"]
