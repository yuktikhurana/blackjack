FROM ruby:2.3.1
RUN apt-get update && apt-get install -qq -y build-essential nodejs libpq-dev
RUN mkdir -p /app
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install
COPY . ./
EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
