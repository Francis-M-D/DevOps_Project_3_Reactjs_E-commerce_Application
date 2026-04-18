---

# 🚀 DevOps Project 3 – ReactJS E-Commerce Application Deployment

---

## 📌 Project Overview

This project demonstrates a **production-ready DevOps pipeline** for deploying a ReactJS application using:

* Docker & Docker Compose
* Jenkins CI/CD Pipeline
* AWS EC2 Deployment
* Docker Hub (Dev & Prod Repos)
* Monitoring using Prometheus

The application is containerized, automated, and deployed on AWS with CI/CD integration.

---

## 🏗️ Architecture

```
GitHub (dev / master)
        ↓
     Jenkins (CI/CD)
        ↓
   Docker Build
        ↓
Docker Hub (dev / prod)
        ↓
AWS EC2 Deployment (Port 80)
        ↓
Monitoring (Prometheus)
```

---

## 📂 Project Repository

```
GitHub Repo:
https://github.com/Francis-M-D/DevOps_Project_3_Reactjs_E-commerce_Application.git
```

---

## 🌐 Deployed Application

```
http://<YOUR-EC2-PUBLIC-IP>
```

---

## 🐳 Docker Hub Repositories

```
Dev Repository  : francisdevops/dev (Public)
Prod Repository : francisdevops/prod (Private)
```

---

# ⚙️ Setup & Implementation

---

## 1️⃣ Application Setup

```bash
git clone https://github.com/sriram-R-krishnan/devops-build.git
cd devops-build
```

---

## 2️⃣ Docker Configuration

### 🔹 Dockerfile

* Multi-stage build using Node + Nginx
* Production-ready static hosting

---

### 🔹 Docker Compose

```bash
docker-compose up -d
```

Application runs on:

```
http://localhost:80
```

---

## 3️⃣ Bash Scripts

### 🔹 Build Script

```bash
./build.sh
```

* Builds Docker image
* Tags with latest + timestamp

---

### 🔹 Deploy Script

```bash
./deploy.sh
```

* Pulls latest image
* Stops old container
* Runs new container on port 80

---

## 4️⃣ Version Control (CLI Only)

```bash
git checkout -b dev
git add .
git commit -m "Dockerized application"
git push origin dev
```

---

## 5️⃣ Jenkins CI/CD

### 🔹 Features Implemented

* Auto-trigger via GitHub webhook
* Separate flows for:

  * **dev branch → dev Docker repo**
  * **master branch → prod Docker repo**
* Automated deployment to EC2

---

## 🔔 Jenkins Screenshots

### 🔹 Jenkins Login Page

![Jenkins Login](.screenshots/jenkins-login.png)

### 🔹 Jenkins Job Configuration

![Jenkins Config](.screenshots/jenkins-config.png)

### 🔹 Jenkins Build Logs

![Jenkins Logs](.screenshots/jenkins-build.png)

---

## 6️⃣ AWS Deployment

### 🔹 EC2 Configuration

* Instance Type: t3.micro
* Region: ap-south-1
* OS: Ubuntu

---

### 🔐 Security Group Rules

| Port | Access    |
| ---- | --------- |
| 80   | 0.0.0.0/0 |
| 22   | My IP     |

---

## ☁️ AWS Screenshots

### 🔹 EC2 Dashboard

![EC2](.screenshots/aws-ec2.png)

### 🔹 Security Group

![SG](.screenshots/aws-sg.png)

---

## 7️⃣ Docker Hub

### 🔹 Dev Repository

![Docker Dev](.screenshots/docker-dev.png)

### 🔹 Prod Repository

![Docker Prod](.screenshots/docker-prod.png)

---

## 🌍 Application Output

### 🔹 Deployed Website

![App](.screenshots/app-output.png)

---

## 📊 Monitoring Setup

* Prometheus used for monitoring
* Node Exporter for system metrics

---

### 🔹 Health Check

```bash
curl http://localhost
```

---

## 📈 Monitoring Screenshots

### 🔹 Prometheus Targets

![Prometheus](.screenshots/prometheus.png)

---

# 🧹 Cleanup (IMPORTANT FOR SUBMISSION)

After project completion, clean up all resources to avoid cost.

---

## 🔥 Docker Cleanup

```bash
# Stop containers
docker stop $(docker ps -aq)

# Remove containers
docker rm $(docker ps -aq)

# Remove images
docker rmi $(docker images -q)

# Remove volumes
docker volume rm $(docker volume ls -q)

# Remove unused networks
docker network prune -f

# Full cleanup (optional)
docker system prune -a -f
```

---

# 📸 Submission Checklist

* Jenkins screenshots ✔
* AWS screenshots ✔
* Docker Hub screenshots ✔
* Application output ✔
* Monitoring dashboard ✔
* GitHub repo link ✔
* Deployed URL ✔


---

# 💡 Key Highlights

* Multi-stage Docker build (optimized)
* CI/CD with branch-based deployment
* Production deployment on AWS
* Monitoring with Prometheus
* Fully automated pipeline

---

# 🧑‍💻 Author

**Maria Francis D**

---

