source common.sh
app_dir=/app
component=backend
pass=$1

if [ -z "$pass" ]; then
  print "no password"
   exit 1
  fi

print "Disable current module "
dnf module disable nodejs -y
check_status $?

print "Enable the nodejs version 20"
dnf module enable nodejs:20 -y
check_status $?

print "Installing nodejs "
dnf install nodejs -y
check_status $?

print "Adding application user "
id expense &>>$Log
if [ $? -eq 0 ]; then
 useradd expense &>>$Log
fi
check_status $?

print "Copy backend config file "
cp backend.service /etc/systemd/system/backend.service &>>$Log
check_status $?

App_req

print "Installing NPM"
cd /app &>>$Log
npm install &>>$Log
check_status $? &>>$Log

print "Starting backend service"
systemctl daemon-reload &>>$Log
systemctl enable backend &>>$Log
systemctl start backend &>>$Log
check_status $?

print "Install Mysql"
dnf install mysql -y
check_status $?

 print "Load sechma"
mysql -h mysql-dev.awsdevops.sbs -uroot -p${pass} < /app/schema/backend.sql &>>$Log
check_status $? &>>$Log