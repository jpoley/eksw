export SERVICE_URL=$(kubectl get svc -n wordpress-cwi understood-zebu-wordpress --template "{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}")

echo "Public URL: http://$SERVICE_URL/"
