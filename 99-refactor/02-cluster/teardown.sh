export EKS_CLUSTER=`eksctl get cluster --region=us-east-1  |grep True |awk {'print $1'}`
eksctl delete cluster --name $EKS_CLUSTER