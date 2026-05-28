FROM debian:latest

ENV DEBIAN_FRONTEND=noninteractive

# jhalfs deps
RUN apt update && apt install -y --no-install-recommends \
    ca-certificates \
    sudo \
    git \
    wget \
    xsltproc \
    libxml2-utils \
    docbook-xml \
    docbook-xsl-ns \
    docbook-xsl \
    fdisk \
    e2fsprogs \
    python3 \
    vim

# lfs deps
RUN apt update && apt install -y \
    coreutils \
    binutils \
    binutils-dev \
    build-essential \
    bison \
    gawk \
    texinfo \
    flex \
    libncurses-dev \
    libncurses6

ARG USERNAME

# Non-root user with passwordless sudo
RUN useradd --create-home --shell /bin/bash $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME


USER $(USERNAME)
WORKDIR /host

CMD ["/bin/bash", "/host/scripts/startup.sh"]
