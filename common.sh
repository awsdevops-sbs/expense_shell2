Log=/tmp/exp.log
print(){
  echo $1
  echo "#########$1#############" &>>$Log
}
check_status(){
  if [ $? -eq 0 ]; then
  echo -e "\e[31mSucess\e[0m"
  else
     echo -e "\e[32mFailure\e[0m"
     fi
     }

App_req(){

 print "Remove old content" &>>$Log
rm -rf ${app_dir}/*
check_status $? &>>$Log

print "Create the directory" &>>$Log
mkdir ${app_dir} &>>$Log
check_status $? &>>$Log

print "Download frontend components" &>>$Log
 sudo curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/expense-${component}-v2.zip &>>$Log
check_status $? &>>$Log

print "Extract and  unzip download " &>>$Log
unzip /tmp/${Component}.zip &>>$Log
check_status $? &>>$Log
}
