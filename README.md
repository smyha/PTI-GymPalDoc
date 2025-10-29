# PTI-GymPalDoc 📚

Complete technical documentation repository for the **GymPal** project - Social fitness platform with integrated artificial intelligence.

## 📋 **Repository Content**

This repository contains the complete technical documentation for the GymPal project, organized in a structured way to facilitate navigation and maintenance.

## 🌐 **Web Documentation**

This documentation can be viewed in a web interface using Docker.

### **Quick Start with Docker**

#### Option 1: Using Docker Compose (Recommended)

```bash
# Build and start the documentation server
docker-compose up -d

# View logs
docker-compose logs -f

# Stop the server
docker-compose down
```

The documentation will be available at: **http://localhost:3000**

#### Option 2: Using Docker directly

```bash
# Build the Docker image
docker build -t gympal-docs .

# Run the container
docker run -d -p 3000:3000 --name gympal-docs gympal-docs

# Stop the container
docker stop gympal-docs
docker rm gympal-docs
```

Then open: **http://localhost:3000**

## 🔧 **Repository Usage**

```bash
# Clone the repository
git clone https://github.com/username/PTI-GymPalDoc.git
cd PTI-GymPalDoc

# View complete documentation
open GYMPAL.md

# View HTML documentation
open GYMPAL.html

# Navigate structured documentation
cd docs/
open 00-index.md
```

### **For Stakeholders**
- **Executive Summary**: `docs/executive-summary.md`
- **General Architecture**: `docs/architecture/`
- **Project Progress**: `docs/team/`

## 📄 **License**

This project is under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

**Powered by Docsify** 🌟