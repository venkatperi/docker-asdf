FROM debian:latest

RUN apt-get update -qq && \
    apt-get upgrade -qq -y && \
    apt-get install -qq -y \
            build-essential \
            autoconf \
            libncurses5-dev \
            libssh-dev \
            unixodbc-dev \
            git \
            curl \
            unzip \
            sudo \ 
            inotify-tools && \
    apt-get clean -qq -y && \
    apt-get autoclean -qq -y && \
    apt-get autoremove -qq -y && \
    rm -rf /var/cache/debconf/*-old && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/share/doc/*

ENV LANG C.UTF-8

RUN useradd -ms $(which bash) asdf && \
    adduser asdf sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers


ENV PATH /home/asdf/.asdf/bin:/home/asdf/.asdf/shims:$PATH
USER asdf

COPY asdf-install-plugins /bin/asdf-install-plugins
COPY asdf-install-versions /bin/asdf-install-versions

WORKDIR /home/asdf

RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf
RUN echo -e '\nsource $HOME/.asdf/asdf.sh' >> ~/.profile

CMD ["bash"]
