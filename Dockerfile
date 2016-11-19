FROM ubuntu:16.04

RUN apt-get update \
	&& apt-get upgrade -yq \
	&& apt-get install -yq \
		curl \
		git \
		software-properties-common \
	&& add-apt-repository ppa:neovim-ppa/unstable \
	&& apt-get update \
	&& apt-get install \
		neovim \
	&& apt-get autoremove \
    && apt-get clean

ENV TERM xterm-256color

COPY root /root

WORKDIR /app

CMD ["nvim"]
