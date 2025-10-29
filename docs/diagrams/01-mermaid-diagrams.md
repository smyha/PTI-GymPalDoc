# Mermaid Diagrams - GymPal 🎨

## 📊 **Diagrams Index**

This document contains all Mermaid diagrams used in the GymPal documentation, organized by categories for easy navigation.

---

## 🏗️ **System Architecture**

### 1. General Architecture
```mermaid
graph TB
  subgraph "Frontend Layer"
    WEB[Next.js Web App]
    MOBILE[PWA Mobile]
  end
  
  subgraph "API Gateway"
    GATEWAY[Hono API Gateway]
    AUTH[Auth Middleware]
    RATE[Rate Limiting]
  end
  
  subgraph "Microservices"
    USER[User Service]
    WORKOUT[Workout Service]
    SOCIAL[Social Service]
    AI[AI Service]
  end
  
  subgraph "Data Layer"
    DB[(Supabase PostgreSQL)]
    STORAGE[(File Storage)]
    CACHE[(Redis Cache)]
  end
  
  subgraph "External Services"
    DIFY[Dify AI Platform]
    N8N[n8n Workflows]
    EMAIL[Email Service]
  end
  
  WEB --> GATEWAY
  MOBILE --> GATEWAY
  GATEWAY --> AUTH
  AUTH --> RATE
  RATE --> USER
  RATE --> WORKOUT
  RATE --> SOCIAL
  RATE --> AI
  
  USER --> DB
  WORKOUT --> DB
  SOCIAL --> DB
  AI --> DIFY
  SOCIAL --> N8N
  USER --> EMAIL
  
  DB --> STORAGE
  DB --> CACHE
```

### 2. Microservices Architecture
```mermaid
graph TB
  subgraph "API Gateway"
    GATEWAY[Hono Gateway]
    MIDDLEWARE[Middleware Stack]
  end
  
  subgraph "Core Services"
    AUTH[Auth Service]
    USER[User Service]
    WORKOUT[Workout Service]
    SOCIAL[Social Service]
  end
  
  subgraph "Support Services"
    AI[AI Service]
    NOTIFICATION[Notification Service]
    MEDIA[Media Service]
  end
  
  subgraph "Data Services"
    DB[(PostgreSQL)]
    REDIS[(Redis)]
    STORAGE[(File Storage)]
  end
  
  GATEWAY --> MIDDLEWARE
  MIDDLEWARE --> AUTH
  MIDDLEWARE --> USER
  MIDDLEWARE --> WORKOUT
  MIDDLEWARE --> SOCIAL
  MIDDLEWARE --> AI
  MIDDLEWARE --> NOTIFICATION
  MIDDLEWARE --> MEDIA
  
  AUTH --> DB
  USER --> DB
  WORKOUT --> DB
  SOCIAL --> DB
  AI --> DB
  NOTIFICATION --> REDIS
  MEDIA --> STORAGE
```

---

## 🗄️ **Database**

### 1. Main ER Diagram - Core Entities
```mermaid
erDiagram
    USERS {
        uuid id PK
        string email UK
        string username UK
        string full_name
        string avatar_url
        string bio
        string fitness_level
        timestamp created_at
        timestamp updated_at
        boolean is_verified
        boolean is_active
    }
    
    WORKOUTS {
        uuid id PK
        uuid user_id FK
        string name
        text description
        string difficulty
        integer duration_minutes
        string equipment_needed
        json exercises
        boolean is_public
        timestamp created_at
        timestamp updated_at
    }
    
    WORKOUT_SESSIONS {
        uuid id PK
        uuid user_id FK
        uuid workout_id FK
        timestamp started_at
        timestamp completed_at
        integer duration_minutes
        json performance_data
        text notes
        boolean is_completed
    }
    
    EXERCISES {
        uuid id PK
        string name
        string category
        string muscle_groups
        string equipment
        text instructions
        json variations
        boolean is_custom
        uuid created_by FK
    }
    
    POSTS {
        uuid id PK
        uuid user_id FK
        string content
        string post_type
        uuid workout_id FK
        json media_urls
        json hashtags
        integer likes_count
        integer comments_count
        integer shares_count
        boolean is_public
        timestamp created_at
        timestamp updated_at
    }
    
    COMMENTS {
        uuid id PK
        uuid post_id FK
        uuid user_id FK
        text content
        uuid parent_comment_id FK
        integer likes_count
        timestamp created_at
        timestamp updated_at
    }
    
    FOLLOWS {
        uuid id PK
        uuid follower_id FK
        uuid following_id FK
        timestamp created_at
    }
    
    LIKES {
        uuid id PK
        uuid user_id FK
        uuid post_id FK
        timestamp created_at
    }
    
    NOTIFICATIONS {
        uuid id PK
        uuid user_id FK
        string type
        string title
        text content
        json data
        boolean is_read
        timestamp created_at
    }
    
    USERS ||--o{ WORKOUTS : "creates"
    USERS ||--o{ WORKOUT_SESSIONS : "performs"
    USERS ||--o{ POSTS : "creates"
    USERS ||--o{ COMMENTS : "writes"
    USERS ||--o{ FOLLOWS : "follows"
    USERS ||--o{ LIKES : "likes"
    USERS ||--o{ NOTIFICATIONS : "receives"
    
    WORKOUTS ||--o{ WORKOUT_SESSIONS : "tracked_in"
    WORKOUTS ||--o{ POSTS : "featured_in"
    WORKOUTS ||--o{ EXERCISES : "contains"
    
    POSTS ||--o{ COMMENTS : "has"
    POSTS ||--o{ LIKES : "receives"
    
    COMMENTS ||--o{ COMMENTS : "replies_to"
    
    EXERCISES ||--o{ WORKOUTS : "included_in"
```

### 2. Detailed Database Schema
```mermaid
graph TB
  subgraph "Core Tables"
    USERS[Users]
    WORKOUTS[Workouts]
    EXERCISES[Exercises]
    SESSIONS[Workout Sessions]
  end
  
  subgraph "Social Tables"
    POSTS[Posts]
    COMMENTS[Comments]
    LIKES[Likes]
    FOLLOWS[Follows]
  end
  
  subgraph "Support Tables"
    NOTIFICATIONS[Notifications]
    MEDIA[Media]
    CATEGORIES[Categories]
    TAGS[Tags]
  end
  
  subgraph "Relationships"
    R1[User creates Workouts]
    R2[User performs Sessions]
    R3[Workout contains Exercises]
    R4[User creates Posts]
    R5[Post has Comments]
    R6[User follows User]
  end
  
  USERS --> R1
  R1 --> WORKOUTS
  USERS --> R2
  R2 --> SESSIONS
  WORKOUTS --> R3
  R3 --> EXERCISES
  
  USERS --> R4
  R4 --> POSTS
  POSTS --> R5
  R5 --> COMMENTS
  USERS --> R6
  R6 --> USERS
```

---

## 🔄 **Communication Flows**

### 1. Authentication Flow
```mermaid
sequenceDiagram
  participant U as User
  participant F as Frontend
  participant A as Auth Service
  participant D as Database
  participant S as Supabase Auth
  
  U->>F: Login credentials
  F->>A: POST /api/auth/login
  A->>S: Verify credentials
  S->>A: JWT token
  A->>D: Update user session
  A->>F: Return token + user data
  F->>U: Redirect to dashboard
```

### 2. Workout Creation Flow
```mermaid
sequenceDiagram
  participant U as User
  participant F as Frontend
  participant W as Workout Service
  participant D as Database
  participant AI as AI Service
  
  U->>F: Create workout form
  F->>W: POST /api/workouts
  W->>AI: Get exercise recommendations
  AI->>W: Return exercises
  W->>D: Save workout
  D->>W: Confirm save
  W->>F: Return workout data
  F->>U: Show success message
```

### 3. Social Feed Flow
```mermaid
sequenceDiagram
  participant U as User
  participant F as Frontend
  participant S as Social Service
  participant D as Database
  participant C as Cache
  
  U->>F: Load feed
  F->>S: GET /api/social/feed
  S->>C: Check cache
  alt Cache hit
    C->>S: Return cached data
  else Cache miss
    S->>D: Query posts
    D->>S: Return posts
    S->>C: Update cache
  end
  S->>F: Return feed data
  F->>U: Display feed
```

---

## 🎯 **System States**

### 1. User States
```mermaid
stateDiagram-v2
  [*] --> Unauthenticated
  Unauthenticated --> Authenticating : Login
  Authenticating --> Authenticated : Success
  Authenticating --> Unauthenticated : Failed
  Authenticated --> ProfileSetup : First time
  ProfileSetup --> Active : Complete
  Active --> Inactive : Logout
  Inactive --> Authenticated : Login
  Active --> [*] : Delete account
```

### 2. Workout States
```mermaid
stateDiagram-v2
  [*] --> Draft
  Draft --> Published : Publish
  Draft --> Archived : Archive
  Published --> Draft : Edit
  Published --> Archived : Archive
  Archived --> Draft : Restore
  Published --> [*] : Delete
  Archived --> [*] : Delete
```

### 3. Post States
```mermaid
stateDiagram-v2
  [*] --> Creating
  Creating --> Published : Success
  Creating --> Draft : Save as draft
  Draft --> Published : Publish
  Draft --> [*] : Delete
  Published --> Hidden : Hide
  Hidden --> Published : Unhide
  Published --> [*] : Delete
```

---

## 🚀 **DevOps and Deployment**

### 1. Pipeline CI/CD
```mermaid
graph LR
  A[Code Push] --> B[GitHub Actions]
  B --> C[Run Tests]
  C --> D[Build Images]
  D --> E[Push to Registry]
  E --> F[Deploy to K8s]
  F --> G[Health Check]
  G --> H[Update Status]
```

### 2. Deployment Strategy
```mermaid
graph TB
  subgraph "Development"
    DEV[Developer]
    GIT[Git Repository]
    FEATURES[Feature Branches]
  end
  
  subgraph "CI/CD"
    GITHUB[GitHub Actions]
    BUILD[Build Stage]
    TEST[Test Stage]
    DEPLOY[Deploy Stage]
  end
  
  subgraph "Infrastructure"
    K8S[Kubernetes]
    ARGOCD[ArgoCD]
    HELM[Helm Charts]
  end
  
  subgraph "Production"
    LB[Load Balancer]
    CDN[CDN]
    MONITOR[Health Monitoring]
  end
  
  DEV --> GIT
  GIT --> FEATURES
  FEATURES --> GITHUB
  GITHUB --> BUILD
  BUILD --> TEST
  TEST --> DEPLOY
  DEPLOY --> K8S
  K8S --> ARGOCD
  ARGOCD --> HELM
  K8S --> LB
  LB --> CDN
  CDN --> MONITOR
```

### 3. ArgoCD Deployment Flow
```mermaid
sequenceDiagram
  participant DEV as Developer
  participant GIT as Git Repository
  participant CI as CI/CD Pipeline
  participant REG as Container Registry
  participant ARGO as ArgoCD
  participant K8S as Kubernetes
  
  DEV->>GIT: Push code
  GIT->>CI: Trigger pipeline
  CI->>CI: Run tests
  CI->>CI: Build images
  CI->>REG: Push images
  CI->>ARGO: Update application
  ARGO->>K8S: Deploy to cluster
  K8S->>DEV: Notify deployment status
```

---

## 🔐 **Security**

### 1. Authentication and Authorization Flow
```mermaid
sequenceDiagram
  participant U as User
  participant F as Frontend
  participant B as Backend
  participant A as Auth Service
  participant D as Database
  
  U->>F: Login credentials
  F->>B: POST /api/auth/login
  B->>A: Validate credentials
  A->>D: Check user exists
  D->>A: Return user data
  A->>A: Generate JWT
  A->>B: Return JWT + user
  B->>F: Return auth response
  F->>U: Store token + redirect
```

### 2. Authorization Flow
```mermaid
sequenceDiagram
  participant U as User
  participant F as Frontend
  participant B as Backend
  participant M as Middleware
  participant S as Service
  
  U->>F: Request protected resource
  F->>B: API call with JWT
  B->>M: Validate JWT
  M->>M: Check permissions
  M->>S: Authorized request
  S->>B: Return data
  B->>F: Return response
  F->>U: Display data
```

---

## 🧪 **Testing**

### 1. Testing Strategy
```mermaid
graph TB
  subgraph "Unit Tests"
    UT_FRONTEND[Frontend Unit Tests]
    UT_BACKEND[Backend Unit Tests]
    UT_UTILS[Utility Tests]
  end
  
  subgraph "Integration Tests"
    IT_API[API Integration Tests]
    IT_DB[Database Tests]
    IT_AUTH[Auth Integration Tests]
  end
  
  subgraph "E2E Tests"
    E2E_USER[User Journey Tests]
    E2E_WORKFLOW[Workflow Tests]
    E2E_SOCIAL[Social Feature Tests]
  end
  
  subgraph "Performance Tests"
    PT_LOAD[Load Tests]
    PT_STRESS[Stress Tests]
    PT_BENCHMARK[Benchmark Tests]
  end
  
  UT_FRONTEND --> IT_API
  UT_BACKEND --> IT_DB
  UT_UTILS --> IT_AUTH
  
  IT_API --> E2E_USER
  IT_DB --> E2E_WORKFLOW
  IT_AUTH --> E2E_SOCIAL
  
  E2E_USER --> PT_LOAD
  E2E_WORKFLOW --> PT_STRESS
  E2E_SOCIAL --> PT_BENCHMARK
```

### 2. Testing Flow
```mermaid
graph LR
  A[Code Change] --> B[Unit Tests]
  B --> C[Integration Tests]
  C --> D[E2E Tests]
  D --> E[Performance Tests]
  E --> F[Deploy to Staging]
  F --> G[Manual Testing]
  G --> H[Deploy to Production]
```

---

## 📱 **Frontend Architecture**

### 1. Components Architecture
```mermaid
graph TB
  subgraph "Pages"
    HOME[Home Page]
    DASHBOARD[Dashboard]
    WORKOUTS[Workouts]
    SOCIAL[Social Feed]
    PROFILE[Profile]
  end
  
  subgraph "Components"
    HEADER[Header]
    SIDEBAR[Sidebar]
    WORKOUT_CARD[Workout Card]
    POST_CARD[Post Card]
    USER_CARD[User Card]
  end
  
  subgraph "Hooks"
    USE_AUTH[useAuth]
    USE_WORKOUTS[useWorkouts]
    USE_SOCIAL[useSocial]
    USE_AI[useAI]
  end
  
  subgraph "Stores"
    AUTH_STORE[Auth Store]
    WORKOUT_STORE[Workout Store]
    SOCIAL_STORE[Social Store]
    UI_STORE[UI Store]
  end
  
  HOME --> HEADER
  DASHBOARD --> SIDEBAR
  WORKOUTS --> WORKOUT_CARD
  SOCIAL --> POST_CARD
  PROFILE --> USER_CARD
  
  HEADER --> USE_AUTH
  WORKOUT_CARD --> USE_WORKOUTS
  POST_CARD --> USE_SOCIAL
  
  USE_AUTH --> AUTH_STORE
  USE_WORKOUTS --> WORKOUT_STORE
  USE_SOCIAL --> SOCIAL_STORE
```

### 2. State Flow
```mermaid
graph TB
  subgraph "User Actions"
    LOGIN[Login]
    CREATE_WORKOUT[Create Workout]
    LIKE_POST[Like Post]
    FOLLOW_USER[Follow User]
  end
  
  subgraph "State Updates"
    AUTH_UPDATE[Auth State Update]
    WORKOUT_UPDATE[Workout State Update]
    SOCIAL_UPDATE[Social State Update]
    UI_UPDATE[UI State Update]
  end
  
  subgraph "Side Effects"
    API_CALL[API Call]
    CACHE_UPDATE[Cache Update]
    NOTIFICATION[Notification]
    ROUTE_CHANGE[Route Change]
  end
  
  LOGIN --> AUTH_UPDATE
  CREATE_WORKOUT --> WORKOUT_UPDATE
  LIKE_POST --> SOCIAL_UPDATE
  FOLLOW_USER --> SOCIAL_UPDATE
  
  AUTH_UPDATE --> API_CALL
  WORKOUT_UPDATE --> CACHE_UPDATE
  SOCIAL_UPDATE --> NOTIFICATION
  UI_UPDATE --> ROUTE_CHANGE
```

---

## 🤖 **AI Integration**

### 1. Flujo de IA
```mermaid
sequenceDiagram
  participant U as User
  participant F as Frontend
  participant B as Backend
  participant AI as Dify AI
  participant DB as Database
  
  U->>F: Ask question
  F->>B: POST /api/ai/chat
  B->>DB: Get user context
  DB->>B: Return user data
  B->>AI: Send query + context
  AI->>B: Return response
  B->>F: Return AI response
  F->>U: Display response
```

### 2. Sistema de Recomendaciones
```mermaid
graph TB
  subgraph "Data Collection"
    USER_DATA[User Data]
    WORKOUT_DATA[Workout Data]
    INTERACTION_DATA[Interaction Data]
  end
  
  subgraph "AI Processing"
    CONTEXT_BUILDER[Context Builder]
    RECOMMENDATION_ENGINE[Recommendation Engine]
    PERSONALIZATION[Personalization]
  end
  
  subgraph "Output"
    WORKOUT_RECS[Workout Recommendations]
    EXERCISE_RECS[Exercise Recommendations]
    NUTRITION_RECS[Nutrition Recommendations]
  end
  
  USER_DATA --> CONTEXT_BUILDER
  WORKOUT_DATA --> CONTEXT_BUILDER
  INTERACTION_DATA --> CONTEXT_BUILDER
  
  CONTEXT_BUILDER --> RECOMMENDATION_ENGINE
  RECOMMENDATION_ENGINE --> PERSONALIZATION
  
  PERSONALIZATION --> WORKOUT_RECS
  PERSONALIZATION --> EXERCISE_RECS
  PERSONALIZATION --> NUTRITION_RECS
```

---

## 📊 **Diagrams Summary**

### Diagram Categories
- **Architecture**: 3 diagrams
- **Database**: 2 diagrams
- **Communication Flows**: 3 diagrams
- **System States**: 3 diagrams
- **DevOps**: 3 diagrams
- **Security**: 2 diagrams
- **Testing**: 2 diagrams
- **Frontend**: 2 diagrams
- **AI Integration**: 2 diagrams

### Total: 22 Diagrams

---

## 🎯 **How to Use the Diagrams**

### For Developers
- **Architecture**: Understand the system structure
- **Flows**: Understand interactions
- **States**: Manage business logic
- **Testing**: Design test cases

### For DevOps
- **Deployment**: Understand the pipeline
- **Infrastructure**: Understand the architecture
- **Monitoring**: Identify observation points

### For Product Managers
- **Features**: See user flow
- **States**: Understand user experience

---

## 🏗️ **Project Structure**

### Backend
```
backend/
├── src/
│   ├── modules/          # Business modules
│   ├── routes/           # Route handlers
│   ├── shared/           # Shared utilities
│   └── types/            # Type definitions
├── supabase/             # Migrations and configuration
├── scripts/              # Automation scripts
├── tests/                # Backend tests
└── docs/                 # Specific documentation
```

### Frontend
```
frontend/
├── src/
│   ├── app/              # Next.js App Router
│   ├── components/       # Reusable components
│   ├── lib/              # Utilities and configuration
│   ├── hooks/            # Custom hooks
│   ├── stores/           # Global state (Zustand)
│   └── types/            # Type definitions
├── public/               # Static files
├── styles/               # Global styles
└── tests/                # Frontend tests
```

### Documentation
```
docs/
├── architecture/         # System architecture
├── api/                  # API documentation
├── database/             # Schemas and migrations
├── devops/               # CI/CD and deployment
├── testing/              # Testing strategies
├── security/             # Security and compliance
├── ai/                   # AI integration
├── team/                 # Team organization
├── configuration/        # Project configuration
└── quick-start/          # Getting started guides
```
