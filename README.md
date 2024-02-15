# Prueba PHP + JS

Docker con: Apache, PHP, MySQL

El conjunto de imágenes crea un contenedor que ejecuta: Apache (servidor web), MySQL y PHP.

Para validar que el contenedor esté corriendo, puedes acceder a http://127.0.0.1 or http://localhost, lo cual debería mostrar la página index.html

## Pre requisitos
- Instalar y ejecutar Docker Desktop
  - [https://www.docker.com/get-started ](https://www.docker.com/get-started)

## Ejecutar las imágenes de Docker
En la línea de comandos (terminal)
- Descarga este repositorio en cualquier directorio / carpeta.
  - `git clone https://github.com/osegura01/api_test.git`
- Entra al directorio.
  - `cd api_test`
- Crea un directorio llamado `dbdata`, ahí se almacenará la información de la base de datos.
  - `mkdir dbdata`
- Si lo prefieres cambia la información de la cuenta de MySQL en `docker-compose.yml`.
 
```
  MYSQL_ROOT_PASSWORD: "ro07P4s5w0rD"
  MYSQL_DATABASE: "db_api"
  MYSQL_USER: "usr_api"
  MYSQL_PASSWORD: "4pI_p45s"
```

- Inicia el contenedor
  - `docker compose up`
  - O correlo en background para poder utilizar la terminal.
    - `docker compose up -d`
- Para detener los contenedores
  - Presiona ctrl-c
  - Después ejecuta `docker compose down`
- Visita la página en [http://localhost ](http://localhost)
  - También puedes editar el archivo /etc/hosts para utilizar un nombre de dominio. Por ejemplo, agrega lo siguiente a tu archivo /etc/hosts:
    - `127.0.0.1 example.com`
    - ¿Cómo modificar tu archivo /etc/hosts?:
      - ([Linux or Mac](https://www.makeuseof.com/tag/modify-manage-hosts-file-linux/)), 
      - o c:\windows\system32\drivers\etc\hosts ([Windows](https://www.howtogeek.com/howto/27350/beginner-geek-how-to-edit-your-hosts-file/)).

    - Ahora podrías acceder a través de [http://example.com ](http://example.com).

## Conectarse a la base de datos
- Conectate a la base de datos MySQL con las siguientes credenciales:

  ```
    $server = 'mysql';
    $dbname = 'db_api';
    $username = 'usr_api';
    $password = '4pI_p45s';
    $dsn = "mysql:host=$server;dbname=$dbname";

  ```
  - La URL del server/host/database es `mysql` porque es el nombre del contenedor de Docker. Esto debido a que tanto PHP, Apache y Mysql son contenedores, y pueden conectarse entre ellos através de su nombre en la red.

## Notas generales
- Se ejecutarán 2 contenedores: uno con PHP-Apache y otro con MySQL.
- Todos los archivos del sitio web van en el directorio `www`.
- Los archivos de la base de datos son almacenados en el directorio `dbdata`. Esto permite que la información sea persistente cuando se reinicie el contenedor.
  - Para reiniciar con una base de datos nueva, solamente elimina el contenido del directorio `dbdata`.

### Extensiones PHP
Para agregar más extensiones PHP, agrega el paquete a instalar en la lista de paquetes después de la línea 'apt-get install' (agrégalos en orden alfabético).
```
FROM php:7-apache

RUN apt-get update && apt-get install -y \
  imagemagick \
  libfreetype6-dev \
  libjpeg62-turbo-dev \
  libmagickwand-dev --no-install-recommends \
  libpng-dev \
  && rm -rf /var/lib/apt/lists/* \
  && a2enmod rewrite \
  --> Agrega nuevas extensiones PHP debajo de ésta línea (borra ésta línea)
  && docker-php-ext-install exif \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && docker-php-ext-install -j$(nproc) gd \
  && pecl install imagick && docker-php-ext-enable imagick \
  && docker-php-ext-install mysqli \
  && docker-php-ext-install pdo pdo_mysql

```

### Configuración PHP
Por defecto el tamaño máximo para subir archivos y el límite de las peticiones POST están configurados a 256MB. Si nececitas cambiar esos valores, edita el archivo `uploads.ini`.


## Apache
Apache está integrado con PHP en la imagen y se debería evitar modificarlo. Para instalar o habilitar módulos, agrega una línea después de la lista de paquetes en el Dockerfile.

```
FROM php:7-apache

RUN apt-get update && apt-get install -y \
  imagemagick \
  libfreetype6-dev \
  libjpeg62-turbo-dev \
  libmagickwand-dev --no-install-recommends \
  libpng-dev \
  && rm -rf /var/lib/apt/lists/* \
  --> Agrega un nuevo módulo debajo de ésta línea (borra ésta línea)
  && a2enmod rewrite \
  && docker-php-ext-install exif \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && docker-php-ext-install -j$(nproc) gd \
  && pecl install imagick && docker-php-ext-enable imagick \
  && docker-php-ext-install mysqli \
  && docker-php-ext-install pdo pdo_mysql

```

## MySQL
Cambia la imagen en docker-compose.yml. Para utilizar MySQL 5.6 usa `image:
"mysql:5.6"` en la sección de mysql (en la línea 15). Para otras versiones, visita la página oficial de DockerHub [https://hub.docker.com/_/mysql ](https://hub.docker.com/_/mysql).

## Software adicional
Puedes agregar software adiconal en el Dockerfile. Agrega paquetes a la lista después de la línea 'apt-get install' (agrégalos en orden alfabético).

```
FROM php:7-apache

RUN apt-get update && apt-get install -y \
  imagemagick \
  libfreetype6-dev \
  libjpeg62-turbo-dev \
  libmagickwand-dev --no-install-recommends \
  libpng-dev \
  --> Agrega nuevo software debajo de ésta línea (borra ésta línea)
  && rm -rf /var/lib/apt/lists/* \
  && a2enmod rewrite \
  && docker-php-ext-install exif \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && docker-php-ext-install -j$(nproc) gd \
  && pecl install imagick && docker-php-ext-enable imagick \
  && docker-php-ext-install mysqli \
  && docker-php-ext-install pdo pdo_mysql

```
