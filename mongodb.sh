echo -e "\e[33mCopy Monogdb repo file\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo
echo -e "\e[33mInstalling mongodb server\e[0m"
yum install mongodb-org -y
##TODO modify config file
echo -e "\e[33mStart mongodb service\e[0m"
systemctl enable mongod
systemctl restart mongod