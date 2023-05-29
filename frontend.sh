echo -e "\e[33mInstalling nginx server\e[0m"
yum install nginx -y &>>/tmp/roboshop.log

echo -e "\e[33mRemoving old app content\e[0m"
rm -rf /usr/share/nginx/html/* &>>/tmp/roboshop.log

echo -e "\e33mDownloading Frontend Content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/roboshop.log

echo -e "\e[33mExtract Frontend content\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>/tmp/roboshop.log

##TODO add conf

echo -e "\e[33mStarting Server\e[0m"
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx &>>/tmp/roboshop.log


