FROM ruby:2.3

ENV APPDIR /var/www/sistema_ventas/

RUN apt-get update \
  && apt-get install -y \
    build-essential \
    mysql-client \
    nodejs \
    vim \
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
