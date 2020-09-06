#!/bin/bash

echo -e "Назва проекту";
read NAME_OF_PROJECT
cat /etc/hosts
echo -e "IP"
read IP
# Перед запуском необходимо тут указать пароль root для базы MySQL. Не путайте это с паролем админа который вы вводите при команде sudo
PSWD_SQL="root13"

#создаем папки проекта
mkdir /srv/http/$NAME_OF_PROJECT
#sudo chown -R mark:mark /home/www/$NAME_OF_PROJECT/

#указываем владельца и права на папку "public"
#sudo chmod -R 777 /var/www/$NAME_OF_PROJECT/

#echo "Поздравляем Ваш сайт работает $NAME_OF_PROJECT" >> /var/www/$NAME_OF_PROJECT

#добавляем правила в конфигурационый файл апача
add_to_apache_conf="
<VirtualHost *:80>
ServerName ${NAME_OF_PROJECT}
DocumentRoot "/srv/http/${NAME_OF_PROJECT}"

   <Directory "/srv/http/${NAME_OFPROJECT}">
      Allow from All
      AllowOverride All
      Require all granted
      Options Indexes FollowSymLinks
      Order allow,deny
   </Directory>
</VirtualHost>"

add_to_hosts_conf="127.0.0.${IP} ${NAME_OF_PROJECT}"

#добовляем новый хост
sudo sh -c "echo '$add_to_hosts_conf' >> /etc/hosts" 
sudo sh -c "touch /etc/httpd/conf/vhosts/${NAME_OF_PROJECT}"
sudo sh -c "echo '$add_to_apache_conf' >> /etc/httpd/conf/vhosts/${NAME_OF_PROJECT}"
sudo sh -c "echo 'Include conf/vhosts/${NAME_OF_PROJECT}' >> /etc/httpd/conf/httpd.conf"

#включаем конфигурацию сайта
#sudo a2ensite ${NAME_OF_PROJECT}
#sudo a2dissite
echo "** Сайт у каталозі: /srv/http/${NAME_OF_PROJECT} "
#создаем новую базу
echo -e "Створити базу (yes/no)";
read CREATE_BAZA

if  [ "$CREATE_BAZA" = "yes" -o "$CREATE_BAZA" = "y" -o "&CREATE_BAZA" = "YES" ]; then
echo -e "Ім*я бази даних";
read NAME_OF_PROJECT
#echo -e "33[1mВВедите пароль для нового пользователя ${NAME_OF_PROJECT}_user который будет обладать всем правами на вновь созданную базу:33[0m";
#read PASSWORD_OF_MYSQL


# Создаем базу данных имя которой мы ввели
mysql -uroot -p${PSWD_SQL} --execute="create database ${NAME_OF_PROJECT};"
# Создаем нового пользователя
#mysql -uroot -p${PSWD_SQL} --execute="GRANT ALL PRIVILEGES ON ${NAME_OF_PROJECT}.* TO ${NAME_OF_PROJECT}_user@localhost IDENTIFIED by '${PASSWORD_OF_MYSQL}'  WITH GRANT OPTION;"
                                       
echo -e "База даних ${NAME_OF_PROJECT} створена";
else
echo -e "База даних не створена";
fi

echo "Перезапускаємо apache..."
#перезапускаем апач
sudo systemctl restart httpd
 #/etc/init.d/apache2 restart
echo -e "сайт готовий";

