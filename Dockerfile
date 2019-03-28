FROM ubuntu:18.04

RUN apt-get update \
 && apt-get -y install \
    gnupg \
    ca-certificates \
 && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 \
    --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823 \
 && echo "deb http://dl.bintray.com/sbt/debian /" \
    > /etc/apt/sources.list.d/sbt.list \
 && apt-get update \
 && apt-get -y install \
    gcc \
    libboost-test-dev \
    valgrind \
    cmake \
    libtest-class-perl \
    libtest-deep-perl \
    libxml-simple-perl \
    libmodule-build-perl \
    lua5.3 \
    openjdk-8-jdk \
    python-pip \
    python3-pip \
    ruby \
    sbt \
    wget \
    zlib1g-dev

# Go
ARG GO_VERSION=1.12.1.linux-amd64
ENV GOPATH="${HOME}/go"
ENV PATH="${PATH}:/usr/local/go/bin:$GOPATH/bin"
RUN wget -nv https://dl.google.com/go/go$GO_VERSION.tar.gz \
 && tar -C /usr/local -xzf go$GO_VERSION.tar.gz \
 && rm go$GO_VERSION.tar.gz \
 && go version \
 && go get github.com/stretchr/testify/assert \
 && go get golang.org/x/text \
 && go get github.com/jstemmer/go-junit-report

# Python 2/3 & Ruby
RUN pip install --user enum34 \
 && pip install --user unittest-xml-reporting \
 && pip install --user construct \
 && pip3 install --user unittest-xml-reporting \
 && pip3 install --user construct \
 && gem install rspec

# Java
RUN mkdir -p \
    "$HOME/.m2/repository/org/testng/testng/6.9.10" \
    "$HOME/.m2/repository/com/beust/jcommander/1.48" \
 && wget -O "$HOME/.m2/repository/org/testng/testng/6.9.10/testng-6.9.10.jar" \
    http://jcenter.bintray.com/org/testng/testng/6.9.10/testng-6.9.10.jar \
 && wget -O "$HOME/.m2/repository/com/beust/jcommander/1.48/jcommander-1.48.jar" \
    http://jcenter.bintray.com/com/beust/jcommander/1.48/jcommander-1.48.jar

# Perl & Lua
RUN (echo y; echo o conf prerequisites_policy follow; echo o conf commit) | cpan \
 && cpan install TAP::Harness::JUnit \
 && wget https://raw.githubusercontent.com/bluebird75/luaunit/master/luaunit.lua \
 && mkdir -p /usr/local/lib/lua/5.3/ \
 && mv luaunit.lua /usr/local/lib/lua/5.3/
