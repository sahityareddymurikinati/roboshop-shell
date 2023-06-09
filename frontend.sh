source common.sh
component=frontend

echo -e "${color}Installing nginx server${nocolor}"
yum install nginx -y ${log_file}

echo -e "${color}Removing old app content${nocolor}"
rm -rf /usr/share/nginx/html/* ${log_file}

echo -e "${color}Downloading ${component} Content${nocolor}"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip ${log_file}

echo -e "${color}Extract ${component} content${nocolor}"
cd /usr/share/nginx/html
unzip /tmp/${component}.zip ${log_file}

cp /home/centos/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "${color}Starting Server${nocolor}"
systemctl enable nginx ${log_file}
systemctl restart nginx ${log_file}


