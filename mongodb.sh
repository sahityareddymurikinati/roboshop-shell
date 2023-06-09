source common.sh
component=mongodb

echo -e "${color}Copy Monogdb repo file${nocolor}"
cp /home/centos/roboshop-shell/${component}.repo /etc/yum.repos.d/${component}.repo ${log_file}
echo -e "${color}Installing ${component} server${nocolor}"
yum install ${component}-org -y ${log_file}

echo -e "${color}Update ${component} listen address${nocolor}"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

echo -e "${color}Start ${component} service${nocolor}"
systemctl enable mongod ${log_file}
systemctl restart mongod ${log_file}