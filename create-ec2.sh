#!/bin/bash

NAMES=("web" "MongoDB" "catalogue" "redis" "user" "MySQL" "cart" "shipping" "RabbitMQ" "Payments" "Dispatch")
INSTANCE_TYPE=""
IMAGE_ID=ami-03265a0778a880afb
SECURITY_GROUP_ID=sg-0815d9222e91b557e
# if mysql or mongodb instance_type should be t3.micro, for all others it is t2.micro
for i in "${NAMES[@]}"
do 
    if [[ $i == "MongoDB" || $i == "MySQL" ]]
    then    
        INSTANCE_TYPE="t3.medium"
    else 
        INSTANCE_TYPE="t2.micro"
    fi
    echo "Creating $i instance"
    aws ec2 run-instances --image-id $IMAGE_ID --instance-type $INSTANCE_TYPE --security-group-ids $SECURITY_GROUP_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]"

done
