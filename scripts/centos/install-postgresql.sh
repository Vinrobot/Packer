#!/bin/sh

# https://www.postgresql.org/download/linux/redhat/

POSTGRESQL_VERSION="${POSTGRESQL_VERSION:-14}"

RH_ARCH="${RH_ARCH:-x86_64}"
RH_VERSION="${RH_VERSION:-EL-8}"

# Install the repository RPM:
dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/${RH_VERSION}-${RH_ARCH}/pgdg-redhat-repo-latest.noarch.rpm

# Disable the built-in PostgreSQL module:
dnf -qy module disable postgresql

# Install PostgreSQL:
dnf install -y postgresql${POSTGRESQL_VERSION}-server

# Optionally initialize the database and enable automatic start:
/usr/pgsql-${POSTGRESQL_VERSION}/bin/postgresql-${POSTGRESQL_VERSION}-setup initdb
systemctl enable postgresql-${POSTGRESQL_VERSION}
systemctl start postgresql-${POSTGRESQL_VERSION}

# Install PostgreSQL database adapter for Python 3
dnf install -y python3-psycopg2
