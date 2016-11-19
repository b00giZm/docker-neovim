FROM ubuntu:16.04

ENV TERM xterm-256color

ENV GOPATH /usr/share/go-projects
ENV PATH $PATH:$GOPATH/bin

RUN apt-get update \
    && apt-get upgrade -yq \
    && apt-get install -yq \
      curl \
      git \
      software-properties-common \
    && add-apt-repository ppa:neovim-ppa/unstable \
    && apt-get update \
    && apt-get install -yq \
      golang \
      nodejs \
      npm \
      python3-pip \
      neovim \
    && pip3 install --upgrade pip \ 
    && pip3 install neovim \
    && go get -v -u github.com/nsf/gocode \
      && gocode close \
      && gocode set unimported-packages true \
    && ln -s /usr/bin/nodejs /usr/local/bin/node \
    && npm install -g \
      tern \
    && apt-get autoremove \
    && apt-get clean

COPY root /root

WORKDIR /app

CMD ["nvim"]
