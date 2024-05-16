FROM ruby:3.0.4 AS build

RUN apt-get update && apt-get install -y \
  redis \
  iputils-ping

FROM build AS config

WORKDIR /app

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install
COPY . .
RUN chmod +x run.sh

FROM config AS ready

CMD ["./run.sh"]
