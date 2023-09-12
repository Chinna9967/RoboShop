#!/bin/bash
DATE=$(date +%F)
LOGSDIR=/tmp
SCRIPT_NAME=$0
LOGFILE=$LOGSDIR/$0-$DATE.log
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[om"
Y="\e[33m"


if [ $USERID -ne 0 ]
then
    echo -e  " $R ERROR: please run this with root access $N"
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 ...$R Failure $N"
        exit 1
    else
        echo -e "$2 ...$G Success $N"
    fi
}

curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$LOGFILE

VALIDATE $? "Setting up of NPM Source"

yum install nodejs -y &>>$LOGFILE

VALIDATE $? "Installing Nodejs"

# once the user is created, if you run this script for the second time
# this cmd will fail
# improvement: first check user is already exist or not , if not exist then create
useradd roboshop &>>$LOGFILE

# VALIDATE $? "Setting up of NPM Source"

# write a condition to check directory is existed or not
mkdir /app &>>$LOGFILE

# VALIDATE $? "Setting up of NPM Source"

curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip &>>LOGFILE

VALIDATE $? "Downloading catalogue artifact"

cd /app &>>$LOGFILE

VALIDATE $? "Moving into app direcctory"

unzip /tmp/catalogue.zip &>>$LOGFILE

VALIDATE $? "Unzipiing catalogue"

npm install &>>$LOGFILE

VALIDATE $? "Installing dependencies"

# give full path of catalogue.service bcoz we are inside /app
cp E:\Devops_Shiva\Github\repos\RoboShop\Catalogue.service /etc/systemd/system/catalogue.service &>>LOGFILE

VALIDATE $? "Copying catalogue.service"

systemctl daemon-reload &>>$LOGFILE

VALIDATE $? "deamon reload"

systemctl enable catalogue &>>$LOGFILE

VALIDATE $? "Enabling catalogue"

systemctl start catalogue &>>$LOGFILE

VALIDATE $? "Starting catalogur"

cp E:\Devops_Shiva\Github\repos\RoboShop\mongo.repo /etc/yum.repos.d/mongo.repo &>>LOGFILE

VALIDATE $? "Copying mongo repo"

yum install mongodb-org-shell -y &>>$LOGFILE

VALIDATE $? "Installing mongo client"

mongo --host mongodb.kpdigital.online </app/schema/catalogue.js

VALIDATE $? "Loading catalague mongodb"