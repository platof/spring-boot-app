# Spring-boot-app

## Overview 
This project demonstrates a CI/CD pipeline for deploying a Java application to AWS EKS cluster using Github Actions, Docker and Kubernetes. The pipleine automates the building, containerizing and deploying the application

## Prerequisites
- Docker
- AWS EKS
- Github
- Terraform

## Steps
- Generating the jar file before building
- Creating a Dockerfile for the application
- Pushing the dockerfile to Docker Registry
- Set up Eks cluster using terraform 
- Writing the manifest and helm chart for java app, mysql database and prometheus-grafana stack using terraform
- Terraform apply to deploy the application and test the application
- Configuring ci/cd and monitoring to automate the deployment process

## Build and Push the Docker Image
```bash
docker build -t <platof/java-app:<tag> .
docker push <platof/java-app:<tag>
```

## infrastructure setup
The infrastrucure used for this project is AWS EKS cluster. It is setup using terraform. The terraform files can be found in the kubernetes directory.

```bash
terraform init
terraform validate
terraform format 
terraform plan 
terraform apply
``` 

This will deploy the EKS cluster, Mysql database, Java Application, as well as Prometheus and Grafana for monitoring.   

```bash
aws eks --region us-east-1 update-kubeconfig --name <cluster-name> 
``` 

To view the nodes run
```bash
kubectl get nodes
```
To view the application Pods
```bash
kubectl get pods -n application
```
To view the monitoring pods
```bash
Kubectl get pods -n monitoring 
```
To get the external-ip
```bash
kubectl get svc -n application
```
Access the appropriate endpoints such as:
```bash
http://<external-ip>/actuator/health
```

## CI/CD Pipeline
The ci-cd.yml file can be found in the .github/workflows/ directory. It comprises of 2 stages. Build stage and Deploy stage.

### Build stage
- Retrieves the commit hash 
- Builds the docker image tages with the commit hash
- Pushes the image to Docker Hub

### Deploy stage
- Configure AWS credentials
- Updates the EKS kubeconfig 
- Deployes the update image using kubectl set image

## monitoring 
Prometheus and Grafana were preconfigure for monitoring
```bash
kubectl port-forward svc/kube-prometheus-stack-grafana 3000:80 -n monitoring
```