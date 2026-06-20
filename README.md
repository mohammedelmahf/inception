# *This project has been created as part of the 42 curriculum by maelmahf.*

---

# 🐳 Inception – System Administration with Docker
## 📖 Description

The **Inception** Project is a sophisticated web infrastructure, all running on the same Docker network, orchestrated using Docker and Docker Compose.NGINX manages incoming web traffic, serving static files directly and forwarding dynamic content requests to PHP-FPM, which processes PHP code from Word Press. WordPress uses Redis for caching frequently accessed data, enhancing performance by reducing database queries to MariaDB, which handles all content data storage and management. After PHP-FPM processes the request and retrieves data from Redis and MariaDB, the content is returned to NGINX for delivery to the user. Additionally, NGINX serves a Static Website for direct content delivery. Adminer provides database management for MariaDB, and Portainer oversees and monitors the Docker containers running these services. Docker volumes ensure persistent storage and efficient data management, all within a unified Docker network that facilitates seamless communication and operation across the entire system.

This infrastructure includes:

🐬 MariaDB (Database server)
🌐 WordPress (CMS)
⚡ Redis (Caching system)
🔐 Nginx (Reverse proxy with TLS)
📦 Docker Volumes (Persistent storage)
🌐 Custom Docker Network (Service communication)

The project helps understand containerization, service isolation, networking, persistent storage, and secure system design.

## 🏗️ Project Architecture
                ┌──────────────┐
                │    NGINX     │
                │ Reverse Proxy│
                └──────┬───────┘
                       │ HTTPS (443)
                       ▼
                ┌──────────────┐
                │  WordPress   │
                └──────┬───────┘
                       │
              ┌────────┴────────┐
              ▼                 ▼
          MariaDB             Redis
## Overview
- Each service runs in a separate container.
- Containers communicate through a Docker bridge network.
- Only Nginx is exposed to the host machine.
- MariaDB and Redis remain internal (not exposed).
- Data is persisted using Docker volumes.
# ⚙️ Instructions
## 🔧 Requirements
- Docker
- Docker Compose plugin
- Linux-based system (recommended)
- Make
## 🚀 Build & Run

From the root directory:

```bash
make
```

Or manually:

```bash
cd srcs
docker-compose up --build -d
```

---

## 🛑 Stop the Infrastructure

```bash
make down
```

---

## 🧹 Remove Everything (Containers, Images, Volumes)

```bash
make fclean
```
## 🌍 Access the Website

After running the project:

```
https://localhost
```
Or:
```
https://maelmahf.42.fr
```
---

# 🔍 Technical Choices
### VMs Vs Containers

| **Aspect**                  | **Virtual Machines (VMs)**                                   | **Containers**                                             |
|-----------------------------|---------------------------------------------------------------|------------------------------------------------------------|
| **OS**                      | Full OS (includes application and dependencies)              | Shares host OS kernel (includes only application and dependencies) |
| **Isolation**               | Strong isolation, each VM is a separate environment          | Moderate isolation, containers share the same OS kernel   |
| **Resource Usage**          | More resource-intensive, needs separate OS for each VM       | Lightweight, uses fewer resources                          |
| **Boot Time**               | Longer boot time due to full OS initialization                | Fast startup, often in seconds                             |
| **Use Cases**               | Suitable for running different OS or strong isolation needs   | Ideal for microservices, CI/CD, and scalable applications  |


## 🔐 Secrets vs Environment Variables
| **Aspect**          | **Environment Variables**                             | **Secrets**                                             |
| ------------------- | ----------------------------------------------------- | ------------------------------------------------------- |
| **Purpose**         | Store configuration data (non-sensitive)              | Store sensitive data (passwords, API keys, tokens)      |
| **Security Level**  | Low security, can be exposed in logs or process lists | High security, encrypted and access-controlled          |
| **Storage**         | Plain text in runtime environment or `.env` files     | Stored in secure vaults or secret managers              |
| **Access Control**  | Accessible by the running process                     | Strict access policies (role-based access, permissions) |
| **Best Use Cases**  | App config like port, mode, feature flags             | Database passwords, JWT keys, TLS certificates          |
| **Risk if Exposed** | Medium impact (depends on data)                       | High impact (system compromise possible)                |
| **Rotation**        | Manual / less frequent                                | Designed for easy rotation and lifecycle management     |

This project uses .env files, but production systems should use Docker Secrets.

## 🌐 Docker Network vs Host Network
Bridge Network	Host Network
Isolated	Shares host network
Secure	Less secure
Container name DNS	Direct host access

A custom bridge network is used in this project.

## 💾 Volumes vs Bind Mounts
Volumes	Bind Mounts
Managed by Docker	Managed by host
Portable	Host dependent
Production friendly	Development friendly

Persistent data is stored using Docker named volumes.

## 🔒 Security
- TLS enabled via Nginx (HTTPS only)
- Only port 443 exposed
- Internal services isolated (MariaDB, Redis)
- Minimal Alpine/Debian base images
- Environment variables used for configuration

## Resources

- [VM vs Containers: Understanding the Differences](https://www.backblaze.com/blog/vm-vs-containers/)
- [What Are Containers Made From? Kubernetes Story](https://faun.pub/kubernetes-story-linux-namespaces-and-cgroups-what-are-containers-made-from-d544ac9bd622)
- [Understanding Docker Containers: Leveraging Linux Kernels, Namespaces, and Cgroups](https://dev.to/mochafreddo/understanding-docker-containers-leveraging-linux-kernels-namespaces-and-cgroups-4fkk)
- [LXC vs Docker: What’s the Difference?](https://www.docker.com/blog/lxc-vs-docker/#:~:text=Docker%20is%20designed%20for%20developers,the%20operating%20system%20and%20hardware.)
- [The Evolution of Docker Containers](https://www.baeldung.com/linux/docker-containers-evolution)
- [Docker Documentation](https://docs.docker.com/)

All generated content has been reviewed and understood.

## 🎯 Learning Outcomes
- Docker containerization
- Multi-service orchestration
- Networking between containers
- Secure infrastructure setup
- DevOps fundamentals

#👤 Author

**Login**: maelmahf