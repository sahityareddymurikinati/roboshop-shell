source common.sh
component=rabbitmq

echo -e "${color}Configure erlang repo${nocolor}"
curl -s https://packagecloud.io/install/repositories/${component}/erlang/script.rpm.sh | bash ${log_file}

echo -e "${color}configure ${component} repo${nocolor}"
curl -s https://packagecloud.io/install/repositories/${component}/${component}-server/script.rpm.sh | bash ${log_file}

echo -e "${color}Install rabitmq server${nocolor}"
yum install ${component}-server -y ${log_file}

echo -e "${color}start rabitmq service${nocolor}"
systemctl enable ${component}-server ${log_file}
systemctl start ${component}-server  ${log_file}

echo -e "${color}add rabitmq application user${nocolor}"
${component}ctl add_user roboshop $1  ${log_file}
${component}ctl set_permissions -p / roboshop ".*" ".*" ".*" ${log_file}