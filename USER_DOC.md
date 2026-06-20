Here are clean **ready-to-use templates** for your project documentation (42 Inception-style). You can directly copy them into your repo.

---

# 📘 USER_DOC.md

## 🧭 Overview

This project is a Docker-based infrastructure composed of multiple services:

* 🌐 NGINX (reverse proxy + HTTPS)
* 📝 WordPress (CMS website)
* 🐬 MariaDB (database)

All services run in isolated containers and communicate through a Docker network.

---

## 🚀 Start the Project

To start the entire stack:

```bash
make up
```

or:

```bash
docker compose -f srcs/docker-compose.yml up -d
```

---

## 🛑 Stop the Project

To stop all services:

```bash
make down
```

or:

```bash
docker compose down
```

---

## 🌍 Access the Website

Once running:

* Website:

  ```
  https://<your-domain>
  ```

* WordPress admin panel:

  ```
  https://<your-domain>/wp-admin
  ```

---

## 🔐 Credentials Management

All credentials are stored in the `.env` file located in:

```
srcs/.env
```

It contains:

* Database name
* Database user
* Database password
* WordPress admin credentials
* Domain name

⚠️ Never commit `.env` to Git.

---

## 🩺 Check Services Status

To verify running containers:

```bash
docker ps
```

To check logs:

```bash
make logs
```

or:

```bash
docker compose logs -f
```

---

## 📊 Verify Everything is Working

You can confirm the system is working by checking:

* NGINX responds on port 443 (HTTPS)
* WordPress homepage loads
* Database container is running
* No errors in logs