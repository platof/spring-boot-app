# Spring-boot-app

## Overview 
This project demonstrates a CI/CD pipeline for deploying a Java application to AWS EKS cluster using Github Actions, Docker and Kubernetes

## infrastructure setup
The infrastrucure used for this project is AWS EKS cluster. It is setup using terraform. The terraform files can be found in the kubernetes directory.

usage 'terraform init'
terraform validate
terraform format 
terraform plan 
terraform apply 

after the setup is complete run 

aws eks --region us-east-1 update-kubeconfig --name <cluster-name> 
## Prerequisites
- Docker

## solution

## Generating the jar file for building

### Creating a Dockerfile for the application

### Pushing the dockerfile to Docker Registry

### Spin up the eks cluster using terraform 

### writing the manifest and helm chart for java app, mysql and prometheus-grafana stack

### running terraform apply to deploy the application

### configuing ci/cd to automate the deployment process
:
## monitoring 