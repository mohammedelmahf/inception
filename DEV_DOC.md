
# 🧑‍💻 DEV_DOC.md

## ⚙️ Prerequisites

Before starting, ensure you have:

* Docker
* Docker Compose
* Make
* Linux environment (recommended for 42 projects)

---

## 📁 Project Structure

```
srcs/
 ├── docker-compose.yml
 ├── .env
 ├── requirements/
 │    ├── nginx/
 │    ├── wordpress/
 │    └── mariadb/
Makefile
```

---

## 🔧 Environment Setup

1. Clone the repository:

```bash
git clone <repo_url>
cd <project>
```

2. Configure environment variables:

```bash
nano srcs/.env
```

Example:

```
DOMAIN_NAME=yourdomain.com
MYSQL_DATABASE=wordpress
MYSQL_USER=wp_user
MYSQL_PASSWORD=wp_pass
MYSQL_ROOT_PASSWORD=root_pass
```

---

## 🏗️ Build & Launch

To build and start everything:

```bash
make
```

This runs:

* image build
* network creation
* container startup

---

## 🐳 Docker Commands

Build images:

```bash
make build
```

Start containers:

```bash
make up
```

Stop containers:

```bash
make down
```

Rebuild everything:

```bash
make re
```

View running containers:

```bash
docker ps
```

View logs:

```bash
make logs
```

---

## 💾 Data Persistence

The project uses Docker volumes to persist data:

| Service   | Volume Path      |
| --------- | ---------------- |
| MariaDB   | `/var/lib/mysql` |
| WordPress | `/var/www/html`  |

Data is stored on the host in:

```
~/data/
 ├── mariadb/
 └── wordpress/
```

These directories ensure data survives container restarts.

---

## 🔄 Rebuild from Scratch

To reset everything:

```bash
make fclean
```

Then:

```bash
make
```

---

## 🧠 Notes for Developers

* Each service runs in its own container
* NGINX acts as reverse proxy
* WordPress depends on MariaDB
* All services communicate via Docker network
* No direct host dependency except volumes
