#!/bin/bash

NAMES=("web" "MongoDB" "catalogue" "redis" "user" "MySQL" "cart" "shipping" "RabbitMQ" "Payments" "Dispatch")

for i in "${NAMES[@]}"
do 
    echo "NAME IS : $i"
done
