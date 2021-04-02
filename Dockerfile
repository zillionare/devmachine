FROM ubuntu:focal
MAINTAINER Aaron_Yang

ENV PYPI_INDEX_URL=https://pypi.org/simple
ARG DEBIAN_FRONTEND=noninteractive
WORKDIR /
COPY rootfs ./

RUN apt-get update \
        && apt-get install -qq --no-install-recommends -y openssh-server wget redis-server postgresql-12 git \
        && apt-get install -qq --no-install-recommends -y python3.8 python3-pip build-essential python3.8-dev vim iputils-ping\
        && mkdir /var/run/sshd \
        && (echo 'root:root' | chpasswd) \
	&& chmod 700 /root/.ssh \
        && pip3 config set global.index-url $PYPI_INDEX_URL \
        && wget --no-check-certificate https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh \
        && bash /tmp/miniconda.sh -b -p /conda \
        && /conda/bin/conda init \
	&& (echo "PermitRootLogin yes" >> /etc/ssh/sshd_config) \
        && (echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/12/pg_hba.conf) \
        && (echo "listen_address='*'" >> /etc/postgresql/12/pg_hba.conf) \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

expose 22
expose 5432
expose 6379

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD "bin/bash"
