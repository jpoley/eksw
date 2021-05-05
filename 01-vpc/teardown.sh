
export C9_ID=`aws cloud9 list-environments | jq -r '.environmentIds[0]'`
aws cloud9 delete-environment --environment-id $C9_ID
#aws cloudformation delete-stack  --stack-name=aws-pug-vpc 