FROM ubuntu:18.04
RUN apt-get update && apt-get install -y git \
                                         gcc \
                                         python

ADD . /app

RUN git clone https://github.com/mpv-player/mpv.git /run_env
# RUN ./bootstrap.py

CMD /bin/bash
