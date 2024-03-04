FROM ruby:3.2.3

RUN apt-get update -qq && \
    apt-get install -y build-essential \
    less \
    vim \
    libpq-dev \
    nodejs

WORKDIR /app
ENV LANG=ja_JP.UTF-8
ENV TZ=Asia/Tokyo
ENV RUBYOPT=-EUTF-8
