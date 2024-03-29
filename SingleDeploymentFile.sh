echo "Installing the Guestbook Application. Please standby..."

K8s=$(which kubectl)

if [ -z "$K8s" ]
then
	echo "Please make sure that Kubernetes is Installed"
	exit 0
else
	K8sNamespace=$(kubectle get ns | grep "")

	kubectl create -f GuestBookApp/Namespaces/

	kubectl create -f GuestBookApp/ApplicationDeployment/ -n staging
	kubectl create -f GuestBookApp/ApplicationDeployment/ -n production

	#Execute the below steps in the Namespace where you want Ingress Controller
	kubectl create -f GuestBookApp/K8sRoles/ServiceAccount.yml -n staging

	kubectl create -f GuestBookApp/K8sRoles/Roles.yml -n staging
	kubectl create -f GuestBookApp/K8sRoles/RoleBinding.yml -n staging

	kubectl create -f GuestBookApp/K8sRoles/ClusterRole.yml
	kubectl create -f GuestBookApp/K8sRoles/ClusterRoleBinding.yml

	kubectl create -f GuestBookApp/Ingress/IngressControllerDeploymentDefination.yml -n staging
	kubectl create -f GuestBookApp/Ingress/IngressService.yml -n staging
	kubectl create -f GuestBookApp/Ingress/IngressRulesDefination.yml

	kubectl create -f TutumHelloWorldApp/

	kubectl get pods -n staging -o wide | grep 'ingress' | awk '{print $7}' | sed -e 's/ip-/ip:/g' | cut -d ':' -f2 | sed -e 's/-/./g'

fi
