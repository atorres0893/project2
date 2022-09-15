#!/bin/bash

sudo apt-get update

sudo apt-get upgrade -y

sudo apt-get install apache2 apache2-utils -y

systemctl enable apache2

systemctl start apache2

sudo apt-get install mysql-client mysql-server -y

sudo apt-get install php libapache2-mod-php php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip -y

systemctl restart apache2



cat > /var/www/html/info.php << EOF

<?php

phpinfo();

?>

EOF



wget https://wordpress.org/latest.tar.gz

tar -xzvf latest.tar.gz

cp -r wordpress/* /var/www/html/

chown -R www-data:www-data /var/www/html/

chmod -R 755 /var/www/html/

systemctl restart apache2

rm -rf wordpress



mysql -h team4proj2s1.mysql.database.azure.com -u adminuser --password='Password123456' << EOF

create database wordpress;

grant all privileges on wordpress.* to 'adminuser'@'%';

flush privileges;

exit

EOF



cd /var/www/html/

sudo mv wp-config-sample.php wp-config.php

sudo rm -rf index.html



sed -i 's/database_name_here/team4proj2s2/g' wp-config.php

sed -i 's/username_here/adminuser/g' wp-config.php

sed -i 's/password_here/Password123456/g' wp-config.php

sed -i 's/localhost/team4proj2s2.mysql.database.azure.com/g' wp-config.php



systemctl restart apache2

systemctl restart mysql




