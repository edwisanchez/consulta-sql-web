#!/usr/bin/env bash
apt-get update && apt-get install -y \
    unixodbc \
    unixodbc-dev \
    freetds-bin \
    freetds-dev \
    tdsodbc
