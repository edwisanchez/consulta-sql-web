# Usar una imagen base compatible
FROM ubuntu:20.04

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    curl apt-transport-https gnupg unixodbc unixodbc-dev \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql18 \
    && apt-get clean

# Instalar Python y dependencias
RUN apt-get install -y python3 python3-pip
WORKDIR /app
COPY . /app
RUN pip3 install -r requirements.txt

# Exponer el puerto 8080
EXPOSE 8080

# Ejecutar la aplicación
CMD ["gunicorn", "-b", "0.0.0.0:8080", "app:app"]
