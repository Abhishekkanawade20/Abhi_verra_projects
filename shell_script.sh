#!/bin/bash

#########################################################
# Author: Abhishek
# Date: 29-01-2025
# Version: V1
# 
# This script will report the AWS Resource usage.we are going to list of instance.
#########################################################


echo "below are the list of instnace"
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'

aws s3 ls



