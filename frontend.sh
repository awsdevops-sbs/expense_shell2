source common.sh
component=frontend
app_dir=/usr/share/nginx/html

print "install nginx"
dnf install nginx -y
check_status $?


print "copy the config file"
cp expense.conf /etc/nginx/default.d/expense.conf
check_status $?

App_req

print "Start the nginx service"
systemctl enable nginx &>>$Log
systemctl restart nginx &>>$Log
check_status $?