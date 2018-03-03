FROM ruby:2.5.0

RUN apt-get update && apt-get install -qy netcat && apt-get clean

RUN mkdir -p /srv/vote
WORKDIR /srv/vote

ADD ["Gemfile.lock", "Gemfile", "/srv/vote/"]

RUN bundle install --deployment --without production test

# Add the rest of the working tree to /app/ (besides the stuff ignored by
# .dockerignore)
ADD . /srv/vote

ENTRYPOINT bin/docker-entrypoint.sh
