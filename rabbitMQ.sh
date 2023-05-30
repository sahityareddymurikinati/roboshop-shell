echo -e "\e[33mConfigure erlang repo\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>/tmp/roboshop.log

echo -e "\e[33mconfigure rabbitmq repo\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>/tmp/roboshop.log

echo -e "\e[33mInstall rabitmq server\e[0m"
yum install rabbitmq-server -y &>>/tmp/roboshop.log

echo -e "\e[33mstart rabitmq service\e[0m"
systemctl enable rabbitmq-server &>>/tmp/roboshop.log
systemctl start rabbitmq-server  &>>/tmp/roboshop.log

echo -e "\e[33madd rabitmq application user\e[0m"
rabbitmqctl add_user roboshop roboshop123  &>>/tmp/roboshop.log
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>/tmp/roboshop.log