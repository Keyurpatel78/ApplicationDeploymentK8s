MetricsServer=$(kubectl get pods --all-namespaces -o wide | grep 'metrics-server' | awk '{print $7}')

if [ -z "$MetricsServer" ]
then
	echo "Metrics Server not installed. Installing Metrics Server"
	git clone https://github.com/kubernetes-incubator/metrics-server.git
	kubectl create -f metrics-server/deploy/1.8+/
	sleep 180
	metricsservernamespace=$(kubectl top pods --all-namespaces | grep 'metrics-server' | awk '{print $1}')
	if [[ $metricsservernamespace -ne 'kube-system' ]]
	then
		echo 'Metrics Server is not running. Please check the metrics server pod result in the kube-system Namespace!!'
		exit 0
	fi
else
	metricsservernamespace=$(kubectl top pods --all-namespaces | grep 'metrics-server' | awk '{print $1}')
	if [[ $metricsservernamespace -eq 'kube-system' ]]
        then
		echo "Metrics Server Pod is running in Kube-Sysmtem Namespace."
	fi
fi

echo "Creating AutoScaler Pod for Guestbook Application"
kubectl create -f GuestBookApp/HorizontalPodScaler/FrontEndAutoScaler.yml -n staging
kubectl get hpa -n staging
kubectl describe hpa -n staging | tail -f

echo "Currently the Pods are running at below IP(s):"
kubectl get pods -n staging -o wide | grep 'frontend' | awk '{print $6}'
echo "Please run the GenerateLoad.sh script to implement AutoScaling."

