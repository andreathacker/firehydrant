FROM ruby:3.3.6
WORKDIR /app

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the application code
COPY . .

CMD ["rails", "server", "-b", "0.0.0.0"]