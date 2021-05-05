. ./export.sh

aws cloud9 create-environment-ec2 --name aws-pug-cloud9 --instance-type=t3.medium --subnet-id=$SUBNET_A

export C9_ID=`aws cloud9 list-environments | jq -r '.environmentIds[0]'`