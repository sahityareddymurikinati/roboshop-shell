source common.sh
component=dispatch

echo -e "${color}Install golang${nocolor}"
yum install golang -y ${log_file}

echo -e "${color}add application user${nocolor}"
useradd roboshop ${log_file}

echo -e "${color}create app directory${nocolor}"
rm -rf ${app_path} ${log_file}
mkdir ${app_path} ${log_file}

echo -e "${color}download application${nocolor}"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip ${log_file}
cd ${app_path} ${log_file}

echo -e "${color}extract ${component} application${nocolor}"
unzip /tmp/${component}.zip ${log_file}

echo -e "${color}download depedencies${nocolor}"
cd ${app_path} ${log_file}
go mod init ${component} ${log_file}
go get ${log_file}
go build ${log_file}

echo -e "${color}Setup systemD file${nocolor}"
cp /home/centos/roboshop-shell/${component}.service /etc/systemd/system/${component}.service ${log_file}

echo -e "${color}Start ${component} service${nocolor}"
systemctl daemon-reload ${log_file}
systemctl enable ${component} ${log_file}
systemctl start ${component} ${log_file}
