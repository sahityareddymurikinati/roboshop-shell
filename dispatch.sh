echo -e "\e[33mInstall golang\e[0m"
yum install golang -y

echo -e "\e[33madd application user\e[0m"
useradd roboshop

echo -e "\e[33mcreate app directory\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[33mdownload application\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
cd /app

echo -e "\e[33mextract dispatch application\e[0m"
unzip /tmp/dispatch.zip

echo -e "\e[33mdownload depedencies\e[0m"
cd /app
go mod init dispatch
go get
go build

echo -e "\e[33mSetup systemD file\e[0m"
cp /home/centos/roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service &>>/tmp/roboshop.log

echo -e "\e[33mStart dispatch service\e[0m"
systemctl daemon-reload
systemctl enable dispatch
systemctl start dispatch
