export EKS_CLUSTER=`eksctl get cluster --region=us-east-2  |grep True |awk {'pri
nt $1'}`
eksctl delete cluster --name $EKS_CLUSTER