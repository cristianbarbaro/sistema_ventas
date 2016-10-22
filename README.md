### Pasos iniciales

* Instalación de Ruby (usando *rbenv*) y otras dependencias:

```
$ sudo apt-get install -y autoconf bison build-essential lib{ssl,yaml,sqlite3}-dev libreadline6{,-dev} zlib1g{,-dev}
$ sudo apt-get install nodejs git mysql-server libmysqlclient-dev
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

* Una vez dentro de la carpeta de la aplicación, editar el archivo .ruby-env con los valores que correspondan y actualizar las variables de entorno

```
$ cp .rbenv-vars.example .rbenv-vars
$ rails secret
$ rbenv vars
```

### Despliegue para producción usando Nginx como proxy

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

Cambiar el nombre `apps` en `setuid` y `setgid` por el nombre del usuario del sistema del archivo `puma.conf`.

* Copiar el script en el directorio de los servicios de Upstart. Esto permitirá que Puma inicie con el sistema.

```
sudo cp puma.conf puma-manager.conf /etc/init
```

* Configurar `/etc/puma.conf` con los directorios de las aplicaciones que se desean ejecutar en el sistema.

```
/var/www/sistema_ventas/
```

* Iniciar Puma.
```
sudo start puma-manager
```

* Copiar el contenido del archivo config/nginx.conf en las configuraciones del servidor:

```
sudo cp config/nginx.conf /etc/nginx/sites-available/default
```

Cuidado, si hay otras aplicaciones siendo ejecutadas en el sistema, el comando anterior sobreescribirá las configuraciones.

* Reiniciar Nginx y acceder a la ip del servidor:

```
sudo service nginx restart
```


This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
 ```
2.3.0
```

* System dependencies
gem install bundle
gem install rails

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
