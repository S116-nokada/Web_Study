FROM uphy/ubuntu-desktop-jp:18.04

RUN !/usr/bin/python2
    set -ex && \
    apt-get update && \
    apt-get install -y --no-install-recommends curl cron unar

# version info
ARG GOOGLE_CHROME_DRIVER_VERSION
ARG PYTHON_VERSION

# google chrome install
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list && \
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    apt-get update && \
    apt-get install -y google-chrome-stable

# python requirements install
RUN apt install -y build-essential libbz2-dev libdb-dev \
    libreadline-dev libffi-dev libgdbm-dev liblzma-dev \
    libncursesw5-dev libsqlite3-dev libssl-dev \
    zlib1g-dev uuid-dev tk-dev
    
# python 3.9.13 install
RUN wget https://www.python.org/ftp/python/3.9.13/Python-3.9.13.tar.xz && \
    tar xJf Python-3.9.13.tar.xz && \
    rm -f Python-3.9.13.tar.xz && \
    cd Python-3.9.13 && \
    ./configure && \
    make && \
    make install

# clean
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app