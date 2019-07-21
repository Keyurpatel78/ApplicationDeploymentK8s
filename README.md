# GuestBookApplicationDeploymentK8s

# Overview: #
You need to have a Kubernetes cluster, and the kubectl command-line tool must be configured to communicate with your cluster. This application is deployed on a 2 node Kubernetes Cluster. Here I have used the guesbook application.
The guestbook application is used with Ingress Controller & Horizontal Pod Autoscaler.

# Deployment Steps: #
1. Create Namespace:
2. Deploy the Guestbook Applcation in both the Namespace:
3. Create Service Account
4. Create a Role & Bind the Role to Service Account
5. Create a Cluster Role and Bind the Cluster Role to Service Account
6. Create an Ingress Controller
7. Create Ingress Rules or Ingress Resources
8. Deploy the Metrics Server for gathering the Resource Info:
9. Create an Horizontal Pod Autoscaler for Guestbook Application
10. Create an Horizontal Pod Autoscaler for Ingress Controller
11. Validate the Deployment

# Manuall Deployment:
Please follow the steps mentioned at https://github.com/keyurbitw/ApplicationDeploymentK8s/blob/master/K8s-Deployment-Steps.pdf in order to deploy the application maually.

# Single File Deployment:
All the deployment steps are written in a single shell script. You can execute that shell script to deploy the application. 
Download or Clone this repo, and execute the https://github.com/keyurbitw/ApplicationDeploymentK8s/blob/master/SingleDeploymentFile.sh present in the repo.

# Validating the Deployment:
Execute the below command to get the IP Address of the Ingress Controller.

> **IPAddress=$(kubectl get pods -n staging -o wide | grep ‘ingress’ | awk ‘{print $7}’ | sed -e ‘s/ip-/ip:/g’ | cut -d ‘:’ -f2 | sed -e ‘s/-/./g’)**
 
Once the IP Address is retrived we shall send the request to the Guestbook Application via Ingress Controller. We shall pass the hostname as a Header in the request as the hostname used here are not real hostnames. This is how it shall work.
 - Any request made to the guestbook.mstax.io will go the Guestbook Application running in the production Namespace.
 - Any request made to the staging-guestbook.mstax.io will go the Guestbook Application running in the staging Namespace.
 - All the other requestes will be routed to the HelloWorld Service running in tutum-namespace Namespace.

Execute the below command to check if the request was successfully sent to Application running in the stagging Namespace. You shall receive 200 as the output of the below command.
> **curl “$IPAddress” -I -H ‘Host: staging-guestbook.mstax.io’ -o /dev/null -w ‘%{http_code}\n’ -s**

Execute the below command to check if the request was successfully sent to Application running in the production Namespace. You shall receive 200 as the output of the below command.
> **curl “$IPAddress” -I -H ‘Host: guestbook.mstax.io’ -o /dev/null -w ‘%{http_code}\n’ -s**

Any request where the Hostname is not provided will be sent to the Hello World service running in the tutum-namespace Namespace. You can check that using below command. You shall see 200 as the output.
> **curl “$IPAddress” -I -o /dev/null -w ‘%{http_code}\n’ -s**

You can verify the above steps by checking the logs of the Ingress Controller. It shall show you to which services the requests are redirected. You can see below logs:

   > 10.44.0.0 - [10.44.0.0] - - [21/Jul/2019:16:18:56 +0000] “HEAD / HTTP/1.1” 200 0 “-” “curl/7.47.0” 92 0.004 **[staging-frontend-80]** [] 10.46.0.0:80 0 0.000 200 32339ca4f75f248c09bbd6984b33b366
   
   > 10.44.0.0 - [10.44.0.0] - - [21/Jul/2019:16:19:24 +0000] “HEAD / HTTP/1.1" 200 0 “-” “curl/7.47.0" 84 0.001 **[production-frontend-80]** [] 10.40.0.4:80 0 0.000 200 c13a6aa10437a251600157cafa3dc11e
   
   > 10.44.0.0 - [10.44.0.0] - - [21/Jul/2019:16:20:15 +0000] “HEAD / HTTP/1.1” 200 0 “-” “curl/7.47.0” 78 0.002 **[tutum-namespace-tutum-hello-world-service-80]** [] 10.46.0.7:80 0 0.000 200 e4c28f57bb592d52e42ce15da73e8f77**
