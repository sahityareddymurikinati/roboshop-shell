source common.sh
component=redis

echo -e "${color}Installing ${component} repos${nocolor}"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y ${log_file}

echo -e "${color}enable ${component} 6 version${nocolor}"
yum module enable ${component}:remi-6.2 -y ${log_file}

echo -e "${color} install ${component}${nocolor}"
yum install ${component} -y ${log_file}

echo -e "${color}Update ${component} listen address${nocolor}"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/${component}.conf /etc/${component}/${component}.conf ${log_file}

echo -e "${color} enable and start ${component}${nocolor}"
systemctl enable ${component} ${log_file}
systemctl restart ${component} ${log_file}