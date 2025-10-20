# 1. Project Vision and Scope 🏗️

## Vision
GymPal is a web application (with desktop option via Electron) to manage training and nutrition in a personalized way. Users can generate workout plans and diets tailored to their body type, goals, and pace; share posts with routines, achievements, and recommendations; interact with other users through ratings and comments; and receive help from an AI chatbot and an active recommendation engine.

## Key Objectives
- **Intelligent generation** of personalized workout and diet plans.
- **Fitness social network**: posts, comments, likes, and profile following.
- **AI chatbot** available in the web app per session and as an automated chatbot (n8n) on Telegram/WhatsApp/Gmail.
- **Recommendation system** (Dify AI) for users, workouts, diets, and content.
- **Scalable and secure architecture** with microservices, CI/CD, and observability.

## Academic Requirements and Scope (5 months, 5 IT students)
- Client-server; REST APIs; microservice patterns; Docker containers; Kubernetes.
- Security: OAuth2/OIDC, JWT, HTTPS, Policies, TLS Secrets.
- Integration of external APIs and workflow orchestration with n8n.
- GitOps with ArgoCD; monitoring with Prometheus + Grafana + Promtail.
- Transactional email with Proton Mail; complete technical documentation.
- AI Integration: Chatbot and recommendations with Dify AI; LLM for scheduled generation.
- Optional blockchain service for achievement certification or evidence stamping.

## Main Use Cases

```mermaid
graph TB
  subgraph "Fitness User"
    UC1[Register and configure profile]
    UC2[Generate personalized training plan]
    UC3[Track progress and log training]
    UC4[Generate nutrition plan]
    UC5[Interact with AI chatbot]
  end
  
  subgraph "Social Network"
    UC6[Post achievements and routines]
    UC7[Follow other users]
    UC8[Comment and like]
    UC9[Receive notifications]
  end
  
  subgraph "Administration"
    UC10[Moderate content]
    UC11[Manage users]
    UC12[Monitor metrics]
  end
  
  subgraph "AI and Recommendations"
    UC13[Receive personalized recommendations]
    UC14[Contextual chat with AI]
    UC15[Automatic plan generation]
  end
```

## High-Level Architecture Diagram

```mermaid
graph TB
  subgraph "Frontend"
    WEB[Web App - React/Next.js]
    MOBILE[Mobile App - React Native]
    DESKTOP[Desktop App - Electron]
  end
  
  subgraph "API Gateway"
    GATEWAY[Kong/NGINX Gateway]
  end
  
  subgraph "Backend Services"
    AUTH[Auth Service]
    USER[User Service]
    WORKOUT[Workout Service]
    SOCIAL[Social Service]
    AI[AI Service]
    NOTIF[Notification Service]
  end
  
  subgraph "Data Layer"
    DB[(PostgreSQL)]
    REDIS[(Redis Cache)]
    FILES[File Storage]
  end
  
  subgraph "External Services"
    DIFY[Dify AI Platform]
    N8N[n8n Workflow Engine]
    EMAIL[Proton Mail]
  end
  
  WEB --> GATEWAY
  MOBILE --> GATEWAY
  DESKTOP --> GATEWAY
  
  GATEWAY --> AUTH
  GATEWAY --> USER
  GATEWAY --> WORKOUT
  GATEWAY --> SOCIAL
  GATEWAY --> AI
  GATEWAY --> NOTIF
  
  AUTH --> DB
  USER --> DB
  WORKOUT --> DB
  SOCIAL --> DB
  AI --> DB
  
  AUTH --> REDIS
  USER --> REDIS
  WORKOUT --> REDIS
  SOCIAL --> REDIS
  
  AI --> DIFY
  NOTIF --> N8N
  NOTIF --> EMAIL
```

## Main User Flow

```mermaid
sequenceDiagram
  participant U as User
  participant F as Frontend
  participant G as Gateway
  participant A as Auth Service
  participant W as Workout Service
  participant AI as AI Service
  participant DB as Database
  
  U->>F: Register/Login
  F->>G: POST /auth/login
  G->>A: Validate credentials
  A->>DB: Verify user
  A-->>G: JWT Token
  G-->>F: Token + User Info
  F-->>U: Main dashboard
  
  U->>F: Request personalized workout
  F->>G: POST /workouts/generate
  G->>W: Process request
  W->>AI: Generate workout with AI
  AI-->>W: Personalized workout
  W->>DB: Save workout
  W-->>G: Workout generated
  G-->>F: Workout data
  F-->>U: Show workout
```

## System Component Diagram

```mermaid
graph LR
  subgraph "Presentation Layer"
    UI[User Interface]
    API_CLIENT[API Client]
  end
  
  subgraph "Business Logic Layer"
    AUTH_LOGIC[Authentication Logic]
    WORKOUT_LOGIC[Workout Logic]
    SOCIAL_LOGIC[Social Logic]
    AI_LOGIC[AI Logic]
  end
  
  subgraph "Data Access Layer"
    ORM[ORM/Query Builder]
    CACHE[Cache Manager]
    FILE_MGR[File Manager]
  end
  
  subgraph "Infrastructure Layer"
    DB[(Database)]
    REDIS[(Redis)]
    STORAGE[File Storage]
    EXTERNAL[External APIs]
  end
  
  UI --> API_CLIENT
  API_CLIENT --> AUTH_LOGIC
  API_CLIENT --> WORKOUT_LOGIC
  API_CLIENT --> SOCIAL_LOGIC
  API_CLIENT --> AI_LOGIC
  
  AUTH_LOGIC --> ORM
  WORKOUT_LOGIC --> ORM
  SOCIAL_LOGIC --> ORM
  AI_LOGIC --> ORM
  
  ORM --> DB
  AUTH_LOGIC --> CACHE
  WORKOUT_LOGIC --> CACHE
  SOCIAL_LOGIC --> CACHE
  
  CACHE --> REDIS
  FILE_MGR --> STORAGE
  AI_LOGIC --> EXTERNAL
```
