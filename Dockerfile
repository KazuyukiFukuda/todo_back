FROM ruby:3.1.0

WORKDIR /ToDoapp_rails

RUN apt-get update -qq && apt-get install -y \
        nodejs \
        postgresql-client \
        git \
        yarn \
        default-mysql-client

RUN echo "gem: --no-document" >> ~/.gemrc
RUN gem install rails -v 7.0.0
RUN gem install bundler -v 2.2.17
#RUN bundle install
