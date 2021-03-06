export VPC_ID=`aws ec2 describe-vpcs --filters Name=tag:Name,Values=aws-pug-vpc-VPC| jq -r '.Vpcs[].VpcId'`
export SUBNET_A=`aws ec2 describe-subnets  --filters Name=tag:Name,Values=aws-pug-vpc-Public-A| jq -r '.Subnets[].SubnetId'`
export SUBNET_B=`aws ec2 describe-subnets  --filters Name=tag:Name,Values=aws-pug-vpc-Public-B| jq -r '.Subnets[].SubnetId'`
export SUBNET_C=`aws ec2 describe-subnets  --filters Name=tag:Name,Values=aws-pug-vpc-Public-C| jq -r '.Subnets[].SubnetId'`
export SUBNET_D=`aws ec2 describe-subnets  --filters Name=tag:Name,Values=aws-pug-vpc-Public-D| jq -r '.Subnets[].SubnetId'`
export AZ_A=`aws ec2 describe-subnets  --filters Name=tag:Name,Values=aws-pug-vpc-Public-A| jq -r '.Subnets[].AvailabilityZone'`
export AZ_B=`aws ec2 describe-subnets  --filters Name=tag:Name,Values=aws-pug-vpc-Public-B| jq -r '.Subnets[].AvailabilityZone'`
export AZ_C=`aws ec2 describe-subnets  --filters Name=tag:Name,Values=aws-pug-vpc-Public-C| jq -r '.Subnets[].AvailabilityZone'`
export AZ_D=`aws ec2 describe-subnets  --filters Name=tag:Name,Values=aws-pug-vpc-Public-D| jq -r '.Subnets[].AvailabilityZone'`
export SG=`aws ec2 describe-security-groups --filters Name=tag:aws:cloudformation:stack-name,Values=aws-pug-vpc | jq -r '.SecurityGroups[].GroupId'`

export MY_IP=`curl http://ipinfo.io/ip`