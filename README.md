                                                # ApplicationDeploymentK8s

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
Please follow the steps mentioned here - https://github.com/keyurbitw/ApplicationDeploymentK8s/blob/master/K8s-Deployment-Steps.pdf in order to deploy the application maually.

# Single File Deployment:
All the deployment steps are written in a Single File. You can execute that File to deploy the application. 
Download or Clone this repo, and execute the SingleDeploymentFile.sh present in the repo.

