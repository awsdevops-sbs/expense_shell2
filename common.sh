Log=/tmp/exp.log
print(){
  echo $1
  echo "#########$1#############" &>>$Log
}
check_status(){
  if [ $? -eq 0 ]; then
  echo -e "\e[32mSucess\e[0m"
  else
     echo -e "\e[31mFailure\e[0m"
     fi
     }

App_req(){

 print "Remove old content"
rm -rf ${app_dir} &>>$Log
check_status $? &>>$Log

print "Create the directory"
mkdir ${app_dir} &>>$Log
check_status $?

print "Download frontend components"
 sudo curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/expense-${component}-v2.zip
check_status $?

print "Extract and  unzip download "
  cd ${app_dir} &>>$Log
  unzip /tmp/${component}.zip &>>$Log

check_status $?
}
