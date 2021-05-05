SECONDS=0
eksctl delete cluster -f eks.yaml
duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."