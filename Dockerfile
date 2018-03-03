FROM ruby:2.5.0

RUN apt-get update && apt-get install -qy netcat && apt-get clean

RUN mkdir -p /srv/vote
WORKDIR /srv/vote
