# 🐳 Docker - Usage Guide

This guide explains how to use Docker to serve GymPal documentation.

## 📋 Prerequisites

- Docker installed (version 20.10 or higher)
- Docker Compose installed (version 2.0 or higher)
- Or access to a system with Docker installed

## 🚀 Quick Start

### Method 1: Docker Compose (Recommended)

```bash
# Build and start the container
docker-compose up -d

# View logs
docker-compose logs -f

# Stop the server
docker-compose down
```

### Method 2: Docker Direct

```bash
# Build the image
docker build -t gympal-docs .

# Run the container
docker run -d -p 3000:3000 --name gympal-docs gympal-docs

# View logs
docker logs -f gympal-docs

# Stop and remove
docker stop gympal-docs
docker rm gympal-docs
```

### Method 3: NPM Scripts

```bash
# Build
npm run docker:build

# Start with Docker Compose
npm run docker:up

# View logs
npm run docker:logs:compose

# Stop
npm run docker:down
```

## 🌐 Access

Once started, the documentation will be available at:

**http://localhost:3000**

## 📁 Project Structure

```
PTI-GymPalDoc/
├── Dockerfile              # Docker configuration
├── docker-compose.yml      # Docker Compose configuration
├── .dockerignore          # Files ignored in build
├── index.html             # Docsify configuration
├── _sidebar.md            # Sidebar navigation
└── docs/                  # Markdown documentation
```

## 🔧 Configuration

### Change the Port

If port 3000 is occupied, edit `docker-compose.yml`:

```yaml
ports:
  - "8080:3000"  # Change 8080 to the port you want
```

### Development with Auto-Reload

To see changes in real-time during development, uncomment the `volumes` lines in `docker-compose.yml`:

```yaml
volumes:
  - ./docs:/usr/share/nginx/html/docs:ro
  - ./index.html:/usr/share/nginx/html/index.html:ro
  - ./_sidebar.md:/usr/share/nginx/html/_sidebar.md:ro
```

**Note:** With Nginx, changes may require a manual browser refresh.

## 🛠️ Useful Commands

### Check Status

```bash
# View running containers
docker ps | grep gympal-docs

# View logs in real-time
docker-compose logs -f docs

# View container status
docker-compose ps
```

### Rebuild Image

If you've made changes to configuration files:

```bash
# Stop
docker-compose down

# Rebuild and start
docker-compose up -d --build
```

### Execute Commands in Container

```bash
# Access container shell
docker exec -it gympal-docs sh

# View Nginx configuration
docker exec gympal-docs cat /etc/nginx/conf.d/default.conf
```

### Verify Health Check

```bash
# View health check status
docker inspect gympal-docs | grep -A 10 Health
```

## 🐛 Troubleshooting

### Error: Port already in use

```bash
# See what process uses port 3000
# On Windows (WSL)
netstat -ano | findstr :3000

# Stop the process or change the port in docker-compose.yml
```

### Error: Files cannot be found

Verify that all required files exist:
- `index.html`
- `_sidebar.md`
- `docs/` (directory with documentation)

### Changes not reflected

1. Make sure you've rebuilt the image:
   ```bash
   docker-compose up -d --build
   ```

2. If using volumes, verify they're mounted correctly

3. Clear browser cache (Ctrl+Shift+R)

### View Nginx logs

```bash
docker exec gympal-docs tail -f /var/log/nginx/error.log
```

## 📦 Docker Image

The Docker image is based on `nginx:alpine`, which is:
- ✅ Lightweight (only ~23MB base size)
- ✅ Fast
- ✅ Secure
- ✅ Perfect for serving static content

## 🔒 Security

The container includes:
- Security headers configured
- Gzip compression enabled
- Cache for static files
- Health check configured

## 📝 Notes

- Documentation is served as static files
- Docsify renders Markdowns in the client (browser)
- Mermaid diagrams are processed in the browser
- Node.js is not required in the container (only Nginx)

## 🆘 Support

If you have problems:
1. Check logs: `docker-compose logs docs`
2. Verify Docker is running: `docker ps`
3. Rebuild image: `docker-compose up -d --build`

---

**Enjoy your documentation! 📚**