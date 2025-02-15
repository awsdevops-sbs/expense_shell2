source common.sh
app_dir=/app
component=backend
pass=$1

if [ -z "$pass" ]; then
   exit 1
  fi

print "Disable current module " &>>$Log
dnf module disable nodejs -y
check_status $? &>>$Log

print "Enable the nodejs version 20" &>>$Log
dnf module enable nodejs:20 -y
check_status $? &>>$Log

print "Installing nodejs " &>>$Log
dnf install nodejs -y
check_status $? &>>$Log

print "Adding application user " &>>$Log
id expense &>>$Log
if [ $? -eq 0 ]; then
 useradd expense &>>$Log
fi
check_status $? &>>$Log

print "Copy backend config file " &>>$Log
cp backend.service /etc/systemd/system/backend.service &>>$Log
check_status $? &>>$Log

App_req

print "Installing NPM" &>>$Log
npm install &>>$Log
check_status $? &>>$Log

print "Starting backend service" &>>$Log
systemctl daemon-reload &>>$Log
systemctl enable backend &>>$Log
systemctl start backend &>>$Log
check_status $? &>>$Log

print "Install Mysql" &>>$Log
dnf install mysql -y
check_status $? &>>$Log

 print "Load sechma"
mysql -h mysql-dev.awsdevops.sbs -uroot -p${pass} < /app/schema/${component}.sql
check_status $? &>>$Log