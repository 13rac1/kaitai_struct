FROM openjdk:8-jdk-stretch

RUN echo "deb http://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list \
 && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823 \
 && apt-get update \
 && apt-get -y install \
    gcc \
    ruby \
    sbt

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
