color="\e[33m"
nocolor="\e[0m"
log_file="&>>/tmp/roboshop.log"
app_path="/app"

stat_check() {
  if [ $1 -eq 0 ]; then
    echo Success
  else
    echo Failure
  fi
}

app_presetup() {
  echo -e "\e[33mAdd application user\e[0m"
  id roboshop ${log_file}
  if [ $? -eq 1 ]; then
    useradd roboshop ${log_file}
  fi
  echo -e "\e[33mCreate application directory\e[0m"
  rm -rf ${app_path} ${log_file}
  mkdir ${app_path} ${log_file}
  stat_check $?
  echo -e "\e[33mDownload application content\e[0m"
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip ${log_file}
  cd ${app_path} ${log_file}
  echo -e "${color}extract application content${nocolor}"
  cd $(app_path)
  unzip /tmp/${component}.zip ${log_file}
  cd ${app_path}
}

nodejs() {
  echo -e "${color}Configuring Node JS repos${nocolor}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash ${log_file}
  echo -e "${color} Install Nodejs${nocolor}"
  yum install nodejs -y ${log_file}
  app_presetup

  echo -e "${color}Install NodeJs Dependecies${nocolor}"
  npm install ${log_file}

  systemd_Setup
}

mongo_schema_setup() {
  echo -e "${color}Copy mongod repo file${nocolor}"
  cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo ${log_file}

  echo -e "${color}Installing mongodb client server${nocolor}"
  yum install mongodb-org-shell -y ${log_file}

  echo -e "${color}Load Schema${nocolor}"
  mongo --host mongodb-dev.sahityadevops.shop ${log_file} </app/schema/${component}.js
}

maven() {
  echo -e "\e[33mInstall Maven\e[0m"
  yum install maven -y ${log_file}
  app_presetup

  echo -e "\e[33mDownload maven dependecies\e[0m"
  mvn clean package ${log_file}
  mv target/${component}-1.0.jar ${component}.jar ${log_file}

  echo -e "\e[33m Install mysql client\e[0m"
  yum install mysql -y ${log_file}

  echo -e "\e[33mLoad schema\e[0m"
  mysql -h mysql-dev.sahityadevops.shop -uroot -pRoboShop@1 ${log_file} </app/schema/${component}.sql

  systemd_setup
}

systemd_setup() {
  echo -e "${color}Setup systemd service${nocolor}"
  cp /home/centos/roboshop-shell/${component}.service /etc/systemd/system/${component}.service ${log_file}

  echo -e "${color}Start ${component} service${nocolor}"
  systemctl daemon-reload ${log_file}
  systemctl enable ${component} ${log_file}
  systemctl restart ${component} ${log_file}
}

python() {
  echo -e "${color}Installing pytohn ${nocolor}"
  yum install python36 gcc python3-devel -y ${log_file}

  app_presetup

  echo -e "${color}Installing application depedencies${nocolor}"
  pip3.6 install -r requirements.txt ${log_file}

  systemd_setup
}
