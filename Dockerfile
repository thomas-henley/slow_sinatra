FROM ruby:3.1 as base

WORKDIR /usr/src/app

EXPOSE 8080
EXPOSE 80

# Get dependencies
COPY ./Gemfile ./Gemfile
RUN bundle install

# Load the project into the container
COPY . .


### TEST STAGE
FROM base as test

CMD APP_ENV=test bundle exec ruby ./test/slow_sinatra_test.rb


### PRODUCTION STAGE
FROM base as production

CMD APP_ENV=production bundle exec ruby slow.rb
