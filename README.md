### Pasos iniciales

* Instalación de Ruby (usando *rbenv*) y otras dependencias (usaremos la versión `2.3.0` de Ruby y Ubuntu 14.04):

```
$ sudo apt-get install -y autoconf bison build-essential lib{ssl,yaml,sqlite3}-dev libreadline6{,-dev} zlib1g{,-dev}
$ sudo apt-get install nodejs git mysql-server libmysqlclient-dev sendmail
$ git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
$ git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
$ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
$ echo 'eval "$(rbenv init -)"' >> ~/.bashrc
$ source ~/.bashrc
$ rbenv install 2.3.0
$ rbenv global 2.3.0
```

* Si desea evitar instalación de documentación junto a las gemas, ejecutar:

```
$ echo "gem: --no-document" > ~/.gemrc
```

* Clonar este repositorio e instalar el resto de dependencias para que la aplicación funcione. (Asumimos que se instala en el directorio `/var/www/` y este último tiene como owner al usuario del sistema).

```
$ cd /var/www/
$ git clone https://github.com/cristianbarbaro/sistema_ventas.git
$ cd sistema_ventas
$ gem install bundler
$ bundle install
```

* Una vez dentro de la carpeta de la aplicación, editar el archivo .env con los valores que correspondan y configurar las variables de entorno.

```
$ cp .env-example .env
$ rails secret
```

### Ejecución en modo de desarrollo (saltar a la siguiente sección para despliegue en producción)

* Colocarse en la carpeta del proyecto.
* Cambiar al branch de desarrollo.

```
$ cd sistema_ventas
$ git checkout develop
```

* Crear, configurar y cargar datos de pruebas en la base de datos.

```
$ rake db:reset
```

* Ejecutar el servidor.

```
$ rails s -b 0.0.0.0
```

* Acceder a http://localhost:3000.


### Despliegue para producción usando Nginx como proxy

* En este branch, deben ejecutarse algunos pasos extras:

* Configurar el archivo `puma.rb` para correr en producción (en el branch `production` ya está configurado automáticamente).

```
cp config/puma-prod.rb config/puma.rb
```

* Es necesario configurar los parámetros en el archivo `.env` para poder usar las API de Google y Facebook.

* Instalar Nginx

```
$ sudo apt-get install nginx
```

* Configurar la base de datos

```
$ RAILS_ENV=production rake db:create
$ RAILS_ENV=production rake db:migrate
$ RAILS_ENV=production rake assets:precompile
```

* El archivo `config/puma.rb` ya tiene las configuraciones básicas para funcionar correctamente. Crear carpetas para Puma y descargar archivos necesarios para configurar

```
mkdir -p shared/pids shared/sockets shared/log
cd ~
wget https://raw.githubusercontent.com/puma/puma/master/tools/jungle/upstart/puma-manager.conf
wget https://raw.githubusercontent.com/puma/puma/master/tools/jungle/upstart/puma.conf
```

Cambiar el nombre `apps` en `setuid` y `setgid` en el archivo `puma.conf` por el nombre del usuario del sistema que desplegará la aplicación.

* Copiar el script en el directorio de los servicios de Upstart. Esto permitirá que Puma inicie con el sistema.

```
sudo cp puma.conf puma-manager.conf /etc/init
```

* Configurar `/etc/puma.conf` (si no existe, crearlo) con los directorios de las aplicaciones que se desean ejecutar en el sistema. En nuestro caso, nos quedará así:

```
/var/www/sistema_ventas/
```

* Iniciar Puma. (En Ubuntu 16.04 se requiere la instalación de `upstart`)
```
sudo start puma-manager
```

* Copiar el contenido del archivo config/nginx.conf en las configuraciones del servidor:

```
cd /var/www/sistema_ventas/
sudo cp config/nginx.conf /etc/nginx/sites-available/default
```

Cuidado, si hay otras aplicaciones siendo ejecutadas en el sistema, el comando anterior sobreescribirá las configuraciones.

* Reiniciar Nginx y acceder a la ip del servidor:

```
sudo service nginx restart
```


### Corriendo los tests

En nuestra aplicación hay varios _tests_ implementados, no todos, de controladores y modelos usando el módulo `MiniTest`. Acá veremos cómo ejecutarlos.

* Para correr todos los tests, basta con el siguiente comando:

```
$ rails test
```

* Para correr los tests relacionados con los modelos:

```
$ rails test test/models
```

* Para correr los tests relacionados con los controladores:

```
$ rails test test/controllers
```
