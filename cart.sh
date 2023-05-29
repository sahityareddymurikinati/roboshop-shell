echo -e "\e[33mConfiguring Node JS repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log
echo -e "\e[33m Install Nodejs\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[33madd application user\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33m remove existing and create new application directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app

echo -e "\e[33mdownload application content\e[0m"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[33mextract application content\e[0m"
unzip /tmp/cart.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[33mInstall NodeJs Dependecies\e[0m"
npm install &>>/tmp/roboshop.log

echo -e "\e[33mSetup systemd service\e[0m"
cp /home/centos/roboshop-shell/cart.service /etc/systemd/system/cart.service &>>/tmp/roboshop.log

echo -e "\e[33mStart cart service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable cart &>>/tmp/roboshop.log
systemctl restart cart &>>/tmp/roboshop.log