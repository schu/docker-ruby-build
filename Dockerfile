
FROM ubuntu:12.04

RUN apt-get update && \
  apt-get install -y -q --no-install-recommends \
  autoconf \
  bison \
  build-essential \
  libssl-dev \
  libyaml-dev \
  libreadline6-dev \
  zlib1g-dev \
  libncurses5-dev \
  libffi-dev \
  libgdbm3 \
  libgdbm-dev \
  ca-certificates \
  curl \
  git \
  ruby1.9.1 ruby1.9.1-dev rubygems1.9.1 \
  irb1.9.1 ri1.9.1 rdoc1.9.1 \
  libopenssl-ruby1.9.1

RUN update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.1 400 \
  --slave   /usr/share/man/man1/ruby.1.gz ruby.1.gz \
    /usr/share/man/man1/ruby1.9.1.1.gz \
  --slave   /usr/bin/ri ri /usr/bin/ri1.9.1 \
  --slave   /usr/bin/irb irb /usr/bin/irb1.9.1 \
  --slave   /usr/bin/rdoc rdoc /usr/bin/rdoc1.9.1

RUN update-alternatives --config ruby
RUN update-alternatives --config gem

RUN git clone https://github.com/sstephenson/ruby-build.git && \
  cd ruby-build && bash install.sh

ENV RUBY_CONFIGURE_OPTS --enable-load-relative --disable-install-doc

ENTRYPOINT ["ruby-build"]
