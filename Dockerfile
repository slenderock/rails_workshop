FROM ruby:2.7.0

RUN apt-get update && apt-get install -qq -y build-essential git nodejs libpq-dev cmake libgit2-dev pkg-config nano htop wget tar

RUN mkdir /app
WORKDIR /app

RUN gem install bundler --no-document
RUN bundle config git.allow_insecure true
COPY Gemfile ./
COPY Gemfile.lock ./

RUN bundle check || bundle install

ENTRYPOINT ["bundle", "exec"]
