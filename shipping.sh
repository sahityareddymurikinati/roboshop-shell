echo -e "\e[33mInstall Maven\e[0m"
yum install maven -y &>>/tmp/roboshop.log

echo -e "\e[33mAdd application user\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33mCreate application directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[33mDownload application content\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log

echo -e "\e[33mExtract application content\e[0m"
unzip /tmp/shipping.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log

echo -e "\e[33mDownload maven dependecies\e[0m"
mvn clean package &>>/tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar &>>/tmp/roboshop.log

echo -e "\e[33m Install mysql client\e[0m"
yum install mysql -y &>>/tmp/roboshop.log

echo -e "\e[33mLoad schema\e[0m"
mysql -h mysql-dev.sahityadevops.shop -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>/tmp/roboshop.log

echo -e "\e[33mSetup systemD file\e[0m"
cp /home/centos/roboshop-shell/shipping.service /etc/systemd/system/shipping.service &>>/tmp/roboshop.log

echo -e "\e[33mstart shipping service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable shipping &>>/tmp/roboshop.log
systemctl restart shipping &>>/tmp/roboshop.log