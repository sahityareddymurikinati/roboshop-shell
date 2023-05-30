echo -e "\e[33mInstall golang\e[0m"
yum install golang -y &>>/tmp/roboshop.log

echo -e "\e[33madd application user\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33mcreate app directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[33mdownload application\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log

echo -e "\e[33mextract dispatch application\e[0m"
unzip /tmp/dispatch.zip &>>/tmp/roboshop.log

echo -e "\e[33mdownload depedencies\e[0m"
cd /app &>>/tmp/roboshop.log
go mod init dispatch &>>/tmp/roboshop.log
go get &>>/tmp/roboshop.log
go build &>>/tmp/roboshop.log

echo -e "\e[33mSetup systemD file\e[0m"
cp /home/centos/roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service &>>/tmp/roboshop.log

echo -e "\e[33mStart dispatch service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable dispatch &>>/tmp/roboshop.log
systemctl start dispatch &>>/tmp/roboshop.log
