# FROM ruby:2.5

# RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

FROM ruby:2.5-alpine

RUN apk update && apk add build-base nodejs postgresql-dev

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install --binstubs

COPY . .

LABEL maintainer="Able Sense <support@ablesense.com>"

CMD puma -C config/puma.rb
