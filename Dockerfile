FROM ruby:2.5-alpine

RUN apk update && apk add build-base nodejs postgresql-dev tzdata less yarn

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install --binstubs
RUN yarn install

COPY . .

CMD puma -C config/puma.rb
