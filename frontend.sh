source common.sh
Component=frontend
app_dir=/usr/share/nginx/html

print "install nginx"
dnf install nginx -y
check_status $?

App_req
print "copy the config file"
cp expense.conf /etc/nginx/default.d/expense.conf
check_status $?

print "Start the nginx service"
systemctl enable nginx
systemctl restart nginx
check_status $?