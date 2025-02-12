#!/bin/bash

# Instalar el driver ODBC 17 para SQL Server en Linux (Debian/Ubuntu)
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo add-apt-repository "$(curl -s https://packages.microsoft.com/config/ubuntu/20.04/prod.list)"
sudo apt-get update
sudo apt-get install -y --no-install-recommends \
    unixodbc \
    unixodbc-dev \
    odbcinst \
    msodbcsql17

# Instalar dependencias de Python
pip install -r requirements.txt
