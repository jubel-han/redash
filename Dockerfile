FROM ubuntu:xenial

EXPOSE 5000

RUN useradd --create-home redash

# Ubuntu packages
RUN apt-get update && apt-get install -y curl && curl https://deb.nodesource.com/setup_6.x | bash - && \
  apt-get install -y python-pip python-dev build-essential pwgen libffi-dev sudo git-core wget \
  nodejs \
  # Postgres client
  libpq-dev \
  # for SAML
  xmlsec1 \
  # Additional packages required for data sources:
  libssl-dev libmysqlclient-dev freetds-dev libsasl2-dev && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements_dev.txt requirements_all_ds.txt ./

RUN pip install -U setuptools==23.1.0 && \
    pip install -r requirements.txt -r requirements_dev.txt -r requirements_all_ds.txt

WORKDIR /app
