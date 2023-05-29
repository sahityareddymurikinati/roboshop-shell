echo -e "\e[33mdisable current version of sql\e[0m"
yum module disable mysql -y &>>/tmp/roboshop.log

echo -e "\e[33mCop mysql repo file\e[0m"
cp /home/centos/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo

echo -e "\e[33mInstalling mysql\e[0m"
yum install mysql-community-server -y &>>/tmp/roboshop.log

echo -e "\e[33m start sql service\e[0m"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl restart mysqld &>>/tmp/roboshop.log

echo -e "\e[33mset up password\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/roboshop.log