export VPC_ID=`aws ec2 describe-vpcs --filters Name=tag:Name,Values=aws-pug-vpc-VPC| jq -r '.Vpcs[].VpcId'`
export SUBNET_A=`aws ec2 describe-subnets  --filters Name=tag:Name,Values=aws-pug-vpc-Public-A| jq -r '.Subnets[].SubnetId'`
export SUBNET_B=`aws ec2 describe-subnets  --filters Name=tag:Name,Values=aws-pug-vpc-Public-B| jq -r '.Subnets[].SubnetId'`
export SUBNET_C=`aws ec2 describe-subnets  --filters Name=tag:Name,Values=aws-pug-vpc-Public-C| jq -r '.Subnets[].SubnetId'`
export SUBNET_D=`aws ec2 describe-subnets  --filters Name=tag:Name,Values=aws-pug-vpc-Public-D| jq -r '.Subnets[].SubnetId'`
export MY_IP=`curl http://ipinfo.io/ip`

