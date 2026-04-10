# Zainab El Bouyed — Personal Portfolio

> Cloud & DevOps Engineering Student at INPT Rabat  
> Live: [https://d1t1d43js7ic3w.cloudfront.net](https://d1t1d43js7ic3w.cloudfront.net)

---

## About

Personal portfolio built with HTML, CSS, and JavaScript — showcasing my projects, skills, education, and publications.

What started as a simple static website became a full **DevOps learning project**: I built a complete CI/CD pipeline around it, from containerization to cloud deployment and real-time monitoring.

---

## DevOps Infrastructure

Every `git push` to `main` automatically:

1. Builds a Docker image (`nginx:alpine`)
2. Pushes it to Docker Hub (versioned `:N` + `:latest`)
3. Syncs files to AWS S3
4. Invalidates CloudFront cache → live in seconds

**Zero manual intervention.**

```
git push
    ↓  GitHub webhook
Jenkins (CI/CD pipeline)
    ↓
Docker build + push to Docker Hub
    ↓
aws s3 sync → S3 bucket
    ↓
CloudFront invalidation → CDN worldwide
    ↓
https://d1t1d43js7ic3w.cloudfront.net ✅
```

---

## Tech Stack

### Portfolio
| Tech | Role |
|---|---|
| HTML / CSS / JS | Static website |
| Bootstrap 5 | Responsive layout |
| Font Awesome | Icons |
| AOS | Scroll animations |

### DevOps
| Tool | Role |
|---|---|
| Docker | Containerization — nginx:alpine image |
| Docker Hub | Versioned image registry |
| Jenkins | CI/CD pipeline orchestration |
| Terraform | Infrastructure as Code — S3 + CloudFront |
| AWS S3 | Static file hosting |
| AWS CloudFront | CDN + HTTPS |
| Prometheus | Metrics collection |
| Grafana | Real-time monitoring dashboards |

---

## Project Structure

```
Mon-portfolio/
├── index.html
├── about.html
├── education.html
├── skills.html
├── projects.html
├── publications.html
├── download.html
├── contact.html
├── css/
│   └── styles.css
├── js/
│   └── cursor.js
├── images/
├── webfonts/
├── Dockerfile              # nginx:alpine container
├── .dockerignore
├── Jenkinsfile             # CI/CD pipeline (4 stages)
├── terraform/
│   └── main.tf             # S3 + CloudFront infra
└── monitoring/
    ├── docker-compose.yml  # Prometheus + Grafana
    └── prometheus.yml
```

---

## Pipeline Stages

```
![Jenkins Pipeline Graph](images/pipeline.JPEG)
```

---

## What I Learned

This project taught me more than months of tutorials:

- Debugging a Jenkins pipeline at 2am
- Fixing Docker permission errors
- Wiring GitHub webhooks to Jenkins
- Provisioning cloud infrastructure with Terraform
- Understanding why each tool exists — and when it's overkill

---

## Contact

- Email: zainab.elbouyed04@gmail.com
- LinkedIn: [linkedin.com/in/zainab-el-bouyed-85700535b](https://www.linkedin.com/in/zainab-el-bouyed-85700535b)
- GitHub: [github.com/ZainabElbouyed](https://github.com/ZainabElbouyed)

---

*© 2025 Zainab El Bouyed — All Rights Reserved*
