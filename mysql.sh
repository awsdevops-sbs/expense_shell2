source common.sh

pass=$1

if [ -z "${pass}" ]; then
   print " no password " &>>$Log
   exit 1
   fi

print "Installing MySQL Server..." &>>$Log
sudo dnf install mysql-server -y &>>$Log
check_status $? &>>$Log

# Start and enable MySQL service
print "Starting and enabling MySQL..." &>>$Log
sudo systemctl start mysqld &>>$Log
sudo systemctl enable mysqld &>>$Log
check_status $? &>>$Log

print "setting up the password" &>>$Log
echo "Show database" | mysql -h mysql-dev.awsdevops.sbs -uroot -p${pass} &>>$Log
check_status $? &>>$Log
   if [ $? -eq 0 ]; then
     mysql_secure_installation --set-root-pass ${pass} &>>$Log
     check_status $? &>>$Log
     fi


