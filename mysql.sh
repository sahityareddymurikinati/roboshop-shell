source common.sh
component=mysql

echo -e "${color}disable current version of sql${nocolor}"
yum module disable ${component} -y ${log_file}

echo -e "${color}Cop ${component} repo file${nocolor}"
cp /home/centos/roboshop-shell/${component}.repo /etc/yum.repos.d/${component}.repo

echo -e "${color}Installing ${component}${nocolor}"
yum install ${component}-community-server -y ${log_file}

echo -e "${color} start sql service${nocolor}"
systemctl enable ${component}d ${log_file}
systemctl restart ${component}d ${log_file}

echo -e "${color}set up password${nocolor}"
${component}_secure_installation --set-root-pass $1 ${log_file}