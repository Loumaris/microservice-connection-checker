# Dockerfile
FROM ruby:3.0

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

# Set the working directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock
COPY Gemfile* ./

# Install the gems
RUN bundle install

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 4567

# Command to run the Sinatra app
CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4567"]
