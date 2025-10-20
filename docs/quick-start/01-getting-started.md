# GymPal - Quick Start Guide

## 🚀 **Start in 5 Minutes**

This guide will let you have GymPal running locally in less than 5 minutes.

---

## 📋 **Prerequisites**

### Required Software
- **Node.js**: 20+ (recommended: 20 LTS)
- **Docker**: 24+ with Docker Compose
- **Git**: 2.40+
- **Supabase CLI**: 1.100+ (optional)

### Required Accounts
- [Supabase](https://supabase.com) (free)
- [Dify AI](https://dify.ai) (free)
- [GitHub](https://github.com) (for CI/CD)

---

## ⚡ **Quick Installation**

### 1. Clone the Repository
```bash
git clone https://github.com/gympal/gympal.git
cd gympal
```

### 2. Configure Environment Variables
```bash
# Copy example files
cp backend/.env.example backend/.env
cp frontend/.env.example frontend/.env

# Edit variables (use your own keys)
nano backend/.env
nano frontend/.env
```

### 3. Start with Docker Compose
```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f
```

### 4. Verify Installation
```bash
# Frontend: http://localhost:3000
# Backend: http://localhost:3001
# API Docs: http://localhost:3001/docs
```

---

## 🔧 **Detailed Configuration**

### Minimum Environment Variables

#### Backend (.env)
```bash
# Supabase (required)
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your_anon_key
SUPABASE_SERVICE_ROLE_KEY=your_service_role_key

# JWT (required)
JWT_SECRET=your_super_secret_jwt_key_here

# Dify AI (optional for AI)
DIFY_API_KEY=your_dify_api_key
DIFY_BASE_URL=https://api.dify.ai

# Server
PORT=3001
NODE_ENV=development
```

#### Frontend (.env.local)
```bash
# Supabase (required)
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_anon_key

# API (required)
NEXT_PUBLIC_API_URL=http://localhost:3001
```

---

## 🗄️ **Database Configuration**

### Option 1: Supabase Cloud (Recommended)
1. Create a project at [Supabase](https://supabase.com)
2. Run migrations:
```bash
# Install Supabase CLI
npm install -g supabase

# Initialize project
supabase init

# Link with your project
supabase link --project-ref your-project-ref

# Run migrations
supabase db push
```

### Option 2: Local Supabase
```bash
# Start local Supabase
supabase start

# Apply migrations
supabase db reset
```

---

## 🧪 **Running Tests**

### Unit Tests
```bash
# Backend
cd backend
npm test

# Frontend
cd frontend
npm test
```

### E2E Tests
```bash
# Install Playwright
npx playwright install

# Run E2E tests
npm run test:e2e
```

---

## 🐛 **Common Troubleshooting**

### Error: "Cannot connect to database"
```bash
# Check that Supabase is running
curl https://your-project.supabase.co/rest/v1/

# Check environment variables
echo $SUPABASE_URL
echo $SUPABASE_ANON_KEY
```

### Error: "JWT_SECRET is required"
```bash
# Generate JWT secret
openssl rand -base64 32

# Add to .env
echo "JWT_SECRET=your_generated_secret" >> backend/.env
```

### Error: "Port 3000 already in use"
```bash
# Find process using the port
lsof -i :3000

# Kill process
kill -9 <PID>

# Or use another port
PORT=3002 npm run dev
```

### Error: "Docker not running"
```bash
# Start Docker
sudo systemctl start docker

# Check status
docker --version
docker-compose --version
```

---

## 📱 **First Steps**

### 1. Create User
```bash
# Use API directly
curl -X POST http://localhost:3001/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@gympal.com",
    "password": "password123",
    "name": "Test User"
  }'
```

### 2. Log In
```bash
curl -X POST http://localhost:3001/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@gympal.com",
    "password": "password123"
  }'
```

### 3. Create Workout
```bash
# Use JWT token from login
curl -X POST http://localhost:3001/api/workouts \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -d '{
    "name": "Push Day",
    "description": "Chest, shoulders, triceps",
    "exercises": [
      {
        "name": "Bench Press",
        "sets": 3,
        "reps": 10,
        "weight": 135
      }
    ]
  }'
```

---

## 🎯 **Available Features**

### ✅ Implemented
- [x] Authentication (register/login)
- [x] User CRUD
- [x] Workout CRUD
- [x] Full REST API
- [x] OpenAPI Documentation
- [x] Unit tests
- [x] Docker Compose

### 🚧 In Progress
- [ ] Social features
- [ ] AI integration
- [ ] Push notifications
- [ ] E2E tests

---

## 📚 **Additional Resources**

### Documentation
- [Architecture](./architecture/01-vision-and-scope.md)
- [API Reference](./api/01-api-endpoints.md)
- [Database](./database/01-database-schema.md)
- [Configuration](./configuration/01-project-config.md)

### Tools
- [Postman Collection](./api/postman-collection.json)
- [OpenAPI Spec](./api/openapi.yaml)
- [Docker Compose](./docker-compose.yml)

### Community
- [GitHub Issues](https://github.com/gympal/gympal/issues)
- [Discord](https://discord.gg/gympal)
- [Documentation](https://docs.gympal.app)

---

## 🆘 **Support**

### Need Help?
1. **Check logs**: `docker-compose logs -f`
2. **Check status**: `docker-compose ps`
3. **Restart services**: `docker-compose restart`
4. **Clean all**: `docker-compose down -v && docker-compose up -d`


---

## 🎉 **Done!**

If you made it this far, congratulations! You have GymPal running locally.

### Next Steps
1. Explore the API at http://localhost:3001/docs
2. Create your first workout
3. Invite your friends
4. Contribute to the project

### Want to Contribute?
1. Fork the repository
2. Create a feature branch
3. Make changes
4. Create a Pull Request

---

**Welcome to GymPal! 💪**

---

**Setup time**: ~5 minutes
