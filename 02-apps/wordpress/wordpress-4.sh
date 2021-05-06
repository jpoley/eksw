export ADMIN_URL="http://$SERVICE_URL/admin"
export ADMIN_PASSWORD=$(kubectl get secret --namespace wordpress-cwi understood-zebu-wordpress -o jsonpath="{.data.wordpress-password}" | base64 --decode)

echo "Admin URL: http://$SERVICE_URL/admin
Username: user
Password: $ADMIN_PASSWORD
"
