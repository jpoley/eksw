
#remove old file
rm -rf eks.yaml 

tee ./eks.yaml << EOF
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: awspug-cluster
  region: us-east-1

vpc:
  subnets:
    public:
      $AZ_A: { id: $SUBNET_A }
      $AZ_B: { id: $SUBNET_B }
      $AZ_C: { id: $SUBNET_C }
      $AZ_D: { id: $SUBNET_D }


nodeGroups:
  - name: ng-1
    instanceType: t3.large
    desiredCapacity: 2
    volumeSize: 80
    ssh:
      allow: true # will use ~/.ssh/id_rsa.pub as the default ssh key
  - name: ng-2
    instanceType: t3.large
    desiredCapacity: 2
    volumeSize: 100
    ssh:
      publicKeyPath: ~/.ssh/id_rsa.pub
EOF

SECONDS=0
eksctl create cluster -f eks.yaml
duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."