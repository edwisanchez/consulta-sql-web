#!/bin/bash
# Actualizar los paquetes e instalar las dependencias necesarias
apt-get update && apt-get install -y curl apt-transport-https gnupg

# Importar la clave GPG de Microsoft
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

# Registrar el repositorio de Microsoft
curl https://packages.microsoft.com/config/debian/$(lsb_release -rs)/prod.list > /etc/apt/sources.list.d/mssql-release.list

# Actualizar los paquetes e instalar el controlador ODBC 18 para SQL Server
apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql18

# Limpiar la caché de apt para reducir el tamaño de la imagen
apt-get clean
