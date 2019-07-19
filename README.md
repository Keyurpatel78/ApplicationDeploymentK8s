# ApplicationDeploymentK8s #

Overview:

You need to have a Kubernetes cluster, and the kubectl command-line tool must be configured to communicate with your cluster. This application is deployed on a 3 node Kubernetes Cluster. Here I have used the guesbook application.
The guestbook application is used with Ingress Controller & Horizontal Pod Autoscaler.

Architecture:


Deployment:

Please follow the below steps in order to Deploy this application.

1. Create Namespace:

2. Deploy the Guestbook Applcation in both the Namespace:

3. Create a Service Account

4. Create a Role & Bind the Role to Service Account

5. Create a Cluster Role and Bind the Cluster Role to Service Account

6. Create an Ingress Controller

7. Create Ingress Rules or Ingress Resources

8. Deploy the Metrics Server for gathering the Resource Info:

9. Create an Horizontal Pod Autoscaler for Guestbook Application

10. Create an Horizontal Pod Autoscaler for Ingress Controller

11. Validate the Deployment
