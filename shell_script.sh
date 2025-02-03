#!/bin/bash

#########################################################
# Author: Abhishek
# Date: 29-01-2025
# Version: V1
# 
# This script will report the AWS Resource usage.we are going to list of instance.
#########################################################

#list ec2 instance
echo "below are the list of instnace" >> awsResource.txt
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId' >> awsResource.txt

#list s3 buckets
echo "below are the list of s3 buckets" >> awsResource.txt
aws s3 ls >> awsResource.txt



