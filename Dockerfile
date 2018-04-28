FROM ruby:alpine

ENV RAILS_ENV production

RUN apk add --no-cache git openssh g++ musl-dev make bash sqlite-dev nodejs nodejs-npm tzdata

WORKDIR /root

COPY app /root/app
COPY bin /root/bin
COPY config /root/config
COPY db /root/db
COPY lib /root/lib
COPY public /root/public
COPY vendor /root/vendor
COPY Gemfile /root
COPY Gemfile.lock /root
COPY package.json /root
COPY Rakefile /root
COPY config.ru /root

RUN bundle install --without=development

EXPOSE 8000

CMD ["bundle", "exec", "rails", "s"]
