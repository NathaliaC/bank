FROM ruby:2.6.2
  
RUN apt-get update && apt-get install -qq -y --no-install-recommends \
    build-essential libpq-dev git-all nano vim
 

ENV INSTALL_PATH /bank
 
RUN mkdir -p $INSTALL_PATH
 
WORKDIR $INSTALL_PATH

ENV BUNDLE_PATH /gems

COPY . .