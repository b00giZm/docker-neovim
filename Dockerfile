FROM alpine:3.4

ENV TERM xterm-256color

ENV GOPATH /usr/share/go-projects
ENV PATH $PATH:$GOPATH/bin

ENV CMAKE_EXTRA_FLAGS=-DENABLE_JEMALLOC=OFF

# Install
RUN echo "http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
	&& echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk update \
	&& apk upgrade \
	&& apk add --update-cache --virtual build-deps --no-cache \
		autoconf \
		automake \
		cmake \
		g++ \
		libtool \
		libtermkey-dev \
		lua5.3-dev \
		python3-dev \
        ruby-dev \
		unzip \
    && apk add --update-cache \
    	ack \
    	curl \
    	git \
    	go \
    	libtermkey \
    	make \
    	nodejs \
    	php5 \
    	php5-json \
    	php5-phar \
    	php5-openssl \
		python3 \
		ruby \
        ruby-rake \
		unibilium \
    && git clone --depth=1 https://github.com/neovim/libvterm.git \
    	&& cd libvterm \
    	&& make \
    	&& make install \
    	&& cd .. \
    	&& rm -rf libvterm \
    && git clone --depth=1 https://github.com/neovim/neovim.git nvim \
    	&& cd nvim \
    	&& make \
    	&& make install \
    	&& cd .. \
    	&& rm -rf nvim \
    && pip3 install --upgrade pip \
	&& pip3 install \
    	jedi \
      	neovim \
    && gem install --no-ri --no-rdoc \
      	neovim \
    && go get -v -u github.com/nsf/gocode \
      	&& gocode close \
      	&& gocode set unimported-packages true \
    && npm install -g \
      	tern \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer \
    	&& composer global require mkusher/padawan \
    && rm -rf /var/cache/apk/* \
    && rm -rf ~/.cache/pip \
    && gem cleanup

WORKDIR /app

CMD ["nvim"]
