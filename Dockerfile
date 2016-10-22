FROM ruby:2.3
RUN apt-get update && apt-get install -y build-essential nodejs mysql-client vim

ENV APPDIR /var/www/sistema_ventas/

RUN mkdir -p $APPDIR

WORKDIR $APPDIR
COPY Gemfile $APPDIR
COPY Gemfile.lock $APPDIR
RUN bundle install

COPY . $APPDIR

VOLUME $APPDIR

EXPOSE 3000
