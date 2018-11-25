FROM debian:stretch
USER root
ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8
RUN apt-get update && apt-get install -y ruby make gcc g++ ruby-dev monitoring-plugins-basic default-libmysqlclient-dev curl nano
RUN mkdir -p /opt/theater/
WORKDIR /opt/theater/
ADD Gemfile /opt/theater/
ADD Gemfile.lock /opt/theater/
RUN gem install bundler --no-ri --no-rdoc
RUN bundle install --deployment
ADD . /opt/theater/
  ENV RACK_ENV production
  CMD ["/opt/theater/docker/scripts/api"]
