FROM ruby:2.5.1-alpine3.7

MAINTAINER mdkrog@gmail.com

# Install apk based dependencies required to run Rails as
# well as RubyGems. As the Ruby image itself is based on a
# Alpine image, we use apk add to install those.
RUN apk add --update \
  build-base \
  && rm -rf /var/cache/apk/*

# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
RUN mkdir /app
WORKDIR /app

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN gem install bundler && bundle install

# Copy the main application.
ADD . /app