# Use the official Ruby image as the base image
FROM ruby:3.2.2

# Set the working directory inside the container
WORKDIR /app

# Install essential packages
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Install Yarn
RUN curl -o- -L https://yarnpkg.com/install.sh | bash
ENV PATH=/root/.yarn/bin:$PATH

# Install the Rails gem
RUN gem install rails -v '7.0.6'

# Copy the Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# Install project dependencies
RUN bundle install

# Copy the rest of the application code to the container
# COPY bin/entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
# EXPOSE 3000

# Expose port 3000 for the Rails application
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
