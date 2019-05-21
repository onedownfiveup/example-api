FROM ruby:2.5.5-alpine3.8
LABEL application=example-api

ENV APP_ROOT /app

RUN apk add --no-cache gcc git python3-dev libffi-dev musl-dev build-base
RUN pip3 install wheel -U

RUN apk update && apk add --no-cache python3 postgresql-dev bash curl jq
RUN pip3 install --upgrade pip
RUN pip3 --no-cache-dir install awscli
RUN gem install rdoc --no-document bundler

WORKDIR ${APP_ROOT}
COPY Gemfile Gemfile.lock ${APP_ROOT}/

RUN addgroup -g 1000 app && adduser -u 1000 -G app -D app
RUN chown -R app:app $APP_ROOT

RUN bundle config jobs 2
RUN bundle install

# Entrypoint script
COPY entrypoint.sh /usr/bin/entrypoint
RUN chmod +x /usr/bin/entrypoint

COPY --chown=app:app . ${APP_ROOT}/

USER app:app

ENTRYPOINT ["/usr/bin/entrypoint"]

