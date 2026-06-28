# CloudScale Final Cloud & DevOps Engineering Project

## Project Overview

This project is a final Cloud Computing & DevOps Engineering project. The goal of the project is to deploy a containerized web application to Microsoft Azure using DevOps best practices.

The project scenario is based on a startup called **CloudScale**, which needs to deploy a web application using Docker, Azure Container Registry, Terraform, Azure Kubernetes Service, Kubernetes manifests, and GitHub Actions.

The project includes:

* A custom web application
* Docker containerization
* Azure Container Registry image storage
* Terraform infrastructure provisioning
* Azure Kubernetes Service deployment
* Kubernetes Deployment and Service manifests
* Kubernetes readiness and liveness probes
* GitHub Actions CI/CD automation
* Manual approval gate before production deployment

---

## Team Members and Work Distribution

| Student           | Student ID | Main Responsibilities                                                                                                              |
| ----------------- | ---------: | ---------------------------------------------------------------------------------------------------------------------------------- |
| Rawan Eltheni     |       4753 | Web application, Dockerfile, Nginx configuration, `/health` endpoint, Kubernetes deployment and service files                      |
| Kalthoum Alatrash |       4853 | Terraform Azure infrastructure, ACR, AKS, remote backend, `.gitignore`, GitHub Actions CI/CD workflow, Azure deployment automation |

---

## What Each Student Did

### Rawan Eltheni

Rawan worked mainly on the application, Docker, Nginx, and Kubernetes parts of the project.

Her tasks included:

* Created the web application inside the `app` folder.
* Added the project title to the application page.
* Added the team members' names and student IDs to the web page.
* Created the `Dockerfile` for containerizing the application.
* Used the `nginx:alpine` image to serve the web application.
* Copied the application files into the Nginx web directory.
* Created the `nginx.conf` file.
* Configured Nginx to listen on port `80`.
* Added the `/health` endpoint.
* Prepared the `/health` endpoint to be used by Kubernetes probes.
* Created the Kubernetes `deployment.yaml` file.
* Configured the deployment with 3 replicas.
* Configured the container image from Azure Container Registry.
* Added readiness probe using `/health`.
* Added liveness probe using `/health`.
* Created the Kubernetes `service.yaml` file.
* Configured the service as a `LoadBalancer`.
* Helped test the application locally using Docker and Kubernetes commands.

### Kalthoum Alatrash

Kalthoum worked mainly on the Azure infrastructure and CI/CD automation parts of the project.

Her tasks included:

* Created the Terraform folder and Terraform configuration files.
* Configured the Azure provider in `providers.tf`.
* Configured the Terraform remote backend using Azure Storage.
* Created the Azure Resource Group using Terraform.
* Created the Azure Container Registry using Basic SKU.
* Created the Azure Kubernetes Service cluster.
* Configured AKS with 2 nodes.
* Set the AKS node size to `Standard_B2s`.
* Added project tags to Azure resources.
* Configured AKS and ACR integration using the `AcrPull` role.
* Added Terraform variables in `variables.tf`.
* Added Terraform outputs in `outputs.tf`.
* Created and updated `.gitignore` to protect Terraform state files and private variables.
* Created the GitHub Actions CI/CD workflow.
* Added Docker build and local test steps.
* Added Azure login steps.
* Added Terraform plan and apply steps.
* Added image build and push automation.
* Added AKS deployment automation.
* Added the production environment for the manual approval gate.
* Prepared the required GitHub Secrets for the workflow.

---

## Technologies Used

* HTML
* Nginx
* Docker
* Azure Container Registry
* Azure Kubernetes Service
* Terraform
* Kubernetes
* GitHub Actions
* GitHub Secrets

---

## Repository Structure

```text
.
├── app/
│   └── index.html
├── k8s/
│   ├── deployment.yaml
│   └── service.yaml
├── terraform/
│   ├── providers.tf
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── .github/
│   └── workflows/
│       └── ci-cd.yml
├── Dockerfile
├── nginx.conf
├── .gitignore
└── README.md
```

---

## Application

The application is a simple web page served by Nginx. It displays the project title and the students' names and IDs.

The application is stored in:

```text
app/index.html
```

The application includes the following students:

```text
Rawan Eltheni — 4753
Kalthoum Alatrash — 4853
```

---

## Health Endpoint

The Nginx configuration includes a health endpoint:

```text
/health
```

Expected response:

```text
healthy
```

This endpoint is important because Kubernetes uses it for:

* Readiness probe
* Liveness probe

The readiness probe checks if the application is ready to receive traffic.

The liveness probe checks if the application is still running correctly.

---

## Docker

The project uses Docker to containerize the web application.

The `Dockerfile` uses the `nginx:alpine` image.

The Dockerfile:

* Starts from the `nginx:alpine` image
* Copies the application files into the Nginx HTML folder
* Copies the custom Nginx configuration
* Exposes port `80`

### Build the Docker Image Locally

```bash
docker build -t cloudscale-app:local .
```

### Run the Docker Container Locally

```bash
docker run -d --name cloudscale-app -p 8080:80 cloudscale-app:local
```

### Test the Application Locally

```bash
curl http://localhost:8080
```

### Test the Health Endpoint Locally

```bash
curl http://localhost:8080/health
```

### Stop and Remove the Local Container

```bash
docker stop cloudscale-app
docker rm cloudscale-app
```

---

## Azure Infrastructure with Terraform

Terraform is used to create and manage the Azure infrastructure.

The Terraform configuration creates:

* Azure Resource Group
* Azure Container Registry
* Azure Kubernetes Service
* AKS and ACR integration
* Azure resource tags

The infrastructure files are stored in:

```text
terraform/
```

### Terraform Files

| File           | Purpose                                                         |
| -------------- | --------------------------------------------------------------- |
| `providers.tf` | Configures Terraform, Azure provider, and remote backend        |
| `main.tf`      | Creates the Azure Resource Group, ACR, AKS, and role assignment |
| `variables.tf` | Defines reusable Terraform variables                            |
| `outputs.tf`   | Displays important output values after deployment               |

### Azure Resources

| Resource                 | Configuration                                            |
| ------------------------ | -------------------------------------------------------- |
| Resource Group           | Name includes the students/project name                  |
| Azure Container Registry | Basic SKU                                                |
| Azure Kubernetes Service | 2 nodes                                                  |
| AKS VM Size              | `Standard_B2s`                                           |
| AKS + ACR Integration    | Automatic image pull using `AcrPull`                     |
| Tags                     | `Project = "Final"` and `StudentName = var.student_name` |

---

## Terraform Setup Instructions

Go to the Terraform folder:

```bash
cd terraform
```

Initialize Terraform:

```bash
terraform init
```

Validate the Terraform files:

```bash
terraform validate
```

Create a Terraform plan:

```bash
terraform plan
```

Apply the Terraform configuration:

```bash
terraform apply
```

Or, if using a `terraform.tfvars` file:

```bash
terraform apply -var-file="terraform.tfvars"
```

Example `terraform.tfvars`:

```hcl
subscription_id      = "YOUR_AZURE_SUBSCRIPTION_ID"
resource_group_name = "final_kalthoum_rawan_prj"
location            = "switzerlandnorth"
acr_name            = "kalthoumacr2026"
aks_name            = "kalthoum-rawan-aks"
student_name        = "Kalthoum and Rawan"
```

Important: Do not push `terraform.tfvars` to GitHub because it may contain private Azure information.

---

## Azure Container Registry

The Docker image is stored in Azure Container Registry.

Example image:

```text
kalthoumacr2026.azurecr.io/cloudscale-app:latest
```

The image can also be tagged using the GitHub commit SHA during the CI/CD process.

---

## Kubernetes Deployment

The Kubernetes deployment file is located in:

```text
k8s/deployment.yaml
```

The deployment includes:

* Deployment name: `cloudscale-app`
* 3 replicas
* Image from Azure Container Registry
* Container port `80`
* Readiness probe using `/health`
* Liveness probe using `/health`

Apply the deployment manually:

```bash
kubectl apply -f k8s/deployment.yaml
```

Check the deployment:

```bash
kubectl get deployments
```

Check the pods:

```bash
kubectl get pods
```

Check rollout status:

```bash
kubectl rollout status deployment/cloudscale-app
```

---

## Kubernetes Service

The Kubernetes service file is located in:

```text
k8s/service.yaml
```

The service exposes the application using a LoadBalancer.

Service name:

```text
cloudscale-service
```

Service type:

```text
LoadBalancer
```

Apply the service manually:

```bash
kubectl apply -f k8s/service.yaml
```

Check the service:

```bash
kubectl get svc
```

After the external IP is created, open the application in the browser:

```text
http://EXTERNAL-IP
```

Test the health endpoint:

```bash
curl http://EXTERNAL-IP/health
```

---

# 2. GitHub Actions Workflow Explanation

The GitHub Actions workflow is located in:

```text
.github/workflows/ci-cd.yml
```

The workflow automates the CI/CD process for the project.

It is responsible for:

1. Building and testing the Docker image
2. Running Terraform plan
3. Building and pushing the Docker image to Azure Container Registry
4. Applying infrastructure changes using Terraform
5. Deploying the application to Azure Kubernetes Service
6. Waiting for manual approval before production deployment

---

## 2.1 Add GitHub Secrets

Before running the workflow, the required GitHub Secrets must be added.

To add the secrets, navigate to:

```text
GitHub Repository → Settings → Secrets and variables → Actions → New repository secret
```

Add the following secrets:

| Secret Name         | Purpose                                                                       |
| ------------------- | ----------------------------------------------------------------------------- |
| `AZURE_CREDENTIALS` | Azure service principal credentials used by GitHub Actions to log in to Azure |
| `ACR_NAME`          | Azure Container Registry name only, without `.azurecr.io`                     |
| `RESOURCE_GROUP`    | Azure Resource Group that contains the AKS and ACR resources                  |
| `AKS_NAME`          | Azure Kubernetes Service cluster name                                         |

---

## AZURE_CREDENTIALS

This secret is used by GitHub Actions to authenticate with Azure.

The value should be the JSON output of the Azure service principal credentials.

Example format:

```json
{
  "clientId": "xxxx",
  "clientSecret": "xxxx",
  "subscriptionId": "xxxx",
  "tenantId": "xxxx"
}
```

This secret is used in the workflow by the Azure login step.

---

## ACR_NAME

This secret stores the Azure Container Registry name only.

To list Azure Container Registries, run:

```bash
az acr list --query "[].{name:name, resourceGroup:resourceGroup, loginServer:loginServer}" -o table
```

Use only the registry name, not the full URL.

Example:

```text
ACR_NAME = kalthoumacr2026
```

Incorrect:

```text
kalthoumacr2026.azurecr.io
```

Correct:

```text
kalthoumacr2026
```

The workflow can use this value to create the full login server:

```text
${{ secrets.ACR_NAME }}.azurecr.io
```

---

## RESOURCE_GROUP

This secret stores the Azure Resource Group name that contains the AKS and ACR resources.

To list your Azure Resource Groups, run:

```bash
az group list --query "[].name" -o table
```

Example:

```text
RESOURCE_GROUP = final_kalthoum_rawan_prj
```

This value is used when connecting GitHub Actions to AKS and when running Terraform.

---

## AKS_NAME

This secret stores the Azure Kubernetes Service cluster name.

To list all AKS clusters, run:

```bash
az aks list --query "[].{name:name, resourceGroup:resourceGroup}" -o table
```

Or, after knowing the resource group, run:

```bash
az aks list \
  --resource-group "$RESOURCE_GROUP" \
  --query "[].name" \
  -o table
```

To verify the AKS cluster, run:

```bash
az aks show \
  --name "$AKS_NAME" \
  --resource-group "$RESOURCE_GROUP"
```

Example:

```text
AKS_NAME = kalthoum-rawan-aks
```

---

## 2.2 Workflow Stage 1: Build and Test

The first stage runs on every push.

It performs the following actions:

* Checks out the repository code
* Builds the Docker image
* Runs the Docker container locally
* Waits for the container to start
* Tests the `/health` endpoint
* Confirms that the application container is working correctly

Example health test:

```bash
curl --fail http://localhost:8080/health
```

If the health endpoint fails, the workflow fails.

---

## 2.3 Workflow Stage 2: Terraform Plan

The workflow can run Terraform plan to check the infrastructure changes before applying them.

This stage:

* Logs in to Azure using `AZURE_CREDENTIALS`
* Sets up Terraform
* Runs `terraform init`
* Runs `terraform plan`
* Uses GitHub Secrets and Terraform variables for Azure configuration

This helps verify infrastructure changes before deployment.

---

## 2.4 Workflow Stage 3: Build and Push to ACR

This stage runs only when code is pushed to the `main` branch.

It performs the following actions:

* Logs in to Azure
* Logs in to Azure Container Registry
* Builds the Docker image
* Tags the image with the GitHub commit SHA
* Tags the image as `latest`
* Pushes the image to Azure Container Registry

Example image format:

```text
ACR_NAME.azurecr.io/cloudscale-app:latest
```

Example using the project registry:

```text
kalthoumacr2026.azurecr.io/cloudscale-app:latest
```

---

## 2.5 Workflow Stage 4: Manual Approval Gate

Before deploying to production, the workflow uses a manual approval gate.

The deployment job uses the GitHub Actions environment:

```text
production
```

This means the deployment will wait until an approved user manually approves it in GitHub Actions.

The manual approval gate is important because it prevents automatic production deployment without review.

---

## 2.6 Workflow Stage 5: Deploy to AKS

After approval, the workflow deploys the application to Azure Kubernetes Service.

This stage:

* Logs in to Azure using `AZURE_CREDENTIALS`
* Connects to the AKS cluster using `RESOURCE_GROUP` and `AKS_NAME`
* Applies the Kubernetes deployment file
* Applies the Kubernetes service file
* Checks the deployment rollout status

Commands used during deployment:

```bash
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl rollout status deployment/cloudscale-app
```

---

## Connect to AKS Manually

To connect to the AKS cluster from a local machine, run:

```bash
az aks get-credentials \
  --resource-group final_kalthoum_rawan_prj \
  --name kalthoum-rawan-aks
```

Check AKS nodes:

```bash
kubectl get nodes
```

Check pods:

```bash
kubectl get pods
```

Check services:

```bash
kubectl get svc
```

---

## Verification Commands

Check Azure Container Registry repositories:

```bash
az acr repository list --name kalthoumacr2026 --output table
```

Check AKS nodes:

```bash
kubectl get nodes
```

Check Kubernetes pods:

```bash
kubectl get pods
```

Check the LoadBalancer service:

```bash
kubectl get svc cloudscale-service
```

Check deployment status:

```bash
kubectl rollout status deployment/cloudscale-app
```

Test the application health endpoint:

```bash
curl http://EXTERNAL-IP/health
```

---

## Required Screenshots for Final Submission

The final documentation should include the following screenshots:

1. Docker build successful
2. Image in Azure Container Registry
3. `terraform apply` successful
4. AKS nodes ready using `kubectl get nodes`
5. Application running in browser with the custom message
6. GitHub Actions workflow successful
7. GitHub Actions manual approval gate
8. Azure Portal showing AKS and ACR

---

## Cost Warning and Cleanup

Azure resources can generate costs while they are running.

To avoid unnecessary Azure charges, destroy the infrastructure after finishing the project.

Go to the Terraform folder:

```bash
cd terraform
```

Destroy the infrastructure:

```bash
terraform destroy
```

Or, if using a `terraform.tfvars` file:

```bash
terraform destroy -var-file="terraform.tfvars"
```

---

## Repository Link

```text
https://github.com/kalthoum0/finalCloundPrj
```

---

## Project Summary

This project demonstrates a complete DevOps workflow for deploying a containerized web application to Azure.

Rawan focused on the application, Docker, Nginx, and Kubernetes deployment files.

Kalthoum focused on Terraform, Azure infrastructure, GitHub Actions, GitHub Secrets, and deployment automation.

Together, the project includes Docker containerization, image storage in Azure Container Registry, infrastructure provisioning with Terraform, deployment to Azure Kubernetes Service, Kubernetes health probes, CI/CD automation with GitHub Actions, and a manual approval gate for production deployment.
