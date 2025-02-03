#!/bin/bash

#########################################################
# Author: Abhishek
# Date: 29-01-2025
# Version: V1
# 
# This script will report the AWS Resource usage.
#########################################################

echo "list of aws instance"
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'



