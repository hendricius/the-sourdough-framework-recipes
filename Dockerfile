FROM debian:trixie

LABEL "maintainer"="Hendrik Kleinwächter <hendrik.kleinwaechter@gmail.com>"
LABEL "repository"="https://github.com/hendricius/the-sourdough-framework-recipes"
LABEL "homepage"="https://github.com/hendricius/the-sourdough-framework-recipes"
LABEL org.opencontainers.image.source="https://github.com/hendricius/the-sourdough-framework-recipes"

# Print release information if needed
RUN cat /etc/*release*

# Install base depdendencies
RUN apt-get update && \
    apt-get install --yes -y --no-install-recommends \
    sudo \
    make \
    tidy \
    pandoc \
    zip \
    git \
    wget \
    imagemagick \
    rsync \
    wget \
    perl \
    xzdec \
    # dvisvgm dependencies
    build-essential \
    fonts-texgyre \
    fontconfig \
    libfontconfig1 \
    libkpathsea-dev \
    libptexenc-dev \
    libsynctex-dev \
    libx11-dev \
    libxmu-dev \
    libxaw7-dev \
    libxt-dev \
    libxft-dev \
    libwoff-dev

# Install TeX
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    texlive-full \
    texlive-luatex

# Compile latest dvisvgm
RUN wget https://github.com/mgieseki/dvisvgm/releases/download/3.1.2/dvisvgm-3.1.2.tar.gz && \
    mv dvisvgm-3.1.2.tar.gz dvisvgm.tar.gz && \
    tar -xzf dvisvgm.tar.gz && \
    cd dvisvgm-* && \
    ./configure && \
    make && \
    make install

# Make sure everything is UTF-8
RUN echo "export LC_ALL=en_US.UTF-8" >> /root/.bashrc && \
    echo "export LANG=en_US.UTF-8" >> /root/.bashrc

WORKDIR /root

CMD ["/bin/bash"]
