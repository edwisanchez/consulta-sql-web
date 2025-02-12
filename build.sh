#!/bin/bash

# Descargar e instalar el driver ODBC 17 para SQL Server
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo apt update
sudo apt install -y --no-install-recommends \
    unixodbc unixodbc-dev odbcinst odbcinst1debian2 libodbc1 \
    msodbcsql17 

# Verifica que el driver esté instalado
odbcinst -q -d

# Instala las dependencias de Python
pip install -r requirements.txt
