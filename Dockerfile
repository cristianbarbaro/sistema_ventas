FROM ruby:2.7

ENV APPDIR /var/www/sistema_ventas/

RUN apt-get update \
  && apt-get install -y \
    build-essential \
    default-mysql-client \
    nodejs \
  && rm -rf /var/lib/apt/lists/* \
  && useradd user \
  && mkdir -p $APPDIR

WORKDIR $APPDIR

COPY Gemfile Gemfile.lock $APPDIR

RUN gem install bundler && \
  bundle install

COPY . $APPDIR

RUN chown user:user -R $APPDIR

USER user

EXPOSE 3000
