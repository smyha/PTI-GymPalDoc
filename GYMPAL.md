# GymPal: Fitness Platform with Social, AI and Orchestration

## 📋 Table of Contents
- [GymPal: Fitness Platform with Social, AI and Orchestration](#gympal-fitness-platform-with-social-ai-and-orchestration)
  - [📋 Table of Contents](#-table-of-contents)
  - [1. Project Vision and Scope 🏗️](#1-project-vision-and-scope-️)
    - [Vision](#vision)
    - [Key objectives](#key-objectives)
    - [Requirements](#requirements)
    - [Main Use Cases](#main-use-cases)
  - [2. Proposed Technology Stack 💻](#2-proposed-technology-stack-)
    - [Final Decision](#final-decision)
    - [Frontend](#frontend)
    - [Backend](#backend)
    - [Backend Architecture](#backend-architecture)
      - [Backend Project Structure](#backend-project-structure)
      - [OpenAPI Documentation Status](#openapi-documentation-status)
      - [Database Migrations](#database-migrations)
    - [**1. User Personal Information**](#1-user-personal-information)
      - [**GET /api/v1/users/personal/info**](#get-apiv1userspersonalinfo)
      - [**PUT /api/v1/users/personal/info**](#put-apiv1userspersonalinfo)
      - [**GET /api/v1/users/personal/objectives**](#get-apiv1userspersonalobjectives)
      - [**PUT /api/v1/users/personal/objectives**](#put-apiv1userspersonalobjectives)
      - [**GET /api/v1/users/personal/dietary-preferences**](#get-apiv1userspersonaldietary-preferences)
      - [**PUT /api/v1/users/personal/dietary-preferences**](#put-apiv1userspersonaldietary-preferences)
    - [**2. Custom Routines**](#2-custom-routines)
      - [**GET /api/v1/workouts/routines**](#get-apiv1workoutsroutines)
      - [**POST /api/v1/workouts/routines**](#post-apiv1workoutsroutines)
      - [**GET /api/v1/workouts/routines/search**](#get-apiv1workoutsroutinessearch)
      - [**POST /api/v1/workouts/routines/:routineId/share**](#post-apiv1workoutsroutinesroutineidshare)
    - [**3. Advanced Social Posts**](#3-advanced-social-posts)
      - [**GET /api/v1/social/posts**](#get-apiv1socialposts)
      - [**POST /api/v1/social/posts**](#post-apiv1socialposts)
      - [**POST /api/v1/social/posts/:postId/share**](#post-apiv1socialpostspostidshare)
      - [**POST /api/v1/social/posts/:postId/repost**](#post-apiv1socialpostspostidrepost)
      - [**GET /api/v1/social/posts/trending**](#get-apiv1socialpoststrending)
      - [**GET /api/v1/social/posts/search**](#get-apiv1socialpostssearch)
      - [Environment Variables](#environment-variables)
    - [Infrastructure and DevOps](#infrastructure-and-devops)
    - [Integrations](#integrations)
      - [API Framework Decision](#api-framework-decision)
    - [Data Architecture](#data-architecture)
    - [Data Architecture (Simplified Version)](#data-architecture-simplified-version)
    - [Database Schema](#database-schema)
      - [Main Tables](#main-tables)
      - [Row Level Security (RLS)](#row-level-security-rls)
      - [Indexes and Optimization](#indexes-and-optimization)
      - [Database Schema Diagrams](#database-schema-diagrams)
        - [Main ER Diagram - Core Entities](#main-er-diagram---core-entities)
- [Principal ER Diagram (Simplified)](#principal-er-diagram-simplified)
        - [Social Relationships Diagram](#social-relationships-diagram)
        - [Workouts and Exercises Diagram](#workouts-and-exercises-diagram)
        - [User Statistics Diagram](#user-statistics-diagram)
        - [Indexes and Performance Diagram](#indexes-and-performance-diagram)
        - [Row Level Security (RLS) Diagram](#row-level-security-rls-diagram)
  - [3. Software Architecture 🔄](#3-software-architecture-)
    - [Capability Map](#capability-map)
    - [Logical Diagram (High Level)](#logical-diagram-high-level)
    - [Frontend Architecture (Feature-Slice)](#frontend-architecture-feature-slice)
    - [Frontend Directory Structure](#frontend-directory-structure)
    - [Microservices Communication (async + sync)](#microservices-communication-async--sync)
    - [User State](#user-state)
    - [AI Chatbot State](#ai-chatbot-state)
    - [Client-Server Communication (Login + Data Fetch)](#client-server-communication-login--data-fetch)
    - [Backend-Frontend Communication (SSR/CSR)](#backend-frontend-communication-ssrcsr)
    - [Realtime via WebSocket (notifications)](#realtime-via-websocket-notifications)
    - [API Request Lifecycle](#api-request-lifecycle)
    - [Session Lifecycle (tokens)](#session-lifecycle-tokens)
    - [Backend Architecture (Layers)](#backend-architecture-layers)
    - [Detailed Service Communication Flow (with queues)](#detailed-service-communication-flow-with-queues)
    - [AI Recommendation System Flow](#ai-recommendation-system-flow)
    - [AUTH Security Validation and Authentication Flow](#auth-security-validation-and-authentication-flow)
    - [Real-time Events and WebSocket Communication Flow](#real-time-events-and-websocket-communication-flow)
    - [Admin Management and Monitoring Flow](#admin-management-and-monitoring-flow)
    - [Scalability and Load Balancing Flow](#scalability-and-load-balancing-flow)
    - [Microservices Architecture](#microservices-architecture)
    - [Complete Data Flow](#complete-data-flow)
    - [Schedule and Calendar Flow](#schedule-and-calendar-flow)
    - [Calorie Tracker Flow](#calorie-tracker-flow)
    - [Weekly Calendar View](#weekly-calendar-view)
    - [Calorie Tracker Dashboard](#calorie-tracker-dashboard)
      - [User Journey Diagram](#user-journey-diagram)
    - [Detailed TypeScript Types](#detailed-typescript-types)
    - [Domain Models (TypeScript)](#domain-models-typescript)
    - [Repositories (Supabase/Postgres)](#repositories-supabasepostgres)
    - [Services (Bussiness)](#services-bussiness)
    - [Controllers (Hono)](#controllers-hono)
    - [AI Orchestration (n8n/Dify)](#ai-orchestration-n8ndify)
  - [3.3 Detailed Backend Structure](#33-detailed-backend-structure)
    - [Configuration (config/)](#configuration-config)
      - [env.ts - Gestión de Variables de Entorno](#envts---gestión-de-variables-de-entorno)
    - [Documentation (doc/)](#documentation-doc)
      - [schemas.ts - API Documentation Schemas](#schemasts---api-documentation-schemas)
    - [Libraries (lib/)](#libraries-lib)
      - [db.ts - Database Client](#dbts---database-client)
      - [mailer.ts - Email Service](#mailerts---email-service)
    - [Controllers (src/handler/)](#controllers-srchandler)
      - [auth.handler.ts - Authentication Controllers](#authhandlerts---authentication-controllers)
      - [user.handler.ts - User Controllers](#userhandlerts---user-controllers)
    - [Routes (src/routes/)](#routes-srcroutes)
      - [auth.routes.ts - Authentication Routes](#authroutests---authentication-routes)
      - [user.routes.ts - User Routes](#userroutests---user-routes)
    - [AI and Recommendations](#ai-and-recommendations)
  - [4.1 Frontend API Client](#41-frontend-api-client)
  - [4.3 Testing Strategy](#43-testing-strategy)
    - [Testing Pyramid](#testing-pyramid)
    - [Layered Testing Strategy](#layered-testing-strategy)
    - [Testing Flow in CI/CD](#testing-flow-in-cicd)
    - [Testing Coverage](#testing-coverage)
    - [Test Examples](#test-examples)
  - [5. AI Integration (Detailed)](#5-ai-integration-detailed)
    - [Dify Client](#dify-client)
    - [Context Builder](#context-builder)
    - [Frontend Chat Component](#frontend-chat-component)
  - [6. Security and Compliance 🔐](#6-security-and-compliance-)
    - [Security Principles](#security-principles)
    - [Authentication and Authorization](#authentication-and-authorization)
    - [Auth Middleware Implementation](#auth-middleware-implementation)
    - [Rate Limiting](#rate-limiting)
    - [Input Validation](#input-validation)
    - [Security Headers](#security-headers)
    - [CORS Configuration](#cors-configuration)
    - [Additional Security Measures](#additional-security-measures)
  - [7. DevOps, CI/CD and GitOps 🚀](#7-devops-cicd-and-gitops-)
    - [Infrastructure Architecture](#infrastructure-architecture)
    - [CI/CD Pipeline](#cicd-pipeline)
    - [CD Pipeline](#cd-pipeline)
    - [Kubernetes Manifests](#kubernetes-manifests)
    - [Kustomization](#kustomization)
    - [Docker Compose (Local Development)](#docker-compose-local-development)
    - [Monitoring](#monitoring)
  - [8. Monitoring and Observability 📈](#8-monitoring-and-observability-)
  - [9. Work Plan and Team Organization 👥](#9-work-plan-and-team-organization-)
    - [Roles](#roles)
    - [Roadmap (October - December 2025)](#roadmap-october---december-2025)
      - [Phase 1: Initial Setup (7 Oct - 3 Nov)](#phase-1-initial-setup-7-oct---3-nov)
      - [Phase 2: Backend Core (4 Nov - 24 Nov)](#phase-2-backend-core-4-nov---24-nov)
      - [Phase 3: AI Integration (25 Nov - 8 Dec)](#phase-3-ai-integration-25-nov---8-dec)
      - [Phase 4: DevOps \& Scale (9 Dec - 19 Dec)](#phase-4-devops--scale-9-dec---19-dec)
    - [Delivery Schedule](#delivery-schedule)
  - [10. Methodology, Standards and Quality 🧭](#10-methodology-standards-and-quality-)
  - [11. Communication Flows and Orchestration 🔄](#11-communication-flows-and-orchestration-)
    - [Diagram: Registration and Authentication Flow](#diagram-registration-and-authentication-flow)
    - [Diagram: Workout Routine Generation and Tracking](#diagram-workout-routine-generation-and-tracking)
    - [Diagram: Social Interaction (follow, notify, feed)](#diagram-social-interaction-follow-notify-feed)
    - [Diagram: Social Post Lifecycle](#diagram-social-post-lifecycle)
    - [n8n Flows (examples)](#n8n-flows-examples)
      - [1. Workflow: Telegram Chatbot](#1-workflow-telegram-chatbot)
      - [2. Workflow: Daily Reminders](#2-workflow-daily-reminders)
      - [3. Workflow: Content Moderation](#3-workflow-content-moderation)
      - [4. Workflow: AI Plan Generation](#4-workflow-ai-plan-generation)
      - [5. Workflow: Calorie Tracking Notifications](#5-workflow-calorie-tracking-notifications)
      - [6. Workflow: Social Engagement](#6-workflow-social-engagement)
    - [Sequence (Web AI Chat)](#sequence-web-ai-chat)
    - [Sequence (workout plan generation)](#sequence-workout-plan-generation)
    - [Sequence (social post and notification)](#sequence-social-post-and-notification)
    - [Social Interactions: Post, Feed, Like, Comment](#social-interactions-post-feed-like-comment)
    - [Basic Moderation (reports)](#basic-moderation-reports)
    - [User Interaction Diagrams (Mermaid)](#user-interaction-diagrams-mermaid)
    - [Publish Post](#publish-post)
    - [View Feed](#view-feed)
    - [Like and Comment](#like-and-comment)
    - [Follow User](#follow-user)
    - [Content Moderation](#content-moderation)
    - [Backend Class Diagram (Social)](#backend-class-diagram-social)
    - [Frontend Class Diagram (Social)](#frontend-class-diagram-social)
    - [ER: Training Data Flow](#er-training-data-flow)
    - [ER: Nutrition Data Flow](#er-nutrition-data-flow)
    - [ER: Social Data Flow](#er-social-data-flow)
    - [ER: AI Recommendations Data Flow](#er-ai-recommendations-data-flow)
    - [ER: Notifications Data Flow](#er-notifications-data-flow)
    - [Dependencies and Health Checks](#dependencies-and-health-checks)
    - [Threat Model and Security](#threat-model-and-security)
    - [Monitoring \& Observability Stack](#monitoring--observability-stack)
  - [12. AI Integration (Chatbot and Recommender) 🤖](#12-ai-integration-chatbot-and-recommender-)
    - [AI Architecture](#ai-architecture)
    - [AI Chatbot Flow](#ai-chatbot-flow)
    - [Recommendation System](#recommendation-system)
    - [AI Evaluation and Metrics](#ai-evaluation-and-metrics)
  - [13. Startup Guide ⚙️](#13-startup-guide-️)
    - [Development Flow](#development-flow)
    - [Development URLs](#development-urls)
      - [**Backend API (Port 3000)**](#backend-api-port-3000)
      - [**Local Supabase (Ports 54321-54329)**](#local-supabase-ports-54321-54329)
      - [**Specific API Endpoints**](#specific-api-endpoints)
      - [**Testing and Development**](#testing-and-development)
    - [Actual Backend Project Structure](#actual-backend-project-structure)
    - [Actual Frontend Project Structure](#actual-frontend-project-structure)
    - [Module Structure Details](#module-structure-details)
      - [**📁 Frontend - Next.js 14 Architecture**](#-frontend---nextjs-14-architecture)
      - [**📁 Backend - Business Modules**](#-backend---business-modules)
      - [**📁 src/routes/ - Route Handlers**](#-srcroutes---route-handlers)
      - [**📁 src/shared/ - Shared Utilities**](#-srcshared---shared-utilities)
      - [**📁 supabase/ - Database**](#-supabase---database)
      - [**Automation Scripts**](#automation-scripts)
    - [Available Development Commands](#available-development-commands)
    - [CI/CD Pipeline](#cicd-pipeline-1)
      - [**Main Pipeline - Push to Main**](#main-pipeline---push-to-main)
      - [**Detailed Testing Pipeline**](#detailed-testing-pipeline)
      - [**Deploy Pipeline with ArgoCD**](#deploy-pipeline-with-argocd)
      - [**Code Quality Pipeline**](#code-quality-pipeline)
      - [**Monitoring \& Notifications Pipeline**](#monitoring--notifications-pipeline)
  - [14. KPIs and Success Metrics 🎯](#14-kpis-and-success-metrics-)
    - [Metrics Dashboard](#metrics-dashboard)
  - [15. Appendices 📎](#15-appendices-)
    - [Blockchain Integration (Optional)](#blockchain-integration-optional)
    - [Technology Roadmap](#technology-roadmap)
    - [Project Gantt Chart](#project-gantt-chart)
    - [Roles Gantt Chart](#roles-gantt-chart)
  - [16. TO-DO List by Roles 👥](#16-to-do-list-by-roles-)
    - [🎨 Frontend Developer](#-frontend-developer)
    - [⚙️ Backend Developer](#️-backend-developer)
    - [🚀 DevOps/SRE Engineer](#-devopssre-engineer)
    - [🤖 AI/Integrations Developer](#-aiintegrations-developer)
    - [📋 Product/QA Engineer](#-productqa-engineer)
  - [🎯 Weekly Objectives](#-weekly-objectives)
    - [Week 1 (7-13 Oct)](#week-1-7-13-oct)
    - [Week 2 (14-20 Oct)](#week-2-14-20-oct)
    - [Week 3 (21-27 Oct)](#week-3-21-27-oct)
    - [Week 4 (28 Oct - 3 Nov)](#week-4-28-oct---3-nov)

---

## 1. Project Vision and Scope 🏗️

### Vision
GymPal is a web application (with desktop option via Electron) for managing personalized training and nutrition. Users will be able to generate routines and diets adapted to their physique, goals and pace; share posts with routines, achievements and recommendations; interact with other users through ratings and comments; and receive help from an AI chatbot and an active recommendation engine.

### Key objectives
- **Intelligent generation** of personalized routines and diets.
- **Fitness social network**: posts, comments, likes and profile following.
- **AI Chatbot** in the web by session and as automated chatbot (n8n) in Telegram/WhatsApp/Gmail.
- **Recommendation system** (Dify AI) for users, routines, diets and content.
- **Scalable and secure architecture** with microservices, CI/CD and observability.

### Requirements 
- Client-server; REST APIs; microservice patterns; Docker containers; Kubernetes.
- Security: OAuth2/OIDC, JWT, HTTPS, Policies, TLS Secrets.
- External API integration and workflow orchestration with n8n.
- GitOps with ArgoCD; monitoring with Prometheus + Grafana + Promtail.
- Transactional email with Proton Mail; complete technical documentation.
- AI Integration: Chatbot and recommendations with Dify AI; LLM for planned generation.
- Blockchain service (optional) for achievement certification or evidence sealing.

### Main Use Cases

```mermaid
graph TB
  subgraph "Fitness User"
    UC1[Register and configure profile]
    UC2[Generate personalized training plan]
    UC3[Track progress and record logs]
    UC4[Generate nutritional plan]
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

---

## 2. Proposed Technology Stack 💻


### Final Decision

| Layer | Technology | Justification |
|------|------------|---------------|
| **Frontend** | Next.js 14 (App Router) + Zustand | SSR, SEO, File-based routing |
| **UI Components** | shadcn/ui + Tailwind | Modern, accessible, customizable |
| **Backend** | Hono + TypeScript | 10x faster than Express, TS-first |
| **Database** | Supabase (Postgres) | Complete BaaS, integrated Auth |
| **Auth** | Supabase Auth (OAuth2) | OAuth2/OIDC out-of-the-box |
| **Storage** | Supabase Storage | S3-compatible, integrated with Auth |
| **AI Platform** | Dify AI | LLM orchestration, prompts management |
| **Containerization** | Docker | De facto standard |
| **Orchestration** | Kubernetes (kind local) | Academic requirement |
| **GitOps** | ArgoCD | Declarative deployments |
| **Monitoring** | Prometheus + Grafana | Metrics and dashboards |
| **Logs** | Loki + Promtail | Log aggregation |
| **Package Manager** | npm/yarn | Dependency management |
| **Testing** | Vitest + Supertest | Modern and fast testing |
| **Validation** | Zod | Runtime type-safe validation |

### Frontend
- **Next.js 14** (App Router) + **TypeScript**.
- **Tailwind CSS** + **shadcn/ui** for modern and accessible UI.
- **Auth** with OAuth2/OIDC via Supabase Auth or Auth.js.
- **State**: React Query/Server Actions, Zustand where appropriate.
- **SSR/ISR** for SEO and performance.

### Backend
- **Node.js + TypeScript** with **Hono** for REST APIs and WebSocket.
- **Supabase** (PostgreSQL, Auth, Storage, Realtime) as backend accelerator.
- **n8n** for workflow orchestration (chatbots in Telegram/WhatsApp, emails, cron).
- **Dify AI** for recommender and AI flows; integration via API.
- **Proton Mail** (or SMTP compatible) for emails.

### Backend Architecture 

#### Backend Project Structure
```
backend/
├── config/           # Environment variables configuration
│   └── env.ts        # Variable validation with Zod
├── doc/             # API documentation schemas
│   └── schemas.ts    # Zod schemas for validation
├── lib/             # Shared libraries
│   ├── db.ts        # Supabase client with helpers
│   ├── auth.ts      # JWT authentication utilities
│   ├── mailer.ts    # Email service with Nodemailer
│   └── types.ts     # Database types
├── src/
│   ├── routes/      # 🎯 Professional Controllers (Handlers)
│   │   ├── auth.handler.ts          # Authentication with OpenAPI docs
│   │   ├── user.handler.ts          # User management with validation
│   │   ├── workout.handler.ts       # Workouts and exercises
│   │   ├── social.handler.ts        # Social features
│   │   ├── personal.handler.ts      # User personal information
│   │   ├── routines.handler.ts      # Custom routines
│   │   ├── posts.handler.ts         # Advanced social posts
│   │   ├── dashboard.handler.ts     # Analytics and statistics
│   │   └── settings.handler.ts      # User configuration
│   ├── modules/     # 📦 Functionality Modules (Services)
│   │   ├── auth/    # Complete authentication module
│   │   │   ├── auth.service.ts    # Business logic
│   │   │   ├── auth.types.ts      # Specific types
│   │   │   └── auth.middleware.ts # Specific middleware
│   │   ├── users/   # Complete users module
│   │   │   ├── user.service.ts    # User logic
│   │   │   ├── user.types.ts      # User types
│   │   │   └── user.middleware.ts # User validation
│   │   ├── workouts/ # Complete workouts module
│   │   │   ├── workout.service.ts    # Workout logic
│   │   │   ├── workout.types.ts      # Workout types
│   │   │   └── workout.middleware.ts # Workout validation
│   │   ├── social/   # Complete social module
│   │   │   ├── social.service.ts    # Social logic
│   │   │   ├── social.types.ts      # Social types
│   │   │   └── social.middleware.ts # Social validation
│   │   └── ai/       # AI module 
│   ├── shared/      # 🔧 Shared utilities
│   │   ├── middleware/ # Global middlewares
│   │   │   ├── error.middleware.ts
│   │   │   ├── rate-limit.middleware.ts
│   │   │   └── validation.middleware.ts
│   │   └── utils/   # Common utilities
│   │       ├── helpers.ts
│   │       ├── constants.ts
│   │       └── response.ts
│   └── index.ts     # 🚀 Optimized entry point
├── supabase/        # Supabase configuration
│   ├── migrations/  # Database migrations
│   ├── config.toml  # Supabase configuration
│   └── seed.sql     # Test data
├── tests/           # Project tests
├── docs/            # Project documentation
│   ├── README.md              # API documentation
│   └── OPENAPI_DOCUMENTATION.md # OpenAPI documentation summary
├── scripts/         # Utility scripts
│   ├── generate-openapi.js          # Basic OpenAPI generation
│   └── generate-complete-openapi-v2.js # Complete OpenAPI generation
├── package.json
├── tsconfig.json
├── vitest.config.ts
├── openapi.json     # OpenAPI 3.1 specification 
├── env.example      # Example environment variables
└── Dockerfile
```

#### OpenAPI Documentation Status


```mermaid
graph TB
  subgraph "Authentication Flow"
    LOGIN[POST /auth/login]
    REGISTER[POST /auth/register]
    REFRESH[POST /auth/refresh]
    LOGOUT[POST /auth/logout]
    ME[GET /auth/me]
  end
  
  subgraph "User Management"
    USER_PROFILE[GET /users/:id]
    UPDATE_PROFILE[PATCH /users/:id]
    USER_SUMMARY[GET /users/:id/summary]
    USER_ACTIVITY[GET /users/:id/activity]
    AVATAR[POST /users/:id/avatar]
  end
  
  subgraph "Workout Management"
    EXERCISES[GET /exercises]
    CREATE_WORKOUT[POST /workouts]
    GET_WORKOUT[GET /workouts/:id]
    UPDATE_WORKOUT[PATCH /workouts/:id]
    LOG_WORKOUT[POST /workouts/:id/logs]
    WORKOUT_PROGRESS[GET /workouts/:id/progress]
    DELETE_WORKOUT[DELETE /workouts/:id]
  end
  
  subgraph "Nutrition Management"
    FOODS[GET /foods]
    CREATE_DIET[POST /diets]
    GET_DIET[GET /diets/:id]
    UPDATE_DIET[PATCH /diets/:id]
    DIET_MEALS[GET /diets/:id/meals]
    LOG_DIET[POST /diets/:id/logs]
  end
  
  subgraph "Schedule Management"
    CREATE_SCHEDULE[POST /schedules]
    GET_SCHEDULE[GET /schedules/:id]
    UPDATE_SCHEDULE[PATCH /schedules/:id]
    SCHEDULE_ITEMS[GET /schedules/:id/items]
    WEEKLY_VIEW[GET /schedules/weekly]
    MONTHLY_VIEW[GET /schedules/monthly]
    YEARLY_VIEW[GET /schedules/yearly]
  end
  
  subgraph "Calorie Tracking"
    LOG_CALORIES[POST /calories/log]
    GET_CALORIES[GET /calories/:date]
    CALORIE_HISTORY[GET /calories/history]
    FOOD_SEARCH[GET /foods/search]
    ADD_FOOD[POST /foods/custom]
  end
  
  subgraph "Social Features"
    FEED[GET /feed]
    CREATE_POST[POST /posts]
    LIKE_POST[POST /posts/:id/like]
    COMMENT[POST /posts/:id/comments]
    FOLLOW[POST /users/:id/follow]
    FOLLOWERS[GET /users/:id/followers]
  end
  
  subgraph "AI Features"
    AI_CHAT[POST /ai/chat]
    AI_RECOMMENDATIONS[GET /ai/recommendations]
    GENERATE_PLAN[POST /ai/generate-plan]
    CHAT_HISTORY[GET /ai/chat/history]
  end
```

**API Design Principles**
- **RESTful** with clear resources
- **Versioning** in the URL (`/api/v1/...`)
- **Consistent JSON** responses
- **Semantic HTTP codes**
- **Cursor-based pagination** for lists
- **User-based rate limiting**


| Category | Endpoints | Description |
|----------|-----------|-------------|
| 🔐 **Authentication** | 6 | Register, login, refresh, logout, profile, password change |
| 👤 **Users** | 6 | Profile, settings, stats, public profile |
| 💪 **Workouts** | 5 | Basic workouts CRUD |
| 📱 **Social** | 11 | Feed, posts, likes, comments, follows |
| 👤 **Personal** | 6 | Personal info, objectives, dietary preferences |
| 🏋️ **Routines** | 7 | Custom routines CRUD, duplicate, share |
| 📝 **Advanced Posts** | 4 | Trending, search, share, repost |
| 📊 **Dashboard** | 2 | Stats and recent activity |
| ⚙️ **Settings** | 3 | General user settings |

**✅ Complete Documentation (31 Endpoints):**

- `GET /` - General API information
- `GET /reference` - Interactive documentation (Scalar)
- `GET /openapi.json` - OpenAPI 3.1 specification
- `GET /health` - Server health check

**🔐 Authentication (`/api/v1/auth`):**
- `POST /register` - Register user
- `POST /login` - User login
- `POST /refresh` - Refresh token
- `POST /logout` - Logout
- `GET /me` - Authenticated user profile
- `POST /change-password` - Change password
- `POST /forgot-password` - Request password reset
- `POST /reset-password` - Reset password with token

**👤 Users (`/api/v1/users`):**
- `GET /profile` - Get user profile
- `PUT /profile` - Update user profile
- `GET /settings` - Get user settings
- `PUT /settings` - Update user settings
- `GET /stats` - User stats
- `GET /:userId` - Get public profile
- `GET /:userId/summary` - Get public user summary
- `GET /:userId/activity` - Get user's recent activity
- `POST /:userId/avatar` - Upload user avatar

**📊 Personal Information (`/api/v1/users/personal`):**
- `GET /info` - Get complete personal information
- `PUT /info` - Update personal info (age, gender, weight, height, BMI)
- `GET /objectives` - Get objectives & experience level
- `PUT /objectives` - Update objectives & experience level
- `GET /dietary-preferences` - Get dietary preferences
- `PUT /dietary-preferences` - Update dietary preferences
- `GET /fitness-profile` - Get complete fitness profile
- `PUT /fitness-profile` - Update complete fitness profile


**🏋️ Custom Routines (`/api/v1/workouts/routines`):**
- `GET /` - List user routines
- `POST /` - Create new custom routine
- `GET /:routineId` - Get routine details
- `PUT /:routineId` - Update custom routine
- `DELETE /:routineId` - Delete custom routine
- `GET /templates` - Get routine templates
- `POST /:routineId/duplicate` - Duplicate existing routine
- `GET /search` - Search routines by criteria (goal, level, duration, equipment)
- `POST /:routineId/share` - Share routine with other users

**👥 Social (`/api/v1/social`):**
- `GET /feed` - User social feed
- `GET /posts` - Posts by a specific user
- `POST /posts` - Create post
- `GET /posts/:postId` - Get post details
- `PUT /posts/:postId` - Update post
- `DELETE /posts/:postId` - Delete post
- `POST /posts/:postId/like` - Like/unlike post
- `GET /posts/:postId/comments` - Get post comments
- `POST /posts/:postId/comments` - Comment on post
- `POST /follow` - Follow user
- `POST /unfollow` - Unfollow user
- `GET /followers` - Get followers list
- `GET /following` - Get following users list

**📱 Advanced Posts (`/api/v1/social/posts`):**
- `GET /` - List posts with filters (type, date, user)
- `POST /` - Create new post
- `GET /:postId` - Get full post with interactions
- `PUT /:postId` - Update post
- `DELETE /:postId` - Delete post
- `POST /:postId/share` - Share/forward post
- `POST /:postId/repost` - Repost content
- `GET /:postId/shares` - Get users who shared
- `GET /:postId/likes` - Get users who liked
- `GET /types` - Get available post types (achievement, routine, tip, progress)
- `GET /trending` - Get trending posts
- `GET /search` - Search posts by content or hashtags

**🔐 Authentication (6 endpoints):**
- `POST /api/v1/auth/register` - User registration
- `POST /api/v1/auth/login` - Login
- `POST /api/v1/auth/refresh` - Token refresh
- `POST /api/v1/auth/logout` - Logout
- `GET /api/v1/auth/me` - Current user profile
- `POST /api/v1/auth/change-password` - Change password

**👤 User Management (6 endpoints):**
- `GET /api/v1/users/profile` - Get profile
- `PUT /api/v1/users/profile` - Update profile
- `GET /api/v1/users/settings` - Get settings
- `PUT /api/v1/users/settings` - Update settings
- `GET /api/v1/users/stats` - User stats
- `GET /api/v1/users/{userId}/public` - Public profile

**💪 Workouts (5 endpoints):**
- `GET /api/v1/workouts` - List workouts
- `POST /api/v1/workouts` - Create workout
- `GET /api/v1/workouts/{workoutId}` - Workout details
- `PUT /api/v1/workouts/{workoutId}` - Update workout
- `DELETE /api/v1/workouts/{workoutId}` - Delete workout

**📱 Social Features (11 endpoints):**
- `GET /api/v1/social/feed` - Social feed
- `GET /api/v1/social/posts` - List posts
- `POST /api/v1/social/posts` - Create post
- `GET /api/v1/social/posts/{postId}` - Post details
- `PUT /api/v1/social/posts/{postId}` - Update post
- `DELETE /api/v1/social/posts/{postId}` - Delete post
- `POST /api/v1/social/posts/{postId}/like` - Like post
- `GET /api/v1/social/posts/{postId}/comments` - Comments
- `POST /api/v1/social/posts/{postId}/comments` - Create comment
- `POST /api/v1/social/follow/{userId}` - Follow user
- `DELETE /api/v1/social/follow/{userId}` - Unfollow user

**👤 Personal Information (6 endpoints):**
- `GET /api/v1/users/personal/info` - Personal information
- `PUT /api/v1/users/personal/info` - Update personal information
- `GET /api/v1/users/personal/objectives` - Fitness objectives
- `PUT /api/v1/users/personal/objectives` - Update objectives
- `GET /api/v1/users/personal/dietary-preferences` - Dietary preferences
- `PUT /api/v1/users/personal/dietary-preferences` - Update dietary preferences

**🏋️ Custom Routines (7 endpoints):**
- `GET /api/v1/workouts/routines` - List routines
- `POST /api/v1/workouts/routines` - Create routine
- `GET /api/v1/workouts/routines/{routineId}` - Routine details
- `PUT /api/v1/workouts/routines/{routineId}` - Update routine
- `DELETE /api/v1/workouts/routines/{routineId}` - Delete routine
- `POST /api/v1/workouts/routines/{routineId}/duplicate` - Duplicate routine
- `POST /api/v1/workouts/routines/{routineId}/share` - Share routine

**📝 Advanced Posts (4 endpoints):**
- `GET /api/v1/social/posts/trending` - Trending posts
- `GET /api/v1/social/posts/search` - Search posts
- `POST /api/v1/social/posts/{postId}/share` - Share post
- `POST /api/v1/social/posts/{postId}/repost` - Repost

**📊 Dashboard (2 endpoints):**
- `GET /api/v1/dashboard/stats` - Dashboard stats
- `GET /api/v1/dashboard/activity` - Recent activity

**⚙️ Settings (3 endpoints):**
- `GET /api/v1/settings` - Get settings
- `PUT /api/v1/settings` - Update settings
- `POST /api/v1/settings/reset` - Reset settings

**📦 NPM Scripts:**
- `npm run dev` - Development server with hot reload
- `npm run build` - Production build
- `npm run start` - Production server
- `npm run test` - Run tests
- `npm run test:watch` - Watch mode tests
- `npm run test:coverage` - Test coverage
- `npm run lint` - Linting with ESLint
- `npm run lint:fix` - Linting with auto-fix
- `npm run format` - Formatting with Prettier
- `npm run docs:generate` - Generate basic OpenAPI docs
- `npm run docs:generate-full` - Generate full OpenAPI documentation
- `npm run docs:serve` - Serve interactive documentation
- `npm run docs:open` - Open docs in browser

**🚀 Technical Features:**
- **OpenAPI loading:** From JSON file for better performance
- **dotenv config:** Automatic environment variable loading
- **Interactive docs:** Scalar API Reference at `/reference`
- **Automatic validation:** Zod schemas for request/response
- **Strict TypeScript:** Strong typing throughout the project
- **ES Modules:** Modern modules setup
- **Error handling:** Consistent and professional
- **Rate limiting:** Protection against abuse
- **Configured CORS:** For development and production

#### Database Migrations

**`user_personal_info`** - Detailed personal information:
- `age` - User age (13-120 years)
- `weight_kg` - Weight in kilograms
- `height_cm` - Height in centimeters
- `bmi` - Calculated body mass index
- `body_fat_percentage` - Body fat percentage

**`user_fitness_profile`** - Complete fitness profile:
- `experience_level` - Experience level (beginner, intermediate, advanced, expert)
- `primary_goal` - Primary goal (weight_loss, muscle_gain, etc.)
- `secondary_goals` - Secondary goals (array)
- `workout_frequency` - Training frequency (1-7 days/week)
- `preferred_workout_duration` - Preferred duration in minutes
- `available_equipment` - Available equipment
- `workout_preferences` - Workout preferences (JSONB)
- `injury_history` - Injury history
- `medical_restrictions` - Medical restrictions
- `fitness_goals_timeline` - Goals timeline
- `motivation_level` - Motivation level (1-10)

**`user_dietary_preferences`** - Dietary preferences:
- `dietary_restrictions` - Dietary restrictions
- `allergies` - Food allergies
- `food_preferences` - Food preferences (JSONB)
- `calorie_goal` - Daily calorie goal
- `protein_goal` - Protein goal
- `carb_goal` - Carb goal
- `fat_goal` - Fat goal
- `water_intake_goal` - Water intake goal
- `meal_frequency` - Meal frequency

**`shared_workouts`** - Shared routines:
- `original_workout_id` - Original workout ID
- `shared_by_user_id` - User sharing the routine
- `shared_with_user_id` - User receiving the routine
- `is_accepted` - Acceptance status

**`post_shares`** - Post sharing:
- `post_id` - Post ID
- `shared_by_user_id` - User who shares
- `shared_with_user_id` - User who receives the share
- `share_type` - Type of sharing (share, repost, forward)

**`post_reposts`** - Post reposts:
- `original_post_id` - Original post ID
- `reposted_by_user_id` - User who reposts
- `reposted_at` - Repost timestamp

**Modified Tables:**
- **`profiles`** - Added `gender` and `fitness_level` fields
- **`workouts`** - Added fields for custom routines
- **`posts`** - Added fields for advanced posts


### **1. User Personal Information**

#### **GET /api/v1/users/personal/info**
Get complete personal user information.

**Response:**
```json
{
  "success": true,
  "data": {
    "age": 25,
    "gender": "male",
    "weight_kg": 75.5,
    "height_cm": 180,
    "bmi": 23.3,
    "body_fat_percentage": 15.2,
    "created_at": "2024-01-15T10:30:00Z",
    "updated_at": "2024-01-20T14:45:00Z"
  }
}
```

#### **PUT /api/v1/users/personal/info**
Update personal user information.

**Request Body:**
```json
{
  "age": 25,
  "gender": "male",
  "weight_kg": 75.5,
  "height_cm": 180
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "age": 25,
    "gender": "male",
    "weight_kg": 75.5,
    "height_cm": 180,
    "bmi": 23.3,
    "body_fat_percentage": 15.2,
    "updated_at": "2024-01-20T14:45:00Z"
  }
}
```

#### **GET /api/v1/users/personal/objectives**
Get user fitness objectives and experience level.

**Response:**
```json
{
  "success": true,
  "data": {
    "experience_level": "intermediate",
    "primary_goal": "muscle_gain",
    "secondary_goals": ["strength_building", "flexibility"],
    "workout_frequency": 4,
    "preferred_workout_duration": 60,
    "available_equipment": ["full_gym", "dumbbells"],
    "fitness_goals_timeline": "6_months",
    "motivation_level": 8
  }
}
```

#### **PUT /api/v1/users/personal/objectives**
Update objectives and experience level.

**Request Body:**
```json
{
  "experience_level": "intermediate",
  "primary_goal": "muscle_gain",
  "secondary_goals": ["strength_building"],
  "workout_frequency": 4,
  "preferred_workout_duration": 60,
  "available_equipment": ["full_gym", "dumbbells"],
  "fitness_goals_timeline": "6_months",
  "motivation_level": 8
}
```

#### **GET /api/v1/users/personal/dietary-preferences**
Get user dietary preferences.

**Response:**
```json
{
  "success": true,
  "data": {
    "dietary_restrictions": ["high_protein", "dairy_free"],
    "allergies": ["nuts", "shellfish"],
    "calorie_goal": 2500,
    "protein_goal": 150,
    "carb_goal": 300,
    "fat_goal": 100,
    "water_intake_goal": 3000,
    "meal_frequency": 5
  }
}
```

#### **PUT /api/v1/users/personal/dietary-preferences**
Update dietary preferences.

**Request Body:**
```json
{
  "dietary_restrictions": ["high_protein", "dairy_free"],
  "allergies": ["nuts"],
  "calorie_goal": 2500,
  "protein_goal": 150,
  "carb_goal": 300,
  "fat_goal": 100,
  "water_intake_goal": 3000,
  "meal_frequency": 5
}
```

### **2. Custom Routines**

#### **GET /api/v1/workouts/routines**
List user routines with filters.

**Query Parameters:**
- `page` (number): Page (default: 1)
- `limit` (number): Items per page (default: 10)
- `goal` (string): Filter by goal
- `level` (string): Filter by level
- `equipment` (string): Filter by equipment
- `duration_min` (number): Minimum duration in minutes
- `duration_max` (number): Maximum duration in minutes

**Response:**
```json
{
  "success": true,
  "data": {
    "routines": [
      {
        "id": "uuid",
        "name": "Strength Routine",
        "description": "Routine focused on muscle gain",
        "type": "strength",
        "difficulty": "intermediate",
        "duration_minutes": 60,
        "target_goal": "muscle_gain",
        "target_level": "intermediate",
        "days_per_week": 4,
        "equipment_required": ["full_gym", "dumbbells"],
        "user_notes": "Focus on correct form",
        "tags": ["strength", "hypertrophy"],
        "share_count": 5,
        "like_count": 12,
        "is_public": true,
        "created_at": "2024-01-15T10:30:00Z"
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 10,
      "total": 25,
      "total_pages": 3
    }
  }
}
```

#### **POST /api/v1/workouts/routines**
Create a new custom routine.

**Request Body:**
```json
{
  "name": "Strength Routine",
  "description": "Routine focused on muscle gain",
  "type": "strength",
  "difficulty": "intermediate",
  "duration_minutes": 60,
  "target_goal": "muscle_gain",
  "target_level": "intermediate",
  "days_per_week": 4,
  "equipment_required": ["full_gym", "dumbbells"],
  "user_notes": "Focus on correct form",
  "tags": ["strength", "hypertrophy"],
  "is_public": true
}
```

#### **GET /api/v1/workouts/routines/search**
Search routines by criteria.

**Query Parameters:**
- `goal` (string): Main goal
- `level` (string): Experience level
- `equipment` (string): Available equipment
- `duration_min` (number): Minimum duration
- `duration_max` (number): Maximum duration
- `days_per_week` (number): Days per week
- `tags` (string): Tags separated by commas

#### **POST /api/v1/workouts/routines/:routineId/share**
Share routine with other users.

**Request Body:**
```json
{
  "user_ids": ["uuid1", "uuid2", "uuid3"],
  "message": "Sharing this routine that has worked great for me"
}
```

### **3. Advanced Social Posts**

#### **GET /api/v1/social/posts**
List posts with filters.

**Query Parameters:**
- `page` (number): Page
- `limit` (number): Items per page
- `type` (string): Post type (achievement, routine, tip, progress)
- `user_id` (string): Filter by user
- `hashtags` (string): Filter by hashtags
- `date_from` (string): From date (ISO)
- `date_to` (string): To date (ISO)

**Response:**
```json
{
  "success": true,
  "data": {
    "posts": [
      {
        "id": "uuid",
        "user": {
          "id": "uuid",
          "username": "fitness_user",
          "full_name": "Juan Pérez",
          "avatar_url": "https://example.com/avatar.jpg"
        },
        "content": "I achieved my 100kg bench press goal! 💪",
        "post_type": "achievement",
        "image_urls": ["https://example.com/photo1.jpg"],
        "hashtags": ["#benchpress", "#achievement", "#strength"],
        "likes_count": 25,
        "comments_count": 8,
        "shares_count": 3,
        "reposts_count": 2,
        "is_original": true,
        "created_at": "2024-01-20T15:30:00Z",
        "workout": {
          "id": "uuid",
          "name": "Strength Routine"
        }
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 10,
      "total": 150,
      "total_pages": 15
    }
  }
}
```

#### **POST /api/v1/social/posts**
Create new post.

**Request Body:**
```json
{
  "content": "I achieved my 100kg bench press goal! 💪",
  "post_type": "achievement",
  "image_urls": ["https://example.com/photo1.jpg"],
  "hashtags": ["#benchpress", "#achievement", "#strength"],
  "workout_id": "uuid",
  "is_public": true
}
```

#### **POST /api/v1/social/posts/:postId/share**
Share/forward a post.

**Request Body:**
```json
{
  "user_ids": ["uuid1", "uuid2"],
  "message": "Check out this amazing achievement!",
  "share_type": "share"
}
```

#### **POST /api/v1/social/posts/:postId/repost**
Repost content.

**Request Body:**
```json
{
  "comment": "Awesome routine! I'm going to try it"
}
```

#### **GET /api/v1/social/posts/trending**
Get trending posts.

**Query Parameters:**
- `timeframe` (string): Period (1h, 24h, 7d, 30d)
- `limit` (number): Number of posts

#### **GET /api/v1/social/posts/search**
Search posts by content or hashtags.

**Query Parameters:**
- `q` (string): Search term
- `hashtags` (string): Comma-separated hashtags
- `type` (string): Post type
- `user_id` (string): Filter by user


**📦 Dependency Management:**
- **Bun as alternative:** Consider Bun for better performance
- **Native ES Modules:** Modern setup without transpilation
- **Import maps:** For better module resolution

**🔧 Development Tools:**
- **Simplified scripts:** More direct and efficient commands
- **Minimal config:** Fewer configuration files
- **Improved hot reload:** Faster automatic reload

**📚 Documentation:**
- **Integrated API reference:** Automatic docs with [Scalar](https://scalar.com/)
- **OpenAPI from file:** Dynamic spec loading
- **Usage examples:** Code examples in docs

**🚀 Performance:**
- **Lazy module loading:** Import on demand
- **Tree shaking:** Remove unused code
- **Optimized build:** Faster, efficient builds

**🛠️ Configuration:**
- **Environment variables:** Automatic validation with Zod
- **Centralized config:** Single place for all config
- **Generated types:** TypeScript types automation
- **Database:** Supabase (PostgreSQL)
- **Testing:** Vitest + Supertest
- **Linting:** ESLint + Prettier
- **Build:** tsup for compilation

#### Environment Variables
Create a `.env.example` and setup:
- `SUPABASE_URL`, `SUPABASE_ANON_KEY`, `SUPABASE_SERVICE_KEY`
- `JWT_SECRET`, `JWT_EXPIRY`
- `PORT` (server port)
- `NODE_ENV` (development/production)
- `SMTP_HOST`, `SMTP_PORT`, `SMTP_USER`, `SMTP_PASS` (emails)

### Infrastructure and DevOps
- **Docker** + **Kubernetes** (local kind/minikube; managed cloud cluster as needed).
- **ArgoCD** (GitOps) with Helm/Kustomize.
- **Prometheus + Grafana + Promtail** for metrics and logs.
- **Cert-Manager + Ingress NGINX** for TLS/HTTPS.
- **Vault/Sealed Secrets** (optional) for secrets management.

### Integrations
- Messaging: Telegram/WhatsApp (via n8n, webhooks, and official/partner APIs).
- Social Login: Google, GitHub, etc. (OAuth2/OIDC).
- Optional: Blockchain service (Polygon/ETH testnet) for anchoring milestones.

#### API Framework Decision

| Framework | Location  | Main Role                                             | Notes                          |
|-----------|-----------|-------------------------------------------------------|--------------------------------|
| **Hono**  | Backend   | Business logic, data persistence, REST APIs           | Zustand not required           |
| **Zustand** | Frontend| State management in React/Next.js, API communication  | Frontend-only, not needed in backend |

- **Hono (Backend):**
  - Handles business logic and data persistence.
  - Provides REST APIs for frontend.
  - Zustand is not needed (Zustand is frontend-only).

- **Zustand (Frontend):**
  - Client state management in React/Next.js.
  - Communicates with Hono via API calls.
  - Does not interfere with backend logic.

### Data Architecture

```mermaid
graph TB
  subgraph "Presentation Layer"
    WEB[Web App - Next.js]
    MOBILE[Mobile App - React Native]
    ADMIN[Admin Panel]
  end
  
  subgraph "API Layer"
    GATEWAY[API Gateway - Hono]
    AUTH[Auth Service]
    USER[User Service]
    WORKOUT[Workout Service]
    NUTR[Nutrition Service]
    SOCIAL[Social Service]
    AI[AI Service]
  end
  
  subgraph "Data Layer"
    POSTGRES[(PostgreSQL - Supabase)]
    STORAGE[(File Storage - Supabase)]
  end
  
  subgraph "External Services"
    DIFY[Dify AI]
    N8N[n8n Workflows]
    EMAIL[Proton Mail]
    TELEGRAM[Telegram Bot]
  end
  
  WEB --> GATEWAY
  MOBILE --> GATEWAY
  ADMIN --> GATEWAY
  
  GATEWAY --> AUTH
  GATEWAY --> USER
  GATEWAY --> WORKOUT
  GATEWAY --> NUTR
  GATEWAY --> SOCIAL
  GATEWAY --> AI
  
  USER --> POSTGRES
  WORKOUT --> POSTGRES
  NUTR --> POSTGRES
  SOCIAL --> POSTGRES
  SOCIAL --> STORAGE
  
  AI --> DIFY
  SOCIAL --> N8N
  N8N --> EMAIL
  N8N --> TELEGRAM
```
### Data Architecture (Simplified Version)

``` mermaid
graph TB
    subgraph "Client"
        WEB[Next.js 14 App]
    end
    
    subgraph "API Layer"
        API[Hono API Server]
        AUTH[Auth Module]
        WORKOUT[Workout Module]
        SOCIAL[Social Module]
        AI[AI Proxy]
    end
    
    subgraph "Data Layer"
        SUPA[(Supabase:\nPostgres + Auth + Storage)]
    end
    
    subgraph "External Services"
        DIFY[Dify AI]
        TELEGRAM[Telegram Bot - Optional]
    end
    
    WEB --> API
    API --> AUTH
    API --> WORKOUT
    API --> SOCIAL
    API --> AI
    
    AUTH --> SUPA
    WORKOUT --> SUPA
    SOCIAL --> SUPA
    AI --> DIFY
    AI --> TELEGRAM
```

### Database Schema

#### Main Tables

```sql
-- users (managed by Supabase Auth)
CREATE TABLE public.profiles (
  id UUID REFERENCES auth.users(id) PRIMARY KEY,
  username TEXT UNIQUE NOT NULL,
  full_name TEXT,
  avatar_url TEXT,
  bio TEXT,
  date_of_birth DATE,
  gender TEXT CHECK (gender IN ('male', 'female', 'other', 'prefer_not_to_say')),
  fitness_level TEXT CHECK (fitness_level IN ('beginner', 'intermediate', 'advanced', 'expert')),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Detailed personal information
CREATE TABLE public.user_personal_info (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  age INTEGER CHECK (age >= 13 AND age <= 120),
  weight_kg DECIMAL(5,2) CHECK (weight_kg > 0 AND weight_kg < 500),
  height_cm INTEGER CHECK (height_cm > 0 AND height_cm < 300),
  bmi DECIMAL(4,1) CHECK (bmi > 0 AND bmi < 100),
  body_fat_percentage DECIMAL(4,1) CHECK (body_fat_percentage >= 0 AND body_fat_percentage <= 100),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id)
);

-- Fitness profile and goals
CREATE TABLE public.user_fitness_profile (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  experience_level TEXT NOT NULL CHECK (experience_level IN ('beginner', 'intermediate', 'advanced', 'expert')),
  primary_goal TEXT NOT NULL CHECK (primary_goal IN ('weight_loss', 'muscle_gain', 'maintain_fitness', 'improve_endurance', 'strength_building', 'flexibility', 'general_health')),
  secondary_goals TEXT[] DEFAULT '{}',
  workout_frequency INTEGER NOT NULL CHECK (workout_frequency >= 1 AND workout_frequency <= 7),
  preferred_workout_duration INTEGER CHECK (preferred_workout_duration > 0 AND preferred_workout_duration <= 300),
  available_equipment TEXT[] DEFAULT '{}' CHECK (available_equipment <@ ARRAY['full_gym', 'home_basic_weights', 'no_equipment', 'cardio_equipment', 'resistance_bands', 'dumbbells', 'barbell', 'kettlebell']),
  workout_preferences JSONB DEFAULT '{}',
  injury_history TEXT[] DEFAULT '{}',
  medical_restrictions TEXT[] DEFAULT '{}',
  fitness_goals_timeline TEXT CHECK (fitness_goals_timeline IN ('1_month', '3_months', '6_months', '1_year', 'long_term')),
  motivation_level INTEGER CHECK (motivation_level >= 1 AND motivation_level <= 10),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id)
);

-- Dietary preferences
CREATE TABLE public.user_dietary_preferences (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  dietary_restrictions TEXT[] DEFAULT '{}' CHECK (dietary_restrictions <@ ARRAY['high_protein', 'vegetarian', 'dairy_free', 'low_carb', 'vegan', 'gluten_free', 'keto', 'paleo', 'mediterranean', 'intermittent_fasting']),
  allergies TEXT[] DEFAULT '{}',
  food_preferences JSONB DEFAULT '{}',
  calorie_goal INTEGER CHECK (calorie_goal > 0 AND calorie_goal < 10000),
  protein_goal INTEGER CHECK (protein_goal >= 0 AND protein_goal < 500),
  carb_goal INTEGER CHECK (carb_goal >= 0 AND carb_goal < 1000),
  fat_goal INTEGER CHECK (fat_goal >= 0 AND fat_goal < 500),
  water_intake_goal INTEGER CHECK (water_intake_goal > 0 AND water_intake_goal < 10000),
  meal_frequency INTEGER CHECK (meal_frequency >= 1 AND meal_frequency <= 10),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id)
);

-- user_stats
CREATE TABLE public.user_stats (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  height_cm DECIMAL(5,2),
  weight_kg DECIMAL(5,2),
  body_fat_percentage DECIMAL(4,2),
  target_weight_kg DECIMAL(5,2),
  recorded_at TIMESTAMPTZ DEFAULT NOW()
);

-- exercises (exercise library)
CREATE TABLE public.exercises (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  description TEXT,
  muscle_group TEXT NOT NULL,
  equipment TEXT[],
  difficulty TEXT CHECK (difficulty IN ('beginner', 'intermediate', 'advanced')),
  video_url TEXT,
  image_url TEXT,
  is_public BOOLEAN DEFAULT true,
  created_by UUID REFERENCES profiles(id),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- workouts
CREATE TABLE public.workouts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  description TEXT,
  type TEXT CHECK (type IN ('strength', 'cardio', 'flexibility', 'hiit', 'mixed', 'custom')),
  difficulty TEXT CHECK (difficulty IN ('beginner', 'intermediate', 'advanced', 'expert')),
  duration_minutes INTEGER CHECK (duration_minutes > 0 AND duration_minutes <= 300),
  is_template BOOLEAN DEFAULT false,
  is_public BOOLEAN DEFAULT false,
  is_shared BOOLEAN DEFAULT false,
  target_goal TEXT CHECK (target_goal IN ('weight_loss', 'muscle_gain', 'maintain_fitness', 'improve_endurance', 'strength_building', 'flexibility', 'general_health')),
  target_level TEXT CHECK (target_level IN ('beginner', 'intermediate', 'advanced', 'expert')),
  days_per_week INTEGER CHECK (days_per_week >= 1 AND days_per_week <= 7),
  equipment_required TEXT[] DEFAULT '{}' CHECK (equipment_required <@ ARRAY['full_gym', 'home_basic_weights', 'no_equipment', 'cardio_equipment', 'resistance_bands', 'dumbbells', 'barbell', 'kettlebell']),
  user_notes TEXT,
  tags TEXT[] DEFAULT '{}',
  share_count INTEGER DEFAULT 0,
  like_count INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- shared_workouts
CREATE TABLE public.shared_workouts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  original_workout_id UUID REFERENCES workouts(id) ON DELETE CASCADE,
  shared_by_user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  shared_with_user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  shared_at TIMESTAMPTZ DEFAULT NOW(),
  is_accepted BOOLEAN DEFAULT false,
  accepted_at TIMESTAMPTZ,
  UNIQUE(original_workout_id, shared_with_user_id)
);

-- workout_exercises (M2M relationship)
CREATE TABLE public.workout_exercises (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  workout_id UUID REFERENCES workouts(id) ON DELETE CASCADE,
  exercise_id UUID REFERENCES exercises(id) ON DELETE CASCADE,
  order_index INTEGER NOT NULL,
  sets INTEGER,
  reps INTEGER,
  weight_kg DECIMAL(5,2),
  rest_seconds INTEGER,
  notes TEXT
);

-- workout_sessions (completed sessions)
CREATE TABLE public.workout_sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  workout_id UUID REFERENCES workouts(id) ON DELETE SET NULL,
  started_at TIMESTAMPTZ NOT NULL,
  completed_at TIMESTAMPTZ,
  duration_minutes INTEGER,
  calories_burned INTEGER,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Social features
CREATE TABLE public.posts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  post_type TEXT NOT NULL CHECK (post_type IN ('achievement', 'routine', 'tip', 'progress', 'motivation', 'question', 'general')),
  workout_id UUID REFERENCES workouts(id) ON DELETE SET NULL,
  image_urls TEXT[] DEFAULT '{}',
  video_url TEXT,
  hashtags TEXT[] DEFAULT '{}',
  likes_count INTEGER DEFAULT 0,
  comments_count INTEGER DEFAULT 0,
  shares_count INTEGER DEFAULT 0,
  reposts_count INTEGER DEFAULT 0,
  is_public BOOLEAN DEFAULT true,
  is_original BOOLEAN DEFAULT true, -- false if it's a repost
  original_post_id UUID REFERENCES posts(id) ON DELETE SET NULL, -- for reposts
  shared_from_user_id UUID REFERENCES profiles(id) ON DELETE SET NULL, -- user who originally shared
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- shared_posts
CREATE TABLE public.post_shares (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  post_id UUID REFERENCES posts(id) ON DELETE CASCADE,
  shared_by_user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  shared_with_user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  share_type TEXT CHECK (share_type IN ('share', 'repost', 'forward')),
  shared_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(post_id, shared_by_user_id, shared_with_user_id)
);

-- reposts
CREATE TABLE public.post_reposts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  original_post_id UUID REFERENCES posts(id) ON DELETE CASCADE,
  reposted_by_user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  reposted_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(original_post_id, reposted_by_user_id)
);

CREATE TABLE public.follows (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  follower_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  following_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(follower_id, following_id),
  CHECK (follower_id != following_id)
);

CREATE TABLE public.likes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  post_id UUID REFERENCES posts(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, post_id)
);

CREATE TABLE public.comments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  post_id UUID REFERENCES posts(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  parent_comment_id UUID REFERENCES comments(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

#### Row Level Security (RLS)

Implement security policies for each table:
- Profiles: users can read public profiles, modify only their own
- Workouts: read public + own workouts, modify only their own
- Posts: read public, modify only their own

#### Indexes and Optimization

```sql
-- Critical indexes for performance
CREATE INDEX idx_profiles_username ON profiles(username);
CREATE INDEX idx_workouts_user_id ON workouts(user_id);
CREATE INDEX idx_posts_user_id ON posts(user_id);
CREATE INDEX idx_posts_created_at ON posts(created_at DESC);
CREATE INDEX idx_follows_follower ON follows(follower_id);
CREATE INDEX idx_follows_following ON follows(following_id);
```

#### Database Schema Diagrams

##### Main ER Diagram - Core Entities

```mermaid
erDiagram
    %% === MAIN ENTITIES ===
    PROFILES {
        uuid id PK "Reference to auth.users"
        text username UK "Unique username"
        text full_name "Full name"
        text avatar_url "Avatar URL"
        text bio "User biography"
        date date_of_birth "Date of birth"
        text gender "Gender (male/female/other/prefer_not_to_say)"
        text fitness_level "Fitness level (beginner/intermediate/advanced/expert)"
        timestamptz created_at "Creation date"
        timestamptz updated_at "Last update date"
    }
    
    %% === DETAILED PERSONAL INFORMATION ===
    USER_PERSONAL_INFO {
        uuid id PK "Unique ID"
        uuid user_id FK "Reference to profiles"
        integer age "Age (13-120)"
        decimal weight_kg "Weight in kg"
        integer height_cm "Height in cm"
        decimal bmi "Body Mass Index"
        decimal body_fat_percentage "Body fat percentage"
        timestamptz created_at "Creation date"
        timestamptz updated_at "Last update date"
    }
    
    USER_FITNESS_PROFILE {
        uuid id PK "Unique ID"
        uuid user_id FK "Reference to profiles"
        text experience_level "Experience level"
        text primary_goal "Primary fitness goal"
        text[] secondary_goals "Secondary goals"
        integer workout_frequency "Workout frequency (1-7 days)"
        integer preferred_workout_duration "Preferred duration in minutes"
        text[] available_equipment "Available equipment"
        jsonb workout_preferences "Workout preferences"
        text[] injury_history "Injury history"
        text[] medical_restrictions "Medical restrictions"
        text fitness_goals_timeline "Goals timeline"
        integer motivation_level "Motivation level (1-10)"
        timestamptz created_at "Creation date"
        timestamptz updated_at "Last update date"
    }
    
    USER_DIETARY_PREFERENCES {
        uuid id PK "Unique ID"
        uuid user_id FK "Reference to profiles"
        text[] dietary_restrictions "Dietary restrictions"
        text[] allergies "Allergies"
        text[] preferred_cuisines "Preferred cuisines"
        text[] disliked_foods "Disliked foods"
        integer daily_calorie_target "Daily calorie target"
        decimal protein_target_percentage "Protein target (%)"
        decimal carb_target_percentage "Carbohydrate target (%)"
        decimal fat_target_percentage "Fat target (%)"
        text meal_preferences "Meal preferences"
        timestamptz created_at "Creation date"
        timestamptz updated_at "Last update date"
    }
    
    USER_STATS {
        uuid id PK "Unique ID"
        uuid user_id FK "Reference to profiles"
        decimal height_cm "Height in cm"
        decimal weight_kg "Weight in kg"
        decimal body_fat_percentage "Body fat percentage"
        decimal target_weight_kg "Target weight in kg"
        timestamptz recorded_at "Record date"
    }
    
    %% === EXERCISES AND WORKOUTS ===
    EXERCISES {
        uuid id PK "Unique ID"
        text name "Exercise name"
        text description "Detailed description"
        text muscle_group "Primary muscle group"
        text[] muscle_groups "Secondary muscle groups"
        text[] equipment "Required equipment"
        text difficulty "Difficulty level (beginner/intermediate/advanced/expert)"
        text instructions "Execution instructions"
        text video_url "Demo video URL"
        text image_url "Image URL"
        text[] tags "Exercise tags"
        boolean is_public "Public visibility"
        uuid created_by FK "Exercise creator"
        timestamptz created_at "Creation date"
        timestamptz updated_at "Last update date"
    }
    
    WORKOUTS {
        uuid id PK "Unique ID"
        uuid user_id FK "Reference to profiles"
        text name "Workout name"
        text description "Workout description"
        text type "Workout type"
        text difficulty "Workout difficulty"
        integer duration_minutes "Duration in minutes"
        boolean is_template "Is template"
        boolean is_public "Public visibility"
        boolean is_shared "Is shared"
        text target_goal "Workout target goal"
        text target_level "Target level"
        integer days_per_week "Days per week"
        text[] equipment_required "Required equipment"
        text user_notes "User notes"
        text[] tags "Workout tags"
        integer share_count "Share counter"
        integer like_count "Like counter"
        timestamptz created_at "Creation date"
        timestamptz updated_at "Last update date"
    }
    
    SHARED_WORKOUTS {
        uuid id PK "Unique ID"
        uuid original_workout_id FK "Reference to original workout"
        uuid shared_by_user_id FK "User who shares"
        uuid shared_with_user_id FK "User who receives"
        timestamptz shared_at "Share date"
        boolean is_accepted "Accepted by recipient"
        timestamptz accepted_at "Acceptance date"
    }
    
    WORKOUT_EXERCISES {
        uuid id PK "Unique ID"
        uuid workout_id FK "Reference to workout"
        uuid exercise_id FK "Reference to exercise"
        integer order_index "Order in workout"
        integer sets "Number of sets"
        integer reps "Number of repetitions"
        decimal weight_kg "Weight in kg"
        integer rest_seconds "Rest in seconds"
        text notes "Specific notes"
    }
    
    WORKOUT_SESSIONS {
        uuid id PK "Unique ID"
        uuid user_id FK "Reference to profiles"
        uuid workout_id FK "Reference to workout"
        timestamptz started_at "Start time"
        timestamptz completed_at "Completion time"
        integer duration_minutes "Duration in minutes"
        integer calories_burned "Calories burned"
        text notes "Session notes"
        timestamptz created_at "Creation date"
    }
    
    %% === SOCIAL FEATURES ===
    POSTS {
        uuid id PK "Unique ID"
        uuid user_id FK "Reference to profiles"
        text content "Post content"
        text post_type "Post type (achievement/routine/tip/progress/motivation/question/general)"
        uuid workout_id FK "Reference to workout (optional)"
        text[] image_urls "Image URLs"
        text video_url "Video URL"
        text[] hashtags "Post hashtags"
        integer likes_count "Likes counter"
        integer comments_count "Comments counter"
        integer shares_count "Shares counter"
        integer reposts_count "Reposts counter"
        boolean is_public "Public visibility"
        boolean is_original "Is original content"
        uuid original_post_id FK "Reference to original post (reposts)"
        uuid shared_from_user_id FK "User who originally shared"
        timestamptz created_at "Creation date"
        timestamptz updated_at "Last update date"
    }
    
    POST_LIKES {
        uuid id PK "Unique ID"
        uuid user_id FK "Reference to profiles"
        uuid post_id FK "Reference to post"
        timestamptz created_at "Creation date"
    }
    
    POST_COMMENTS {
        uuid id PK "Unique ID"
        uuid user_id FK "Reference to profiles"
        uuid post_id FK "Reference to post"
        text content "Comment content"
        uuid parent_comment_id FK "Reference to parent comment (replies)"
        timestamptz created_at "Creation date"
        timestamptz updated_at "Last update date"
    }
    
    POST_SHARES {
        uuid id PK "Unique ID"
        uuid post_id FK "Reference to post"
        uuid shared_by_user_id FK "User who shares"
        uuid shared_with_user_id FK "User who receives"
        text share_type "Share type (share/repost/forward)"
        timestamptz shared_at "Share date"
    }
    
    POST_REPOSTS {
        uuid id PK "Unique ID"
        uuid original_post_id FK "Reference to original post"
        uuid reposted_by_user_id FK "User who reposts"
        timestamptz reposted_at "Repost date"
    }
    
    %% === FOLLOW SYSTEM ===
    FOLLOWS {
        uuid id PK "Unique ID"
        uuid follower_id FK "User who follows"
        uuid following_id FK "User being followed"
        timestamptz created_at "Follow date"
    }
    
    %% === USER CONFIGURATION ===
    USER_SETTINGS {
        uuid id PK "Unique ID"
        uuid user_id FK "Reference to profiles"
        boolean email_notifications "Email notifications"
        boolean push_notifications "Push notifications"
        boolean workout_reminders "Workout reminders"
        text timezone "Timezone"
        text language "Preferred language"
        text theme "App theme"
        boolean profile_visibility "Profile visibility"
        boolean workout_visibility "Workout visibility"
        boolean progress_visibility "Progress visibility"
        timestamptz created_at "Creation date"
        timestamptz updated_at "Last update date"
    }
    
    %% === MAIN RELATIONSHIPS ===
    %% User and personal information
    PROFILES ||--o{ USER_PERSONAL_INFO : "has"
    PROFILES ||--o{ USER_FITNESS_PROFILE : "has"
    PROFILES ||--o{ USER_DIETARY_PREFERENCES : "has"
    PROFILES ||--o{ USER_STATS : "records"
    PROFILES ||--o{ USER_SETTINGS : "configures"
    
    %% User and content
    PROFILES ||--o{ EXERCISES : "creates"
    PROFILES ||--o{ WORKOUTS : "creates"
    PROFILES ||--o{ POSTS : "publishes"
    PROFILES ||--o{ WORKOUT_SESSIONS : "performs"
    
    %% Social system
    PROFILES ||--o{ FOLLOWS : "follows"
    PROFILES ||--o{ FOLLOWS : "followed_by"
    PROFILES ||--o{ POST_LIKES : "likes"
    PROFILES ||--o{ POST_COMMENTS : "comments"
    PROFILES ||--o{ POST_SHARES : "shares"
    PROFILES ||--o{ POST_REPOSTS : "reposts"
    PROFILES ||--o{ SHARED_WORKOUTS : "shares_workout"
    PROFILES ||--o{ SHARED_WORKOUTS : "receives_workout"
    
    %% Workouts and exercises
    WORKOUTS ||--o{ WORKOUT_EXERCISES : "contains"
    EXERCISES ||--o{ WORKOUT_EXERCISES : "included_in"
    WORKOUTS ||--o{ WORKOUT_SESSIONS : "executed_as"
    WORKOUTS ||--o{ SHARED_WORKOUTS : "shared_as"
    WORKOUTS ||--o{ POSTS : "featured_in"
    
    %% Posts and interactions
    POSTS ||--o{ POST_LIKES : "receives_likes"
    POSTS ||--o{ POST_COMMENTS : "has_comments"
    POSTS ||--o{ POST_SHARES : "is_shared"
    POSTS ||--o{ POST_REPOSTS : "is_reposted"
    POST_COMMENTS ||--o{ POST_COMMENTS : "replies_to"
    
    %% Sharing relationships
    POSTS ||--o{ POST_SHARES : "shared_via"
    POSTS ||--o{ POST_REPOSTS : "reposted_as"
```

# Principal ER Diagram (Simplified)

```mermaid
erDiagram
    PROFILES {
        uuid id PK
        text username UK
        text full_name
        text avatar_url
        text bio
        date date_of_birth
        text gender
        text fitness_level
        timestamptz created_at
        timestamptz updated_at
    }
    
    USER_STATS {
        uuid id PK
        uuid user_id FK
        decimal height_cm
        decimal weight_kg
        decimal body_fat_percentage
        decimal target_weight_kg
        timestamptz recorded_at
    }
    
    EXERCISES {
        uuid id PK
        text name
        text description
        text muscle_group
        text[] equipment
        text difficulty
        text video_url
        text image_url
        boolean is_public
        uuid created_by FK
        timestamptz created_at
    }
    
    WORKOUTS {
        uuid id PK
        uuid user_id FK
        text name
        text description
        text type
        text difficulty
        integer duration_minutes
        boolean is_template
        boolean is_public
        timestamptz created_at
        timestamptz updated_at
    }
    
    WORKOUT_EXERCISES {
        uuid id PK
        uuid workout_id FK
        uuid exercise_id FK
        integer order_index
        integer sets
        integer reps
        decimal weight_kg
        integer rest_seconds
        text notes
    }
    
    WORKOUT_SESSIONS {
        uuid id PK
        uuid user_id FK
        uuid workout_id FK
        timestamptz started_at
        timestamptz completed_at
        integer duration_minutes
        integer calories_burned
        text notes
        timestamptz created_at
    }
    
    POSTS {
        uuid id PK
        uuid user_id FK
        text content
        uuid workout_id FK
        text image_url
        integer likes_count
        integer comments_count
        boolean is_public
        timestamptz created_at
        timestamptz updated_at
    }
    
    FOLLOWS {
        uuid id PK
        uuid follower_id FK
        uuid following_id FK
        timestamptz created_at
    }
    
    LIKES {
        uuid id PK
        uuid user_id FK
        uuid post_id FK
        timestamptz created_at
    }
    
    COMMENTS {
        uuid id PK
        uuid user_id FK
        uuid post_id FK
        text content
        uuid parent_comment_id FK
        timestamptz created_at
        timestamptz updated_at
    }
    
    PROFILES ||--o{ USER_STATS : "has"
    PROFILES ||--o{ WORKOUTS : "creates"
    PROFILES ||--o{ EXERCISES : "creates"
    PROFILES ||--o{ POSTS : "writes"
    PROFILES ||--o{ FOLLOWS : "follower"
    PROFILES ||--o{ FOLLOWS : "following"
    PROFILES ||--o{ LIKES : "gives"
    PROFILES ||--o{ COMMENTS : "writes"
    
    WORKOUTS ||--o{ WORKOUT_EXERCISES : "contains"
    EXERCISES ||--o{ WORKOUT_EXERCISES : "included_in"
    WORKOUTS ||--o{ WORKOUT_SESSIONS : "completed_as"
    PROFILES ||--o{ WORKOUT_SESSIONS : "performs"
    
    POSTS ||--o{ LIKES : "receives"
    POSTS ||--o{ COMMENTS : "has"
    COMMENTS ||--o{ COMMENTS : "replies_to"
    WORKOUTS ||--o{ POSTS : "featured_in"
```



##### Social Relationships Diagram

```mermaid
erDiagram
    PROFILES {
        uuid id PK
        text username UK
        text full_name
        text avatar_url
        text bio
        text fitness_level
    }
    
    POSTS {
        uuid id PK
        uuid user_id FK
        text content
        uuid workout_id FK
        text image_url
        integer likes_count
        integer comments_count
        boolean is_public
        timestamptz created_at
    }
    
    FOLLOWS {
        uuid id PK
        uuid follower_id FK
        uuid following_id FK
        timestamptz created_at
    }
    
    LIKES {
        uuid id PK
        uuid user_id FK
        uuid post_id FK
        timestamptz created_at
    }
    
    COMMENTS {
        uuid id PK
        uuid user_id FK
        uuid post_id FK
        text content
        uuid parent_comment_id FK
        timestamptz created_at
    }
    
    PROFILES ||--o{ POSTS : "creates"
    PROFILES ||--o{ FOLLOWS : "follower"
    PROFILES ||--o{ FOLLOWS : "following"
    PROFILES ||--o{ LIKES : "gives"
    PROFILES ||--o{ COMMENTS : "writes"
    
    POSTS ||--o{ LIKES : "receives"
    POSTS ||--o{ COMMENTS : "has"
    COMMENTS ||--o{ COMMENTS : "replies_to"
```

##### Workouts and Exercises Diagram

```mermaid
erDiagram
    PROFILES {
        uuid id PK
        text username UK
        text fitness_level
    }
    
    EXERCISES {
        uuid id PK
        text name
        text muscle_group
        text[] equipment
        text difficulty
        boolean is_public
        uuid created_by FK
    }
    
    WORKOUTS {
        uuid id PK
        uuid user_id FK
        text name
        text type
        text difficulty
        integer duration_minutes
        boolean is_template
        boolean is_public
    }
    
    WORKOUT_EXERCISES {
        uuid id PK
        uuid workout_id FK
        uuid exercise_id FK
        integer order_index
        integer sets
        integer reps
        decimal weight_kg
        integer rest_seconds
        text notes
    }
    
    WORKOUT_SESSIONS {
        uuid id PK
        uuid user_id FK
        uuid workout_id FK
        timestamptz started_at
        timestamptz completed_at
        integer duration_minutes
        integer calories_burned
    }
    
    PROFILES ||--o{ EXERCISES : "creates"
    PROFILES ||--o{ WORKOUTS : "creates"
    PROFILES ||--o{ WORKOUT_SESSIONS : "performs"
    
    WORKOUTS ||--o{ WORKOUT_EXERCISES : "contains"
    EXERCISES ||--o{ WORKOUT_EXERCISES : "included_in"
    WORKOUTS ||--o{ WORKOUT_SESSIONS : "completed_as"
```

##### User Statistics Diagram

```mermaid
erDiagram
    PROFILES {
        uuid id PK
        text username UK
        text full_name
        text fitness_level
        timestamptz created_at
    }
    
    USER_STATS {
        uuid id PK
        uuid user_id FK
        decimal height_cm
        decimal weight_kg
        decimal body_fat_percentage
        decimal target_weight_kg
        timestamptz recorded_at
    }
    
    WORKOUT_SESSIONS {
        uuid id PK
        uuid user_id FK
        uuid workout_id FK
        timestamptz started_at
        timestamptz completed_at
        integer duration_minutes
        integer calories_burned
    }
    
    PROFILES ||--o{ USER_STATS : "tracks"
    PROFILES ||--o{ WORKOUT_SESSIONS : "performs"
```

##### Indexes and Performance Diagram

```mermaid
graph TB
    subgraph "Tabla: profiles"
        P1[PRIMARY KEY: id]
        P2[UNIQUE: username]
        P3[INDEX: created_at]
    end
    
    subgraph "Tabla: workouts"
        W1[PRIMARY KEY: id]
        W2[INDEX: user_id]
        W3[INDEX: type]
        W4[INDEX: is_public]
        W5[INDEX: created_at]
    end
    
    subgraph "Tabla: posts"
        PO1[PRIMARY KEY: id]
        PO2[INDEX: user_id]
        PO3[INDEX: created_at DESC]
        PO4[INDEX: is_public]
        PO5[INDEX: workout_id]
    end
    
    subgraph "Tabla: follows"
        F1[PRIMARY KEY: id]
        F2[UNIQUE: follower_id, following_id]
        F3[INDEX: follower_id]
        F4[INDEX: following_id]
    end
    
    subgraph "Tabla: likes"
        L1[PRIMARY KEY: id]
        L2[UNIQUE: user_id, post_id]
        L3[INDEX: post_id]
        L4[INDEX: user_id]
    end
    
    subgraph "Tabla: comments"
        C1[PRIMARY KEY: id]
        C2[INDEX: post_id]
        C3[INDEX: user_id]
        C4[INDEX: parent_comment_id]
        C5[INDEX: created_at]
    end
    
    subgraph "Tabla: workout_exercises"
        WE1[PRIMARY KEY: id]
        WE2[INDEX: workout_id]
        WE3[INDEX: exercise_id]
        WE4[INDEX: order_index]
    end
    
    subgraph "Tabla: workout_sessions"
        WS1[PRIMARY KEY: id]
        WS2[INDEX: user_id]
        WS3[INDEX: workout_id]
        WS4[INDEX: started_at]
        WS5[INDEX: completed_at]
    end
```

##### Row Level Security (RLS) Diagram

```mermaid
graph TB
    subgraph "RLS Policies"
        RLS1[profiles: users can read public, modify only their own]
        RLS2[workouts: read public + own, modify only own]
        RLS3[posts: read public, modify only own]
        RLS4[user_stats: only the owner can view/modify]
        RLS5[workout_sessions: only the owner can view/modify]
        RLS6[follows: only the follower can see their follows]
        RLS7[likes: only the user can see their likes]
        RLS8[comments: read public, modify only own]
    end
    
    subgraph "User Roles"
        ROLE1[authenticated: logged-in user]
        ROLE2[anon: unauthenticated user]
        ROLE3[service_role: internal services]
    end
    
    ROLE1 --> RLS1
    ROLE1 --> RLS2
    ROLE1 --> RLS3
    ROLE1 --> RLS4
    ROLE1 --> RLS5
    ROLE1 --> RLS6
    ROLE1 --> RLS7
    ROLE1 --> RLS8
    
    ROLE2 --> RLS1
    ROLE2 --> RLS2
    ROLE2 --> RLS3
    ROLE2 --> RLS8
    
    ROLE3 --> RLS1
    ROLE3 --> RLS2
    ROLE3 --> RLS3
    ROLE3 --> RLS4
    ROLE3 --> RLS5
    ROLE3 --> RLS6
    ROLE3 --> RLS7
    ROLE3 --> RLS8
```
---

## 3. Software Architecture 🔄

### Capability Map
- **Auth and Profiles**: registration/login, profiles, nutrition/workout goals, body metrics.
- **Workout**: exercises, weekly plan, progress tracking, PRs.
- **Nutrition**: diet templates, macros, calories, history.
- **Social**: posts, comments, likes, followers, reports/moderation.
- **AI Chatbot**: contextual assistant per user (web) and automated flows (n8n).
- **Recommendations**: routine suggestions, friends and content (Dify AI).
- **Notifications**: email, in-app, and messaging (Telegram/WhatsApp via n8n).

### Logical Diagram (High Level)
```mermaid
graph TB
  subgraph Frontend ["Frontend: Next.js"]
    UI["UI + shadcn/ui"]
    FEAuth["Auth Client"]
    FEAPI["API Client"]
  end

  subgraph Backend ["Backend: Node + Hono"]
    API["REST API"]
    WS["WebSocket"]
    SVC_USER["User / Profile Service"]
    SVC_WORKOUT["Workout Service"]
    SVC_NUTR["Nutrition Service"]
    SVC_SOCIAL["Social Service"]
    SVC_CHAT["Chat Orchestrator"]
    SVC_REC["Recommendation Proxy"]
  end

  subgraph Plataforma ["Plataforma"]
    SUPA["Supabase: Postgres / Auth / Storage"]
    N8N["n8n Workflows"]
    TELEGRAM["Telegram Bot"]
    DIFY["Dify AI"]
    MAIL["Proton Mail"]
    OBS["Prometheus / Grafana / Promtail"]
  end

  UI --> FEAPI
  FEAPI --> API
  FEAuth --> API

  API --> SVC_USER --> SUPA
  API --> SVC_WORKOUT --> SUPA
  API --> SVC_NUTR --> SUPA
  API --> SVC_SOCIAL --> SUPA
  API --> SVC_CHAT --> N8N
  API --> SVC_REC --> DIFY
  N8N --> MAIL
  N8N --> TELEGRAM
```

```mermaid
graph TB
    subgraph "🎯 GymPal Platform"
        subgraph "Frontend Layer"
            A[React/Next.js Web App]
            B[PWA Mobile App]
            C[Admin Dashboard]
        end
        
        subgraph "API Layer"
            D[Hono API Gateway<br/>31 Endpoints]
            E[Authentication<br/>JWT + RLS]
            F[Rate Limiting<br/>100 req/min]
            G[Validation<br/>Zod Schemas]
        end
        
        subgraph "Business Logic"
            H[User Management<br/>9 Handlers]
            I[Workout System<br/>Routines + Exercises]
            J[Social Features<br/>Posts + Interactions]
            K[AI Integration<br/>Dify Platform]
            L[Analytics<br/>Dashboard + Stats]
        end
        
        subgraph "Data Layer"
            M[Supabase PostgreSQL<br/>17 Tables]
            N[Supabase Auth<br/>User Management]
            O[Supabase Storage<br/>Media Files]
            P[Redis Cache<br/>Performance]
        end
        
        subgraph "External Services"
            Q[Dify AI<br/>Recommendations]
            R[n8n Workflows<br/>Automation]
            S[Email Service<br/>Notifications]
            T[Push Notifications<br/>Real-time]
        end
    end
    
    %% Connections
    A --> D
    B --> D
    C --> D
    
    D --> E
    E --> F
    F --> G
    G --> H
    G --> I
    G --> J
    G --> K
    G --> L
    
    H --> M
    I --> M
    J --> M
    K --> Q
    L --> M
    
    H --> N
    I --> O
    J --> P
    
    D --> R
    D --> S
    D --> T
    
    %% Styling
    classDef frontend fill:#e1f5fe
    classDef api fill:#f3e5f5
    classDef business fill:#e8f5e8
    classDef data fill:#fff3e0
    classDef external fill:#fce4ec
    
    class A,B,C frontend
    class D,E,F,G api
    class H,I,J,K,L business
    class M,N,O,P data
    class Q,R,S,T external
```

---

### Frontend Architecture (Feature-Slice)

```mermaid
graph TB
  subgraph "Frontend Application (Next.js + shadcn/ui)"
    subgraph "Pages"
      HOME[Home]
      FEED[Social Feed]
      WORKOUTS[Workouts]
      DIETS[Diets]
      PROFILE[Profile]
      CHAT[AI Chat]
    end

    subgraph "Feature Modules"
      AUTH_MOD[Auth Module]
      WORKOUT_MOD[Workout Module]
      NUTR_MOD[Nutrition Module]
      SOCIAL_MOD[Social Module]
      AI_MOD[AI Module]
      NOTIF_MOD[Notifications]
    end

    subgraph "Core Components"
      NAV[Navigation]
      LAYOUT[Layout]
      THEME[Theme]
      FORM[Forms]
      CHARTS[Charts]
    end

    subgraph "State and Services"
      QUERY[React Query]
      STORE[Zustand]
      API_CLIENT[API Client]
      AUTH_CLIENT[Auth Client]
    end
  end

  HOME & FEED & WORKOUTS & DIETS & PROFILE & CHAT --> LAYOUT
  AUTH_MOD & WORKOUT_MOD & NUTR_MOD & SOCIAL_MOD & AI_MOD & NOTIF_MOD --> API_CLIENT
  API_CLIENT --> QUERY
  AUTH_CLIENT --> AUTH_MOD
  QUERY --> STORE
  THEME --> LAYOUT
  FORM --> WORKOUT_MOD & NUTR_MOD & SOCIAL_MOD
  CHARTS --> PROFILE
```

### Frontend Directory Structure

```
frontend/
├── src/
│   ├── app/                    # Next.js App Router
│   │   ├── (auth)/            # Auth routes group
│   │   ├── (dashboard)/       # Protected routes
│   │   ├── layout.tsx
│   │   └── page.tsx
│   ├── components/            # React components
│   │   ├── ui/               # shadcn components
│   │   ├── workout/          # Domain components
│   │   ├── social/
│   │   └── shared/
│   ├── lib/                   # Utilities
│   │   ├── api/              # API client
│   │   ├── auth/             # Auth helpers
│   │   └── utils.ts
│   ├── hooks/                 # Custom React hooks
│   ├── stores/                # Zustand stores
│   └── types/                 # TypeScript types
├── public/
└── package.json
```

---

### Microservices Communication (async + sync)
```mermaid
graph TB
  API[API Gateway] -- REST --> USER
  API -- REST --> WORKOUT
  API -- REST --> NUTR
  API -- REST --> SOCIAL
  API -- REST --> RECO
  SOCIAL -- Event(NewPost) --> BUS[(Event Bus)]
  BUS --> N8N
  BUS --> NOTIF
  RECO -- REST --> DIFY
  NOTIF -- SMTP --> MAIL

### Event Flow: Workout Progress
```mermaid
sequenceDiagram
  participant FE as Frontend
  participant API as API Gateway
  participant WO as Workout Service
  participant BUS as Event Bus
  participant RECO as Reco Service
  FE->>API: POST /workouts/{id}/logs
  API->>WO: Register set
  WO-->>API: OK
  WO->>BUS: Event(WorkoutProgressLogged)
  BUS->>RECO: Consume event
  RECO->>RECO: Recalculate recommendations
  RECO-->>API: Updated metrics
```

---

### User State
```mermaid
stateDiagram-v2
  [*] --> Guest
  Guest --> Registering: Start registration
  Registering --> Authenticated: Registration OK
  Registering --> Guest: Error
  Guest --> LoggingIn: Login
  LoggingIn --> Authenticated: OK
  LoggingIn --> Guest: Error
  Authenticated --> UpdatingProfile: Edit profile/goals
  UpdatingProfile --> Authenticated: Saved
  Authenticated --> Planning: Generate plan (workout/diet)
  Planning --> FollowingPlan: Assigned plan
  FollowingPlan --> LoggingProgress: Log progress
  LoggingProgress --> FollowingPlan: Update metrics
  Authenticated --> Socializing: Post/Comment
  Socializing --> Authenticated
  Authenticated --> [*]: Logout
```

### AI Chatbot State
```mermaid
stateDiagram-v2
  [*] --> Idle
  Idle --> SessionInit: User opens chat
  SessionInit --> ContextLoad: Load context (profile/last messages)
  ContextLoad --> WaitingPrompt
  WaitingPrompt --> Thinking: Receive prompt
  Thinking --> ToolUse: Use tools (reco/exercises/macros)
  ToolUse --> Responding
  Thinking --> Responding
  Responding --> WaitingPrompt
  WaitingPrompt --> Closing: Inactivity/end
  Closing --> [*]
```

### Client-Server Communication (Login + Data Fetch)
```mermaid
sequenceDiagram
    participant U as User
  participant FE as Frontend
  participant API as API Gateway
    participant US as User Service
  U->>FE: Enter credentials
  FE->>API: POST /auth/login
  API->>US: Validate
  US-->>API: JWT + basic profile
  API-->>FE: 200 + tokens
  FE->>API: GET /users/{id}/summary (Bearer)
  API->>US: Get summary
  US-->>API: Summary JSON
  API-->>FE: 200 Summary
```

### Backend-Frontend Communication (SSR/CSR)

```mermaid
graph TB
  subgraph Frontend
    NEXT[Next.js App Router]
    CSR[CSR Fetch]
    SSR[SSR on server]
  end
  subgraph Backend
    API[REST API]
    AUTH[Auth Provider]
  end
  NEXT --> SSR --> API
  NEXT --> CSR --> API
  API --> AUTH
```
```mermaid
graph TB
    subgraph "Frontend (Next.js)"
        COMPONENT[React Component]
        ZUSTAND[Zustand Store]
        API_CLIENT[API Client]
    end
    
    subgraph "Backend (Hono)"
        ROUTES[Hono Routes]
        SERVICES[Business Services]
        DATABASE[(Supabase)]
    end
    
    COMPONENT --> ZUSTAND
    ZUSTAND --> API_CLIENT
    API_CLIENT --> ROUTES
    ROUTES --> SERVICES
    SERVICES --> DATABASE
```

### Realtime via WebSocket (notifications)
```mermaid
sequenceDiagram
  participant FE as Frontend
  participant WS as WebSocket Gateway
  participant NOTIF as Notification Service
  FE->>WS: CONNECT /ws
  NOTIF->>WS: send(NewComment on postId)
  WS-->>FE: event:new_comment { postId, author, text }
```

### API Request Lifecycle
```mermaid
graph TB
  REQ[HTTP Request] --> EDGE[Ingress/NGINX]
  EDGE --> GATE[API Gateway]
  GATE --> AUTHZ[AuthZ + RateLimit]
  AUTHZ --> HANDLER[Route Handler]
  HANDLER --> SERVICE[Domain Service]
  SERVICE --> DB[(Postgres)]
  SERVICE --> EXT[Ext: Dify/n8n]
  DB --> SERVICE
  SERVICE --> RESP[Response DTO]
  RESP --> GATE --> EDGE --> RES[HTTP Response]
```

### Session Lifecycle (tokens)
```mermaid
sequenceDiagram
  participant FE as Frontend
  participant API as API Gateway
  participant AUTH as Auth Provider
  FE->>API: POST /auth/login
  API->>AUTH: Verify credentials
  AUTH-->>API: access, refresh
  API-->>FE: tokens + cookie (optional)
  FE->>API: Request with Bearer
  API-->>FE: 200
  FE->>API: POST /auth/refresh (refresh token)
  API->>AUTH: Rotate
  AUTH-->>API: new access
  API-->>FE: 200 new access
```

### Backend Architecture (Layers)
```mermaid
graph TB
  subgraph API_Layer
    HONO[Hono Controllers]
    MIDDLE["Middleware: auth, rate limit, validation"]
  end
  subgraph Application_Layer
    USER_SVC[UserService]
    WORKOUT_SVC[WorkoutService]
    DIET_SVC[DietService]
    SOCIAL_SVC[SocialService]
    AI_SVC[AI Orchestrator]
  end
  subgraph Domain_Layer
    ENTITIES["Entities / Value Objects"]
    RULES[Domain Rules]
  end
  subgraph Infrastructure_Layer
    REPOS["Repositories (Supabase/Postgres)"]
    CACHE["Redis (optional)"]
    MQ["Event Bus (optional)"]
  end
  subgraph External_Services
    SUPA[Supabase]
    DIFY[Dify AI]
    N8N[n8n]
    SMTP["Proton Mail / SMTP"]
  end

  HONO --> MIDDLE
  MIDDLE --> USER_SVC
  MIDDLE --> WORKOUT_SVC
  MIDDLE --> DIET_SVC
  MIDDLE --> SOCIAL_SVC
  MIDDLE --> AI_SVC
  USER_SVC --> ENTITIES
  WORKOUT_SVC --> ENTITIES
  DIET_SVC --> ENTITIES
  SOCIAL_SVC --> ENTITIES
  ENTITIES --> RULES
  ENTITIES --> REPOS
  REPOS --> SUPA
  CACHE -. optional .-> REPOS
  AI_SVC --> DIFY
  SOCIAL_SVC --> MQ
  MQ --> N8N
  SOCIAL_SVC --> SMTP
```

### Detailed Service Communication Flow (with queues)
```mermaid
sequenceDiagram
  participant FE as Frontend
    participant API as API Gateway
  participant US as User Service
  participant SO as Social Service
  participant BUS as Event Bus
  participant N8 as n8n
  FE->>API: POST /posts
  API->>SO: Create Post
  SO-->>API: 201
  SO->>BUS: Event(PostCreated)
  BUS->>N8: Trigger notification flow
  N8-->>BUS: OK
```

### AI Recommendation System Flow
```mermaid
graph TB
  subgraph Data
    USAGE[User usage: exercises, diets, posts]
    PROFILE[Profile/goals/metrics]
    SOCIAL[Social interactions]
  end
  subgraph Processing
    FEATURES[Feature extraction]
    EMB[Embeddings]
    CF[Collaborative]
  end
  subgraph Engine
    DIFY[Dify Orchestrator]
    RANK[Ranking/Exploration]
  end
  subgraph Delivery
    API[API Recommendations]
    UI[UI Cards]
  end
  USAGE & PROFILE & SOCIAL --> FEATURES --> EMB & CF --> DIFY --> RANK --> API --> UI
```

### AUTH Security Validation and Authentication Flow
```mermaid
graph TD
    LOGIN["Login Request"]
    VALIDATE["Credential validation"]
    TOKENS["Issue JWT (access/refresh)"]
    HEADERS["Security Headers (CSP, HSTS)"]
    POLICIES["RBAC / ABAC"] 
    RATE["Rate Limit"]
    AUDIT["Audit"]
    RESP["200 OK"]

    LOGIN --> VALIDATE --> TOKENS
    TOKENS --> HEADERS
    TOKENS --> POLICIES --> RATE --> AUDIT --> RESP

```

### Real-time Events and WebSocket Communication Flow
```mermaid
graph TB
  FE[Frontend WS Client] -- CONNECT --> WSGW[WS Gateway]
  WSGW --> TOPIC[(Rooms/Topics)]
  NOTIF[Notification Service] --> WSGW
  SOCIAL[Social Service] --> WSGW
  WORKOUT[Workout Service] --> WSGW
  WSGW -- event --> FE
```

### Admin Management and Monitoring Flow
```mermaid
graph TB
  ADMIN[Admin Panel] --> METRICS[Grafana Dashboards]
  ADMIN --> USERS_MGMT[User management]
  ADMIN --> CONTENT_MGMT[Content moderation]
  ADMIN --> ALERTS[Alerts/Incidents]
  METRICS --> PROM[Prometheus]
  ALERTS --> N8N[n8n Runbooks]
```

### Scalability and Load Balancing Flow
```mermaid
 graph TD
  LOGIN[Login Request]
  CDN[CDN]
  LB[Load Balancer]
  INGRESS[Ingress NGINX]
  API["API Pods (HPA)"]
  SVCs["Services (HPA)"]
  DB["Postgres Read Replicas"]
  CACHE["Redis"]

  CDN --> LB --> INGRESS --> API --> SVCs
  SVCs --> DB
  SVCs --> CACHE 

  VALIDATE["Credential validation"]
  TOKENS["Issue JWT (access/refresh)"]
  HEADERS["Security Headers: CSP, HSTS"]
  POLICIES["RBAC / ABAC"]
  RATE["Rate Limit"]
  AUDIT["Audit"]
  RESP["200 OK"]

  LOGIN --> VALIDATE --> TOKENS
  TOKENS --> HEADERS
  TOKENS --> POLICIES --> RATE --> AUDIT --> RESP
```


### Microservices Architecture

```mermaid
graph TB
  subgraph "Gateway"
    GATE[API Gateway\nHono]
    WS_GW[WebSocket Gateway]
  end

  subgraph "Core Services"
    S_USER[User/Profile Service]
    S_WORKOUT[Workout Service]
    S_NUTR[Nutrition Service]
    S_SOCIAL[Social Service]
    S_CHAT[Chat Service]
    S_RECO[Recommendation Proxy]
    S_NOTIF[Notification Service]
  end

  subgraph "Platform and Data"
    DB[(PostgreSQL - Supabase)]
    STORAGE[(Storage - Supabase)]
    N8N[n8n Workflows]
    DIFY[Dify AI]
    MAIL[Proton Mail/SMTP]
    CACHE[(Optional Redis)]
  end

  GATE --> S_USER
  GATE --> S_WORKOUT
  GATE --> S_NUTR
  GATE --> S_SOCIAL
  GATE --> S_CHAT
  GATE --> S_RECO
  GATE --> S_NOTIF

  S_USER --> DB
  S_WORKOUT --> DB
  S_NUTR --> DB
  S_SOCIAL --> DB
  S_CHAT --> N8N
  S_RECO --> DIFY
  S_NOTIF --> MAIL

  S_USER --> STORAGE
  S_SOCIAL --> STORAGE
  S_CHAT -. optional .-> CACHE
```

### Complete Data Flow

```mermaid
sequenceDiagram
  participant U as User
  participant FE as Frontend
  participant API as API Gateway
  participant SVC as Microservice
  participant DB as PostgreSQL
  participant CACHE as Redis (optional)
  participant EXT as External Service
  participant WS as WebSocket
  participant N8N as n8n
  
  U->>FE: User action
  FE->>API: HTTP/WebSocket request
  API->>API: Auth validation + rate limit
  API->>SVC: Process request
  alt Redis (optional)
  SVC->>CACHE: Check cache
  alt Cache miss
    SVC->>DB: Query data
    DB-->>SVC: Data
    SVC->>CACHE: Update cache
  else Cache hit
    CACHE-->>SVC: Cached data
    end
  else Without Redis
    SVC->>DB: Query data directly
    DB-->>SVC: Data
  end
  
  alt External service required
    SVC->>EXT: External API call
    EXT-->>SVC: Response
  end
  
  SVC-->>API: Processed response
  API-->>FE: JSON Response
  
  alt Real-time event
    SVC->>WS: Emit event
    WS-->>FE: Push notification
  end
  
  alt n8n Workflow
    SVC->>N8N: Trigger workflow
    N8N->>N8N: Process workflow
  end
  
  FE-->>U: Update UI
```

### Schedule and Calendar Flow

```mermaid
sequenceDiagram
  participant U as User
  participant FE as Frontend
  participant API as API Gateway
  participant SCHEDULE as Schedule Service
  participant WORKOUT as Workout Service
  participant DIET as Diet Service
  participant DB as PostgreSQL
  participant WS as WebSocket
  
  U->>FE: Create/View schedule
  FE->>API: GET/POST /schedules
  API->>SCHEDULE: Process request
  
  alt Create schedule
    SCHEDULE->>DB: Save schedule
    SCHEDULE->>WORKOUT: Link workouts
    SCHEDULE->>DIET: Link diets
  else View schedule
    SCHEDULE->>DB: Query schedule
    SCHEDULE->>WORKOUT: Get workouts
    SCHEDULE->>DIET: Get diets
  end
  
  SCHEDULE-->>API: Complete schedule
  API-->>FE: JSON Response
  FE-->>U: Display calendar
  
  alt Weekly/monthly view
    SCHEDULE->>WS: Emit update
    WS-->>FE: Real-time update
  end
```

### Calorie Tracker Flow

```mermaid
sequenceDiagram
  participant U as User
  participant FE as Frontend
  participant API as API Gateway
  participant CALORIE as Calorie Service
  participant FOOD as Food Service
  participant DB as PostgreSQL
  participant N8N as n8n Workflows
  
  U->>FE: Log calories
  FE->>API: POST /calories/log
  API->>CALORIE: Process log
  
  CALORIE->>FOOD: Search food
  FOOD->>DB: Query database
  DB-->>FOOD: Nutrition data
  FOOD-->>CALORIE: Food info
  
  CALORIE->>DB: Save log
  CALORIE->>CALORIE: Calculate totals
  
  alt Goal achieved
    CALORIE->>N8N: Trigger congratulations
    N8N->>N8N: Send notification
  end
  
  CALORIE-->>API: Log saved
  API-->>FE: JSON Response
  FE-->>U: Update dashboard
```

### Weekly Calendar View

```mermaid
graph TB
  subgraph "Weekly View"
    MONDAY[Monday]
    TUESDAY[Tuesday]
    WEDNESDAY[Wednesday]
    THURSDAY[Thursday]
    FRIDAY[Friday]
    SATURDAY[Saturday]
    SUNDAY[Sunday]
  end
  
  subgraph "Day Elements"
    WORKOUT_ITEM["Workout"]
    DIET_ITEM["Diet"]
    REST_ITEM["Rest"]
    CUSTOM_ITEM["Custom"]
  end
  
  subgraph "Actions"
    ADD["+ Add"]
    EDIT["Edit"]
    DELETE["Delete"]
    DRAG["Drag"]
  end
  
  MONDAY --> WORKOUT_ITEM
  MONDAY --> DIET_ITEM
  TUESDAY --> WORKOUT_ITEM
  TUESDAY --> REST_ITEM
  WEDNESDAY --> WORKOUT_ITEM
  WEDNESDAY --> DIET_ITEM
  THURSDAY --> WORKOUT_ITEM
  THURSDAY --> REST_ITEM
  FRIDAY --> WORKOUT_ITEM
  FRIDAY --> DIET_ITEM
  SATURDAY --> CUSTOM_ITEM
  SUNDAY --> REST_ITEM
  
  WORKOUT_ITEM --> ADD
  DIET_ITEM --> EDIT
  CUSTOM_ITEM --> DELETE
  REST_ITEM --> DRAG
```

### Calorie Tracker Dashboard

```mermaid
graph TB
  subgraph "Main Dashboard"
    DAILY_GOAL[Daily Goal: 2000 cal]
    CONSUMED[Consumed: 1500 cal]
    REMAINING[Remaining: 500 cal]
    PROGRESS[Progress: 75%]
  end
  
  subgraph "Macros"
    PROTEIN[Protein: 120g]
    CARBS[Carbs: 200g]
    FAT[Fats: 65g]
  end
  
  subgraph "Meals of the Day"
    BREAKFAST[Breakfast: 400 cal]
    LUNCH[Lunch: 600 cal]
    DINNER[Dinner: 500 cal]
    SNACKS[Snacks: 0 cal]
  end
  
  subgraph "Quick Actions"
    ADD_FOOD[+ Add Food]
    SEARCH["Search Food"]
    SCAN["Scan Code"]
    QUICK_LOG["Quick Log"]
  end
  
  DAILY_GOAL --> CONSUMED
  CONSUMED --> REMAINING
  REMAINING --> PROGRESS
  
  CONSUMED --> PROTEIN
  CONSUMED --> CARBS
  CONSUMED --> FAT
  
  CONSUMED --> BREAKFAST
  CONSUMED --> LUNCH
  CONSUMED --> DINNER
  CONSUMED --> SNACKS
  
  ADD_FOOD --> SEARCH
  SEARCH --> SCAN
  SCAN --> QUICK_LOG
```

---

#### User Journey Diagram

```mermaid
journey
    title User Journey in GymPal
    section Registration
      Create account: 5: User
      Complete profile: 4: User
      Set goals: 3: User
    section Daily Use
      View dashboard: 5: User
      Create routine: 4: User
      Do workout: 5: User
      Share progress: 4: User
    section Social
      Follow users: 3: User
      Interact with posts: 4: User
      Receive AI recommendations: 5: User
    section Analytics
      View stats: 4: User
      Adjust settings: 3: User
      Export data: 2: User
```


### Detailed TypeScript Types

```typescript
// shared/types/user.types.ts
export interface UserProfile {
  id: string;
  email: string;
  displayName: string;
  avatarUrl?: string;
  profile: {
    bio?: string;
    gender?: 'male' | 'female' | 'other';
    birthDate?: string;
  };
  metrics: {
    heightCm: number;
    weightKg: number;
    bodyFatPct?: number;
  };
  goals: {
    objective: 'lose_weight' | 'gain_muscle' | 'maintain' | 'improve_endurance';
    weeklySessions: number;
    experienceLevel: 'beginner' | 'intermediate' | 'advanced';
  };
  createdAt: string;
  updatedAt: string;
}

// shared/types/workout.types.ts
export interface Exercise {
  id: string;
  name: string;
  muscleGroup: 'chest' | 'back' | 'legs' | 'shoulders' | 'arms' | 'core';
  equipment?: string;
  sets?: number;
  reps?: number;
  weightKg?: number;
  durationSec?: number;
  restSec?: number;
}

export interface WorkoutPlan {
  id: string;
  userId: string;
  name: string;
  description?: string;
  difficulty: 'beginner' | 'intermediate' | 'advanced';
  plan: {
    weeks: number;
    daysPerWeek: number;
    sessions: {
      dayOfWeek: number;
      exercises: Exercise[];
    }[];
  };
  progress: {
    completedSessions: number;
    totalSessions: number;
    lastCompletedDate?: string;
  };
  isPublic: boolean;
  createdAt: string;
  updatedAt: string;
}

export interface WorkoutLog {
  id: string;
  workoutId: string;
  userId: string;
  logDate: string;
  exercises: Exercise[];
  durationMinutes: number;
  notes?: string;
  createdAt: string;
}

// shared/types/social.types.ts
export type PostType = 'achievement' | 'routine' | 'progress' | 'tip';

export interface Post {
  id: string;
  userId: string;
  type: PostType;
  content: string;
  mediaUrls: string[];
  likesCount: number;
  commentsCount: number;
  createdAt: string;
  updatedAt: string;
  
  // Populated fields
  author?: Pick<UserProfile, 'id' | 'displayName' | 'avatarUrl'>;
  isLiked?: boolean;
}

export interface Comment {
  id: string;
  postId: string;
  userId: string;
  content: string;
  createdAt: string;
  
  // Populated
  author?: Pick<UserProfile, 'id' | 'displayName' | 'avatarUrl'>;
}
```

### Domain Models (TypeScript)
```typescript
// backend/src/domain/user/User.ts
export type Gender = 'male' | 'female' | 'other';

export interface BodyMetrics {
  heightCm: number;
  weightKg: number;
  bodyFatPct?: number;
  bmi?: number;
}

export interface UserGoals {
  objective: 'lose_weight' | 'gain_muscle' | 'maintain';
  weeklySessions: number;
  dietPreference?: 'keto' | 'mediterranean' | 'balanced' | 'vegan';
}

export interface UserProfile {
  id: string;
  email: string;
  displayName: string;
  gender?: Gender;
  birthDate?: string;
  metrics: BodyMetrics;
  goals: UserGoals;
  createdAt: string;
  updatedAt: string;
}

// backend/src/domain/workout/Workout.ts
export interface Exercise {
  id: string;
  name: string;
  muscleGroup: 'chest' | 'back' | 'legs' | 'arms' | 'shoulders' | 'core' | 'cardio';
  equipment?: string;
}

export interface WorkoutSet {
  exerciseId: string;
  reps?: number;
  weightKg?: number;
  durationSec?: number;
}

export interface WorkoutDayPlan {
  dayOfWeek: 1|2|3|4|5|6|7;
  sets: WorkoutSet[];
}

export interface WorkoutPlan {
  id: string;
  userId: string;
  name: string;
  weeks: number;
  schedule: WorkoutDayPlan[];
  createdAt: string;
  updatedAt: string;
}

// backend/src/domain/nutrition/Diet.ts
export interface FoodItem {
  id: string;
  name: string;
  calories: number;
  proteinGrams: number;
  carbsGrams: number;
  fatGrams: number;
}

export interface DietDay {
  dayOfWeek: 1|2|3|4|5|6|7;
  meals: { time: string; items: { foodId: string; grams: number }[] }[];
}

export interface DietPlan {
  id: string;
  userId: string;
  name: string;
  targetCaloriesPerDay: number;
  macroSplitPct: { protein: number; carbs: number; fat: number };
  schedule: DietDay[];
  createdAt: string;
  updatedAt: string;
}
```

### Repositories (Supabase/Postgres)
```typescript
// backend/src/infrastructure/repos/UserRepository.ts
import { createClient } from '@supabase/supabase-js';
import type { UserProfile } from '../../domain/user/User';

export class UserRepository {
  constructor(private supabase = createClient(process.env.SUPABASE_URL!, process.env.SUPABASE_KEY!)) {}

  async findById(id: string): Promise<UserProfile | null> {
    const { data, error } = await this.supabase.from('users').select('*').eq('id', id).maybeSingle();
    if (error) throw error;
    return data as unknown as UserProfile | null;
  }

  async upsert(profile: UserProfile): Promise<UserProfile> {
    const { data, error } = await this.supabase.from('users').upsert(profile).select('*').single();
    if (error) throw error;
    return data as unknown as UserProfile;
  }
}
```

### Services (Bussiness)
```typescript
// backend/src/application/UserService.ts
import type { UserProfile } from '../domain/user/User';
import { UserRepository } from '../infrastructure/repos/UserRepository';

export class UserService {
  constructor(private users = new UserRepository()) {}

  async getUserSummary(id: string) {
    const user = await this.users.findById(id);
    if (!user) throw new Error('USER_NOT_FOUND');
    const bmi = user.metrics.bmi ?? (user.metrics.weightKg / Math.pow(user.metrics.heightCm / 100, 2));
    return { id: user.id, displayName: user.displayName, objective: user.goals.objective, bmi };
  }
}

// backend/src/application/WorkoutService.ts
import type { WorkoutPlan } from '../domain/workout/Workout';
export class WorkoutService {
  async generatePlanForUser(userId: string, weeks: number): Promise<WorkoutPlan> {
    const schedule = Array.from({ length: 3 }).map((_, i) => ({ dayOfWeek: (i + 1) as 1|2|3|4|5|6|7, sets: [] }));
    return { id: crypto.randomUUID(), userId, name: 'Starter Plan', weeks, schedule, createdAt: new Date().toISOString(), updatedAt: new Date().toISOString() };
  }
}
```

### Controllers (Hono)
```typescript
// backend/src/interfaces/http/routes.ts
import { Hono } from 'hono';
import { z } from 'zod';
import { UserService } from '../../application/UserService';
import { WorkoutService } from '../../application/WorkoutService';

const api = new Hono();
const userService = new UserService();
const workoutService = new WorkoutService();

const CreateWorkoutSchema = z.object({ userId: z.string().uuid(), weeks: z.number().int().min(1).max(12) });

api.get('/auth/me', c => c.json({ user: c.get('user') }));

api.get('/users/:id/summary', async c => {
  const id = c.req.param('id');
  return c.json(await userService.getUserSummary(id));
});

api.post('/workouts', async c => {
  const body = await c.req.json();
  const input = CreateWorkoutSchema.parse(body);
  const plan = await workoutService.generatePlanForUser(input.userId, input.weeks);
  return c.json(plan, 201);
});

export default api;
```

### AI Orchestration (n8n/Dify)
```mermaid
graph TB
  REQ[Evento: crear plan] --> N8N[n8n Workflow]
  N8N --> DIFY[Prompt Dify: generar plan]
  DIFY --> N8N
  N8N --> API[PATCH /workouts/:id con plan IA]
```

---

## 3.3 Detailed Backend Structure

### Configuration (config/)

#### env.ts - Gestión de Variables de Entorno
```typescript
// config/env.ts
import { z } from 'zod';

const envSchema = z.object({
  NODE_ENV: z.enum(['development', 'production', 'test']).default('development'),
  PORT: z.string().default('3000'),
  SUPABASE_URL: z.string().url(),
  SUPABASE_ANON_KEY: z.string(),
  SUPABASE_SERVICE_KEY: z.string(),
  JWT_SECRET: z.string().min(32),
  JWT_EXPIRY: z.string().default('7d'),
  SMTP_HOST: z.string().optional(),
  SMTP_PORT: z.string().optional(),
  SMTP_USER: z.string().optional(),
  SMTP_PASS: z.string().optional(),
});

export const env = envSchema.parse(process.env);
export type Env = z.infer<typeof envSchema>;
```

### Documentation (doc/)

#### schemas.ts - API Documentation Schemas
```typescript
// doc/schemas.ts
import { z } from 'zod';

// Common response schemas
export const ApiResponseSchema = z.object({
  success: z.boolean(),
  data: z.any().optional(),
  error: z.string().optional(),
  message: z.string().optional(),
});

export const PaginationSchema = z.object({
  page: z.number().min(1).default(1),
  limit: z.number().min(1).max(100).default(20),
  total: z.number().optional(),
  totalPages: z.number().optional(),
});

// Main endpoint schemas
export const AuthSchemas = {
  register: z.object({
    email: z.string().email(),
    password: z.string().min(8),
    username: z.string().min(3).max(30),
    full_name: z.string().optional(),
  }),
  login: z.object({
    email: z.string().email(),
    password: z.string().min(8),
  }),
};

export const UserSchemas = {
  profile: z.object({
    id: z.string().uuid(),
    username: z.string(),
    full_name: z.string().nullable(),
    avatar_url: z.string().nullable(),
    bio: z.string().nullable(),
    fitness_level: z.enum(['beginner', 'intermediate', 'advanced']),
    created_at: z.string().datetime(),
  }),
  updateProfile: z.object({
    full_name: z.string().optional(),
    bio: z.string().max(500).optional(),
    fitness_level: z.enum(['beginner', 'intermediate', 'advanced']).optional(),
  }),
};
```

### Libraries (lib/)

#### db.ts - Database Client
```typescript
// lib/db.ts
import { createClient } from '@supabase/supabase-js';
import { env } from '../config/env';
import type { Database } from './types';

export const supabase = createClient<Database>(
  env.SUPABASE_URL,
  env.SUPABASE_ANON_KEY
);

export const supabaseAdmin = createClient<Database>(
  env.SUPABASE_URL,
  env.SUPABASE_SERVICE_KEY,
  {
    auth: {
      autoRefreshToken: false,
      persistSession: false
    }
  }
);

// Automatically generated database types
export type Database = {
  public: {
    Tables: {
      profiles: {
        Row: {
          id: string;
          username: string;
          full_name: string | null;
          avatar_url: string | null;
          bio: string | null;
          fitness_level: 'beginner' | 'intermediate' | 'advanced';
          created_at: string;
          updated_at: string;
        };
        Insert: Omit<Database['public']['Tables']['profiles']['Row'], 'id' | 'created_at' | 'updated_at'>;
        Update: Partial<Database['public']['Tables']['profiles']['Insert']>;
      };
      // ... other table types
    };
  };
};
```

#### mailer.ts - Email Service
```typescript
// lib/mailer.ts
import nodemailer from 'nodemailer';
import { env } from '../config/env';

const transporter = nodemailer.createTransporter({
  host: env.SMTP_HOST,
  port: parseInt(env.SMTP_PORT || '587'),
  secure: false,
  auth: {
    user: env.SMTP_USER,
    pass: env.SMTP_PASS,
  },
});

export interface EmailOptions {
  to: string;
  subject: string;
  html: string;
  text?: string;
}

export async function sendEmail(options: EmailOptions) {
  try {
    const result = await transporter.sendMail({
      from: `"GymPal" <${env.SMTP_USER}>`,
      ...options,
    });
    return { success: true, messageId: result.messageId };
  } catch (error) {
    console.error('Error sending email:', error);
    return { success: false, error: error.message };
  }
}

// Email templates
export const emailTemplates = {
  welcome: (username: string) => ({
    subject: 'Welcome to GymPal!',
    html: `
      <h1>Hello ${username}!</h1>
      <p>Welcome to GymPal, your personal fitness companion.</p>
      <p>Start your journey towards a healthier life!</p>
    `,
  }),
  workoutReminder: (workoutName: string) => ({
    subject: 'Workout Reminder',
    html: `
      <h1>It's time to train!</h1>
      <p>You have scheduled: <strong>${workoutName}</strong></p>
      <p>Don't forget to stay hydrated!</p>
    `,
  }),
};
```

### Controllers (src/handler/)

#### auth.handler.ts - Authentication Controllers
```typescript
// src/handler/auth.handler.ts
import { Context } from 'hono';
import { supabase, supabaseAdmin } from '../../lib/db';
import { sendEmail, emailTemplates } from '../../lib/mailer';
import { AuthSchemas } from '../../doc/schemas';
import { z } from 'zod';

export async function register(c: Context) {
  try {
    const body = await c.req.json();
    const validated = AuthSchemas.register.parse(body);
    
    // 1. Create user in Supabase Auth
    const { data: authData, error: authError } = await supabase.auth.signUp({
      email: validated.email,
      password: validated.password,
    });
    
    if (authError) {
      return c.json({ 
        success: false, 
        error: authError.message 
      }, 400);
    }
    
    // 2. Create profile in the database
    const { data: profile, error: profileError } = await supabaseAdmin
      .from('profiles')
      .insert({
        id: authData.user!.id,
        username: validated.username,
        full_name: validated.full_name,
        fitness_level: 'beginner',
      })
      .select()
      .single();
    
    if (profileError) {
      return c.json({ 
        success: false, 
        error: profileError.message 
      }, 400);
    }
    
    // 3. Send welcome email
    await sendEmail({
      to: validated.email,
      ...emailTemplates.welcome(validated.username),
    });
    
    return c.json({ 
      success: true, 
      data: { user: authData.user, profile } 
    }, 201);
    
  } catch (error) {
    if (error instanceof z.ZodError) {
      return c.json({ 
        success: false, 
        error: 'Invalid input data',
        details: error.errors 
      }, 400);
    }
    
    return c.json({ 
      success: false, 
      error: 'Internal server error' 
    }, 500);
  }
}

export async function login(c: Context) {
  try {
    const body = await c.req.json();
    const validated = AuthSchemas.login.parse(body);
    
    const { data, error } = await supabase.auth.signInWithPassword({
      email: validated.email,
      password: validated.password,
    });
    
    if (error) {
      return c.json({ 
        success: false, 
        error: 'Invalid credentials' 
      }, 401);
    }
    
    return c.json({ 
      success: true, 
      data: { user: data.user, session: data.session } 
    });
    
  } catch (error) {
    return c.json({ 
      success: false, 
      error: 'Internal server error' 
    }, 500);
  }
}

export async function getProfile(c: Context) {
  try {
    const userId = c.get('userId');
    
    const { data: profile, error } = await supabase
      .from('profiles')
      .select('*')
      .eq('id', userId)
      .single();
    
    if (error) {
      return c.json({ 
        success: false, 
        error: 'Profile not found' 
      }, 404);
    }
    
    return c.json({ 
      success: true, 
      data: profile 
    });
    
  } catch (error) {
    return c.json({ 
      success: false, 
      error: 'Internal server error' 
    }, 500);
  }
}
```

#### user.handler.ts - User Controllers
```typescript
// src/handler/user.handler.ts
import { Context } from 'hono';
import { supabase } from '../../lib/db';
import { UserSchemas } from '../../doc/schemas';

export async function getUserProfile(c: Context) {
  try {
    const userId = c.req.param('id');
    
    const { data: profile, error } = await supabase
      .from('profiles')
      .select('id, username, full_name, avatar_url, bio, fitness_level, created_at')
      .eq('id', userId)
      .single();
    
    if (error) {
      return c.json({ 
        success: false, 
        error: 'User not found' 
      }, 404);
    }
    
    return c.json({ 
      success: true, 
      data: profile 
    });
    
  } catch (error) {
    return c.json({ 
      success: false, 
      error: 'Internal server error' 
    }, 500);
  }
}

export async function updateProfile(c: Context) {
  try {
    const userId = c.get('userId');
    const body = await c.req.json();
    const validated = UserSchemas.updateProfile.parse(body);
    
    const { data: profile, error } = await supabase
      .from('profiles')
      .update(validated)
      .eq('id', userId)
      .select()
      .single();
    
    if (error) {
      return c.json({ 
        success: false, 
        error: error.message 
      }, 400);
    }
    
    return c.json({ 
      success: true, 
      data: profile 
    });
    
  } catch (error) {
    return c.json({ 
      success: false, 
      error: 'Internal server error' 
    }, 500);
  }
}
```

### Routes (src/routes/)

#### auth.routes.ts - Authentication Routes
```typescript
// src/routes/auth.routes.ts
import { Hono } from 'hono';
import { register, login, getProfile } from '../handler/auth.handler';
import { authMiddleware } from '../middleware/auth';

const authRoutes = new Hono();

// Public routes
authRoutes.post('/register', register);
authRoutes.post('/login', login);

// Protected routes
authRoutes.get('/me', authMiddleware, getProfile);

export { authRoutes };
```

#### user.routes.ts - User Routes
```typescript
// src/routes/user.routes.ts
import { Hono } from 'hono';
import { getUserProfile, updateProfile } from '../handler/user.handler';
import { authMiddleware } from '../middleware/auth';

const userRoutes = new Hono();

// Public routes
userRoutes.get('/:id', getUserProfile);

// Protected routes
userRoutes.put('/:id', authMiddleware, updateProfile);

export { userRoutes };
```
---

### AI and Recommendations

```typescript
POST /api/v1/ai/chat
Body: {
  message: string;
  sessionId?: string;
  context?: {
    workoutId?: string;
    userId?: string;
  }
}
Response: {
  data: {
    message: string;
    sessionId: string;
    suggestions?: string[];
  }
}

GET /api/v1/ai/recommendations
Query: {
  type: 'workouts' | 'users' | 'posts';
  limit?: number;
}
Response: {
  data: (WorkoutPlan | UserProfile | Post)[]
}

POST /api/v1/ai/generate-workout
Body: {
  userId: string;
  preferences: {
    duration: number; // weeks
    daysPerWeek: number;
    difficulty: string;
    equipment?: string[];
  }
}
Response: { data: WorkoutPlan }
```

---

## 4.1 Frontend API Client
```typescript
// frontend/src/shared/api/client.ts
export class ApiClient {
  constructor(private baseUrl = '/api', private getToken?: () => string | undefined) {}

  private headers() {
    const h: Record<string, string> = { 'Content-Type': 'application/json' };
    const t = this.getToken?.();
    if (t) h.Authorization = `Bearer ${t}`;
    return h;
  }

  async get<T>(path: string): Promise<T> {
    const res = await fetch(`${this.baseUrl}${path}`, { headers: this.headers() });
    if (!res.ok) throw new Error(await res.text());
    return res.json();
  }

  async post<T>(path: string, body: unknown): Promise<T> {
    const res = await fetch(`${this.baseUrl}${path}`, { method: 'POST', headers: this.headers(), body: JSON.stringify(body) });
    if (!res.ok) throw new Error(await res.text());
    return res.json();
  }
}
```

---

## 4.3 Testing Strategy

### Testing Pyramid

```mermaid
graph TB
  subgraph "Testing Pyramid"
    E2E[E2E Tests<br/>Cypress/Playwright<br/>5%]
    INTEGRATION[Integration Tests<br/>API + DB<br/>25%]
    UNIT[Unit Tests<br/>Jest/Vitest<br/>70%]
  end
  
  subgraph "Frontend Testing"
    COMPONENT[Component Tests<br/>React Testing Library]
    HOOK[Hook Tests<br/>Custom Hooks]
    UTIL[Utility Tests<br/>Pure Functions]
  end
  
  subgraph "Backend Testing"
    SERVICE[Service Tests<br/>Business Logic]
    REPO[Repository Tests<br/>Data Layer]
    ROUTE[Route Tests<br/>API Endpoints]
  end
  
  E2E --> INTEGRATION
  INTEGRATION --> UNIT
  UNIT --> COMPONENT
  UNIT --> HOOK
  UNIT --> UTIL
  UNIT --> SERVICE
  UNIT --> REPO
  UNIT --> ROUTE
```

### Layered Testing Strategy

```mermaid
graph TB
  subgraph "Frontend Testing Strategy"
    UNIT_FE[Unit Tests<br/>Components, Hooks, Utils]
    INTEGRATION_FE[Integration Tests<br/>API Client, State Management]
    E2E_FE[E2E Tests<br/>User Journeys]
  end
  
  subgraph "Backend Testing Strategy"
    UNIT_BE[Unit Tests<br/>Services, Repositories, Utils]
    INTEGRATION_BE[Integration Tests<br/>API + Database]
    CONTRACT[Contract Tests<br/>API Contracts]
  end
  
  subgraph "Testing Tools"
    JEST[Jest - Unit Testing]
    RTL[React Testing Library]
    CYPRESS[Cypress - E2E]
    SUPABASE[Supabase Test Client]
    MOCK[Mock Service Worker]
  end
  
  UNIT_FE --> JEST
  UNIT_FE --> RTL
  INTEGRATION_FE --> MOCK
  E2E_FE --> CYPRESS
  
  UNIT_BE --> JEST
  INTEGRATION_BE --> SUPABASE
  CONTRACT --> JEST
```

### Testing Flow in CI/CD

```mermaid
sequenceDiagram
  participant DEV as Developer
  participant GIT as Git
  participant CI as GitHub Actions
  participant TEST as Test Suite
  participant BUILD as Build
  participant DEPLOY as Deploy
  
  DEV->>GIT: Push code
  GIT->>CI: Trigger workflow
  
  CI->>TEST: Run Unit Tests
  TEST-->>CI: ✅ Pass
  
  CI->>TEST: Run Integration Tests
  TEST-->>CI: ✅ Pass
  
  CI->>TEST: Run E2E Tests
  TEST-->>CI: ✅ Pass
  
  CI->>BUILD: Build Docker Images
  BUILD-->>CI: ✅ Success
  
  CI->>DEPLOY: Deploy to Environment
  DEPLOY-->>CI: ✅ Deployed
```

### Testing Coverage

```mermaid
graph TB
  subgraph "Target Coverage"
    UNIT_COV[Unit Tests: 80%+]
    INTEGRATION_COV[Integration: 60%+]
    E2E_COV[E2E: Critical Paths]
  end
  
  subgraph "Quality Metrics"
    COVERAGE[Code Coverage]
    MUTATION[Mutation Testing]
    PERFORMANCE[Performance Tests]
    SECURITY[Security Tests]
  end
  
  subgraph "Measurement Tools"
    JEST_COV[Jest Coverage]
    STRYKER[Stryker Mutator]
    LIGHTHOUSE[Lighthouse CI]
    SNYK[Snyk Security]
  end
  
  UNIT_COV --> COVERAGE
  INTEGRATION_COV --> COVERAGE
  E2E_COV --> COVERAGE
  
  COVERAGE --> JEST_COV
  MUTATION --> STRYKER
  PERFORMANCE --> LIGHTHOUSE
  SECURITY --> SNYK
```

### Test Examples

```typescript
// frontend/src/components/__tests__/chat-interface.test.tsx
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import { ChatInterface } from '../ai/chat-interface';
import { apiClient } from '@/lib/api/client';

jest.mock('@/lib/api/client');
const mockApiClient = apiClient as jest.Mocked<typeof apiClient>;

describe('ChatInterface', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('should send message and display response', async () => {
    mockApiClient.post.mockResolvedValue({
      message: 'Test response',
      sessionId: 'test-session'
    });

    render(<ChatInterface />);
    
    const input = screen.getByPlaceholderText('Type your message...');
    const sendButton = screen.getByText('Send');
    
    fireEvent.change(input, { target: { value: 'Test message' } });
    fireEvent.click(sendButton);
    
    await waitFor(() => {
      expect(screen.getByText('Test message')).toBeInTheDocument();
      expect(screen.getByText('Test response')).toBeInTheDocument();
    });
    
    expect(mockApiClient.post).toHaveBeenCalledWith('/ai/chat', {
      message: 'Test message',
      sessionId: undefined
    });
  });
});
```

```typescript
// backend/src/modules/workouts/__tests__/workouts.service.test.ts
import { WorkoutService } from '../workouts.service';
import { WorkoutRepository } from '../workouts.repository';

jest.mock('../workouts.repository');
const mockRepository = WorkoutRepository as jest.MockedClass<typeof WorkoutRepository>;

describe('WorkoutService', () => {
  let service: WorkoutService;
  let mockRepo: jest.Mocked<WorkoutRepository>;

  beforeEach(() => {
    mockRepo = new mockRepository() as jest.Mocked<WorkoutRepository>;
    service = new WorkoutService();
    (service as any).repo = mockRepo;
  });

  describe('createWorkout', () => {
    it('should create workout with correct progress calculation', async () => {
      const workoutData = {
        name: 'Test Workout',
        difficulty: 'beginner' as const,
        plan: {
          weeks: 4,
          daysPerWeek: 3,
          sessions: []
        },
        isPublic: false
      };

      const expectedWorkout = {
        ...workoutData,
        userId: 'user-123',
        progress: {
          completedSessions: 0,
          totalSessions: 12 // 4 weeks * 3 days
        }
      };

      mockRepo.create.mockResolvedValue(expectedWorkout as any);

      const result = await service.createWorkout('user-123', workoutData);

      expect(mockRepo.create).toHaveBeenCalledWith(expectedWorkout);
      expect(result).toEqual(expectedWorkout);
    });
  });
});
```

---

## 5. AI Integration (Detailed)

### Dify Client

```typescript
// backend/src/modules/ai/dify.client.ts
export class DifyClient {
  private apiKey: string;
  private baseUrl = 'https://api.dify.ai/v1';

  constructor(apiKey: string) {
    this.apiKey = apiKey;
  }

  async chat(params: {
    query: string;
    user: string;
    conversationId?: string;
    inputs?: Record<string, any>;
  }) {
    const response = await fetch(`${this.baseUrl}/chat-messages`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${this.apiKey}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        query: params.query,
        user: params.user,
        conversation_id: params.conversationId,
        inputs: params.inputs || {},
        response_mode: 'blocking'
      })
    });

    if (!response.ok) {
      throw new Error(`Dify API error: ${response.status}`);
    }

    return response.json();
  }

  async completion(params: {
    prompt: string;
    user: string;
    inputs?: Record<string, any>;
  }) {
    const response = await fetch(`${this.baseUrl}/completion-messages`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${this.apiKey}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        inputs: { prompt: params.prompt, ...params.inputs },
        user: params.user,
        response_mode: 'blocking'
      })
    });

    if (!response.ok) {
      throw new Error(`Dify API error: ${response.status}`);
    }

    return response.json();
  }
}
```

### Context Builder

```typescript
// backend/src/modules/ai/context.builder.ts
import { createClient } from '@supabase/supabase-js';

export class ContextBuilder {
  private supabase;

  constructor() {
    this.supabase = createClient(
      process.env.SUPABASE_URL!,
      process.env.SUPABASE_SERVICE_KEY!
    );
  }

  async buildForUser(userId: string) {
    // Get user profile
    const { data: profile } = await this.supabase
      .from('users')
      .select('*')
      .eq('id', userId)
      .single();

    // Get recent workouts (last 5)
    const { data: recentWorkouts } = await this.supabase
      .from('workout_logs')
      .select('*')
      .eq('user_id', userId)
      .order('log_date', { ascending: false })
      .limit(5);

    // Get active workout plan
    const { data: activeWorkout } = await this.supabase
      .from('workouts')
      .select('*')
      .eq('user_id', userId)
      .order('created_at', { ascending: false })
      .limit(1)
      .single();

    return {
      profile: profile || {},
      recentWorkouts: recentWorkouts || [],
      activeWorkout: activeWorkout || null,
      goals: profile?.goals || {}
    };
  }
}
```

### Frontend Chat Component

```typescript
// frontend/src/components/ai/chat-interface.tsx
'use client';

import { useState, useRef, useEffect } from 'react';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { ScrollArea } from '@/components/ui/scroll-area';
import { apiClient } from '@/lib/api/client';

interface Message {
  role: 'user' | 'assistant';
  content: string;
  timestamp: Date;
}

export function ChatInterface() {
  const [messages, setMessages] = useState<Message[]>([]);
  const [input, setInput] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [sessionId, setSessionId] = useState<string>();
  const scrollRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    scrollRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [messages]);

  const sendMessage = async () => {
    if (!input.trim()) return;

    const userMessage: Message = {
      role: 'user',
      content: input,
      timestamp: new Date()
    };

    setMessages(prev => [...prev, userMessage]);
    setInput('');
    setIsLoading(true);

    try {
      const response = await apiClient.post<{
        message: string;
        sessionId: string;
        suggestions?: string[];
      }>('/ai/chat', {
        message: input,
        sessionId
      });

      setSessionId(response.sessionId);

      const assistantMessage: Message = {
        role: 'assistant',
        content: response.message,
        timestamp: new Date()
      };

      setMessages(prev => [...prev, assistantMessage]);
    } catch (error) {
      console.error('Chat error:', error);
      setMessages(prev => [...prev, {
        role: 'assistant',
        content: 'Sorry, an error occurred. Please try again.',
        timestamp: new Date()
      }]);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="flex flex-col h-[600px] border rounded-lg">
      <div className="p-4 border-b">
        <h2 className="text-xl font-semibold">AI Fitness Assistant</h2>
        <p className="text-sm text-muted-foreground">
          Ask about exercises, nutrition, or your progress
        </p>
      </div>

      <ScrollArea className="flex-1 p-4">
        <div className="space-y-4">
          {messages.map((msg, idx) => (
            <div
              key={idx}
              className={`flex ${msg.role === 'user' ? 'justify-end' : 'justify-start'}`}
            >
              <div
                className={`max-w-[80%] rounded-lg p-3 ${
                  msg.role === 'user'
                    ? 'bg-primary text-primary-foreground'
                    : 'bg-muted'
                }`}
              >
                <p className="text-sm">{msg.content}</p>
                <span className="text-xs opacity-70">
                  {msg.timestamp.toLocaleTimeString()}
                </span>
              </div>
            </div>
          ))}
          {isLoading && (
            <div className="flex justify-start">
              <div className="bg-muted rounded-lg p-3">
                <div className="flex space-x-2">
                  <div className="w-2 h-2 bg-gray-500 rounded-full animate-bounce" />
                  <div className="w-2 h-2 bg-gray-500 rounded-full animate-bounce delay-100" />
                  <div className="w-2 h-2 bg-gray-500 rounded-full animate-bounce delay-200" />
                </div>
              </div>
            </div>
          )}
          <div ref={scrollRef} />
        </div>
      </ScrollArea>

      <div className="p-4 border-t">
        <form
          onSubmit={(e) => {
            e.preventDefault();
            sendMessage();
          }}
          className="flex gap-2"
        >
          <Input
            value={input}
            onChange={(e) => setInput(e.target.value)}
            placeholder="Type your message..."
            disabled={isLoading}
          />
          <Button type="submit" disabled={isLoading || !input.trim()}>
            Send
          </Button>
        </form>
      </div>
    </div>
  );
}
```

---

## 6. Security and Compliance 🔐

### Security Principles

- **Defense in Depth**: Multiple security layers
- **Least Privilege**: Minimum necessary permissions
- **Secure by Default**: Secure configuration by default
- **Zero Trust**: Always verify, never trust

### Authentication and Authorization

```mermaid
sequenceDiagram
    participant U as User
    participant FE as Frontend
    participant API as API Gateway
    participant AUTH as Auth Service
    participant DB as Database

    U->>FE: Login (email, password)
    FE->>API: POST /auth/login
    API->>AUTH: Validate credentials
    AUTH->>DB: Check user + hash
    DB-->>AUTH: User data
    AUTH->>AUTH: Generate JWT (15min) + Refresh (7d)
    AUTH-->>API: Tokens
    API-->>FE: Set httpOnly cookie + return tokens

    Note over FE,API: Subsequent requests
    FE->>API: Request + Bearer token
    API->>API: Verify JWT signature
    API->>API: Check expiration
    API->>API: Extract userId + permissions
    API->>API: Rate limit check
    API-->>FE: Response or 401
```

### Auth Middleware Implementation

```typescript
// backend/src/shared/middleware/auth.ts
import { Context, Next } from 'hono';
import { verify } from 'hono/jwt';
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  process.env.SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_KEY!
);

export async function authMiddleware(c: Context, next: Next) {
  const authHeader = c.req.header('Authorization');

  if (!authHeader?.startsWith('Bearer ')) {
    return c.json(
      { error: { code: 'UNAUTHORIZED', message: 'Missing or invalid token' } },
      401
    );
  }

  const token = authHeader.substring(7);

  try {
    // Verify JWT using Supabase
    const { data: { user }, error } = await supabase.auth.getUser(token);

    if (error || !user) {
      return c.json(
        { error: { code: 'UNAUTHORIZED', message: 'Invalid token' } },
        401
      );
    }

    // Set user context
    c.set('userId', user.id);
    c.set('userEmail', user.email);

    await next();
  } catch (error) {
    return c.json(
      { error: { code: 'UNAUTHORIZED', message: 'Token verification failed' } },
      401
    );
  }
}

// Optional: Role-based authorization
export function requireRole(role: string) {
  return async (c: Context, next: Next) => {
    const userId = c.get('userId');

    const { data: user } = await supabase
      .from('users')
      .select('profile->role')
      .eq('id', userId)
      .single();

    if (user?.profile?.role !== role) {
      return c.json(
        { error: { code: 'FORBIDDEN', message: 'Insufficient permissions' } },
        403
      );
    }

    await next();
  };
}
```

### Rate Limiting

```typescript
// backend/src/shared/middleware/rate-limit.ts
import { Context, Next } from 'hono';
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  process.env.SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_KEY!
);

interface RateLimitConfig {
  windowMs: number;
  maxRequests: number;
}

const defaultConfig: RateLimitConfig = {
  windowMs: 15 * 60 * 1000, // 15 minutes
  maxRequests: 100
};

export function rateLimitMiddleware(config: RateLimitConfig = defaultConfig) {
  return async (c: Context, next: Next) => {
    const userId = c.get('userId') || c.req.header('X-Real-IP') || 'anonymous';
    const key = `ratelimit:${userId}`;

    // Simple in-memory rate limiting (use Redis in production)
    const now = Date.now();
    const windowStart = now - config.windowMs;

    // Check rate limit in database (simplified - use Redis for better performance)
    const { data: requests } = await supabase
      .from('rate_limits')
      .select('count')
      .eq('user_id', userId)
      .gte('timestamp', new Date(windowStart).toISOString())
      .single();

    const currentCount = requests?.count || 0;

    if (currentCount >= config.maxRequests) {
      return c.json(
        {
          error: {
            code: 'RATE_LIMIT_EXCEEDED',
            message: 'Too many requests. Please try again later.'
          }
        },
        429
      );
    }

    // Increment counter
    await supabase.from('rate_limits').insert({
      user_id: userId,
      timestamp: new Date().toISOString()
    });

    await next();
  };
}
```

### Input Validation

```typescript
// backend/src/shared/middleware/validation.ts
import { Context, Next } from 'hono';
import { z, ZodSchema } from 'zod';

export function validateBody<T extends ZodSchema>(schema: T) {
  return async (c: Context, next: Next) => {
    try {
      const body = await c.req.json();
      const validated = schema.parse(body);
      c.set('validatedBody', validated);
      await next();
    } catch (error) {
      if (error instanceof z.ZodError) {
        return c.json(
          {
            error: {
              code: 'VALIDATION_ERROR',
              message: 'Invalid request body',
              details: error.errors
            }
          },
          400
        );
      }
      throw error;
    }
  };
}

export function validateQuery<T extends ZodSchema>(schema: T) {
  return async (c: Context, next: Next) => {
    try {
      const query = c.req.query();
      const validated = schema.parse(query);
      c.set('validatedQuery', validated);
      await next();
    } catch (error) {
      if (error instanceof z.ZodError) {
        return c.json(
          {
            error: {
              code: 'VALIDATION_ERROR',
              message: 'Invalid query parameters',
              details: error.errors
            }
          },
          400
        );
      }
      throw error;
    }
  };
}
```

### Security Headers

```typescript
// backend/src/shared/middleware/security-headers.ts
import { Context, Next } from 'hono';

export async function securityHeadersMiddleware(c: Context, next: Next) {
  await next();

  // Content Security Policy
  c.header(
    'Content-Security-Policy',
    "default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'; img-src 'self' data: https:; font-src 'self' data:;"
  );

  // Prevent XSS
  c.header('X-Content-Type-Options', 'nosniff');
  c.header('X-Frame-Options', 'DENY');
  c.header('X-XSS-Protection', '1; mode=block');

  // HTTPS
  c.header('Strict-Transport-Security', 'max-age=31536000; includeSubDomains');

  // Referrer
  c.header('Referrer-Policy', 'strict-origin-when-cross-origin');

  // Permissions
  c.header('Permissions-Policy', 'geolocation=(), microphone=(), camera=()');
}
```

### CORS Configuration

```typescript
// backend/src/app.ts
import { Hono } from 'hono';
import { cors } from 'hono/cors';

const app = new Hono();

app.use('*', cors({
  origin: process.env.FRONTEND_URL || 'http://localhost:3000',
  credentials: true,
  allowMethods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS'],
  allowHeaders: ['Content-Type', 'Authorization'],
  exposeHeaders: ['X-Total-Count'],
  maxAge: 86400
}));
```

### Additional Security Measures

- **OAuth2/OIDC + JWT** with token rotation (Supabase/Auth.js). Web user sessions.
- **HTTPS** with TLS managed by Ingress + Cert-Manager. TLS secrets in K8s.
- **NetworkPolicies** to isolate pods by namespace/role.
- **RBAC** in Kubernetes and minimum DB privileges.
- **Rate limiting** and **WAF** at the gateway level (NGINX/Cloud provider).
- **CSP, CSRF**, input sanitization and schema validation (Zod/Valibot).
- **Auditing and Traceability**: structured logs, request correlation.
- **GDPR**: consent, data deletion, export (academic scope).

---

## 7. DevOps, CI/CD and GitOps 🚀

- Repositories: `frontend/`, `backend/`, `infra/`.
- CI with GitHub Actions: lint, test, build, docker build/push.
- CD with **ArgoCD** synchronizing Helm/Kustomize manifests per environment.
- Semantic versioning and environments: dev/staging/prod.
- n8n jobs versioned (export JSON) and deployed as resource.

### Infrastructure Architecture

```mermaid
graph TB
    subgraph "GitHub"
        CODE[Source Code]
        ACTIONS[GitHub Actions]
    end

    subgraph "CI Pipeline"
        BUILD[Build & Test]
        DOCKER[Docker Build]
        PUSH[Push to Registry]
    end

    subgraph "Container Registry"
        GHCR[GitHub Container Registry]
    end

    subgraph "Kubernetes Cluster"
        ARGO[ArgoCD]

        subgraph "Namespaces"
            DEV[dev]
            STAGING[staging]
            PROD[production]
        end

        subgraph "Monitoring"
            PROM[Prometheus]
            GRAF[Grafana]
            LOKI[Loki]
        end
    end

    CODE --> ACTIONS
    ACTIONS --> BUILD
    BUILD --> DOCKER
    DOCKER --> PUSH
    PUSH --> GHCR
    GHCR --> ARGO
    ARGO --> DEV
    ARGO --> STAGING
    ARGO --> PROD

    DEV --> PROM
    STAGING --> PROM
    PROD --> PROM
    PROM --> GRAF
    LOKI --> GRAF
```

### CI/CD Pipeline

```yaml
# .github/workflows/ci.yml
name: CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

jobs:
  test-frontend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: pnpm/action-setup@v2
        with:
          version: 8

      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'pnpm'

      - name: Install dependencies
        run: pnpm install --frozen-lockfile

      - name: Lint
        run: pnpm run lint
        working-directory: ./frontend

      - name: Type check
        run: pnpm run type-check
        working-directory: ./frontend

      - name: Unit tests
        run: pnpm run test
        working-directory: ./frontend

  test-backend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: pnpm/action-setup@v2
        with:
          version: 8

      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'pnpm'

      - name: Install dependencies
        run: pnpm install --frozen-lockfile

      - name: Lint
        run: pnpm run lint
        working-directory: ./backend

      - name: Type check
        run: pnpm run type-check
        working-directory: ./backend

      - name: Unit tests
        run: pnpm run test
        working-directory: ./backend

      - name: Integration tests
        run: pnpm run test:integration
        working-directory: ./backend
        env:
          SUPABASE_URL: ${{ secrets.TEST_SUPABASE_URL }}
          SUPABASE_KEY: ${{ secrets.TEST_SUPABASE_KEY }}

  build:
    needs: [test-frontend, test-backend]
    if: github.event_name == 'push'
    runs-on: ubuntu-latest
    strategy:
      matrix:
        service: [frontend, backend]
    steps:
      - uses: actions/checkout@v4

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Log in to GitHub Container Registry
        uses: docker/login-action@v3
        with:
          registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Extract metadata
        id: meta
        uses: docker/metadata-action@v5
        with:
          images: ghcr.io/${{ github.repository }}/${{ matrix.service }}
          tags: |
            type=ref,event=branch
            type=sha,prefix={{branch}}-

      - name: Build and push
        uses: docker/build-push-action@v5
        with:
          context: ./${{ matrix.service }}
          push: true
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
          cache-from: type=gha
          cache-to: type=gha,mode=max
```

### CD Pipeline

```yaml
# .github/workflows/cd-dev.yml
name: CD - Development

on:
  push:
    branches: [develop]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Update image tags in kustomization
        run: |
          cd infra/kubernetes/overlays/dev
          kustomize edit set image \
            frontend=ghcr.io/${{ github.repository }}/frontend:develop-${{ github.sha }} \
            backend=ghcr.io/${{ github.repository }}/backend:develop-${{ github.sha }}

      - name: Commit and push
        run: |
          git config user.name github-actions
          git config user.email github-actions@github.com
          git add infra/kubernetes/overlays/dev/kustomization.yaml
          git commit -m "Update dev images to ${{ github.sha }}"
          git push

      # ArgoCD will automatically sync changes
```

### Kubernetes Manifests

```yaml
# infra/kubernetes/base/backend/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: backend
  labels:
    app: backend
spec:
  replicas: 2
  selector:
    matchLabels:
      app: backend
  template:
    metadata:
      labels:
        app: backend
    spec:
      containers:
      - name: backend
        image: backend:latest
        ports:
        - containerPort: 3001
        env:
        - name: NODE_ENV
          value: production
        - name: PORT
          value: "3001"
        envFrom:
        - configMapRef:
            name: backend-config
        - secretRef:
            name: backend-secrets
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
        livenessProbe:
          httpGet:
            path: /health
            port: 3001
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /health/ready
            port: 3001
          initialDelaySeconds: 5
          periodSeconds: 5
```

```yaml
# infra/kubernetes/base/backend/service.yaml
apiVersion: v1
kind: Service
metadata:
  name: backend
  labels:
    app: backend
spec:
  type: ClusterIP
  ports:
  - port: 80
    targetPort: 3001
    protocol: TCP
    name: http
  selector:
    app: backend
```

```yaml
# infra/kubernetes/base/ingress/ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: gympal-ingress
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/rate-limit: "100"
spec:
  ingressClassName: nginx
  tls:
  - hosts:
    - api.gympal.com
    - app.gympal.com
    secretName: gympal-tls
  rules:
  - host: api.gympal.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: backend
            port:
              number: 80
  - host: app.gympal.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: frontend
            port:
              number: 80
```

### Kustomization

```yaml
# infra/kubernetes/overlays/dev/kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

namespace: gympal-dev

bases:
  - ../../base/backend
  - ../../base/frontend
  - ../../base/ingress

images:
  - name: backend
    newName: ghcr.io/your-org/gympal/backend
    newTag: develop-latest
  - name: frontend
    newName: ghcr.io/your-org/gympal/frontend
    newTag: develop-latest

replicas:
  - name: backend
    count: 1
  - name: frontend
    count: 1

configMapGenerator:
  - name: backend-config
    literals:
      - API_URL=https://api-dev.gympal.com
      - FRONTEND_URL=https://app-dev.gympal.com

secretGenerator:
  - name: backend-secrets
    envs:
      - secrets.env
```

### Docker Compose (Local Development)

```yaml
# docker-compose.yml
version: '3.8'

services:
  frontend:
    build:
      context: ./frontend
      dockerfile: Dockerfile.dev
    ports:
      - "3000:3000"
    volumes:
      - ./frontend:/app
      - /app/node_modules
    environment:
      - NEXT_PUBLIC_API_URL=http://localhost:3001
    depends_on:
      - backend

  backend:
    build:
      context: ./backend
      dockerfile: Dockerfile.dev
    ports:
      - "3001:3001"
    volumes:
      - ./backend:/app
      - /app/node_modules
    environment:
      - NODE_ENV=development
      - PORT=3001
      - SUPABASE_URL=${SUPABASE_URL}
      - SUPABASE_KEY=${SUPABASE_KEY}
      - DIFY_API_KEY=${DIFY_API_KEY}
    env_file:
      - .env

  prometheus:
    image: prom/prometheus:latest
    ports:
      - "9090:9090"
    volumes:
      - ./infra/monitoring/prometheus:/etc/prometheus
      - prometheus-data:/prometheus
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'

  grafana:
    image: grafana/grafana:latest
    ports:
      - "3002:3000"
    volumes:
      - ./infra/monitoring/grafana:/etc/grafana/provisioning
      - grafana-data:/var/lib/grafana
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin
      - GF_USERS_ALLOW_SIGN_UP=false
    depends_on:
      - prometheus

volumes:
  prometheus-data:
  grafana-data:
```

### Monitoring

```yaml
# infra/monitoring/prometheus/prometheus.yml
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'kubernetes-apiservers'
    kubernetes_sd_configs:
    - role: endpoints
    scheme: https
    tls_config:
      ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
    bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
    relabel_configs:
    - source_labels: [__meta_kubernetes_namespace, __meta_kubernetes_service_name, __meta_kubernetes_endpoint_port_name]
      action: keep
      regex: default;kubernetes;https

  - job_name: 'backend'
    kubernetes_sd_configs:
    - role: pod
    relabel_configs:
    - source_labels: [__meta_kubernetes_pod_label_app]
      action: keep
      regex: backend
    - source_labels: [__meta_kubernetes_pod_ip]
      target_label: __address__
      replacement: ${1}:3001

  - job_name: 'frontend'
    kubernetes_sd_configs:
    - role: pod
    relabel_configs:
    - source_labels: [__meta_kubernetes_pod_label_app]
      action: keep
      regex: frontend
```

---

## 8. Monitoring and Observability 📈

- **Prometheus**: app, K8s and DB metrics.
- **Grafana**: business and system dashboards.
- **Promtail**: log collection (to Loki or equivalent system).
- SLI alerts: API latency, 5xx errors, n8n queues, K8s resources.

Dashboards:
- Active users, retention, post and comment creation.
- AI generations/day, success rate, Dify latency.
- Plan compliance: workouts/diets completed per week.

---

## 9. Work Plan and Team Organization 👥

### Roles
- **Frontend**: Next.js, UI/UX, accessibility, state and SSR.
- **Backend**: Hono APIs, models, validation, performance.
- **DevOps/SRE**: K8s, ArgoCD, observability, cluster security.
- **AI/Integrations**: Dify, prompts, recommendations, evaluation; n8n chatbots.
- **Product/QA**: documentation, backlog, E2E tests, UX research.

### Roadmap (October - December 2025)

#### Phase 1: Initial Setup (7 Oct - 3 Nov)
- **Week 1 (7-13 Oct)**: Requirements analysis, domain design, architecture
- **Week 2 (14-20 Oct)**: Next.js + TypeScript + Tailwind CSS setup
- **Week 3 (21-27 Oct)**: Hono backend + Supabase setup
- **Week 4 (28 Oct - 3 Nov)**: Complete frontend-backend integration

#### Phase 2: Backend Core (4 Nov - 24 Nov)
- **Week 5 (4-10 Nov)**: REST APIs for users, authentication
- **Week 6 (11-17 Nov)**: Workout/Nutrition modules (CRUD)
- **Week 7 (18-24 Nov)**: Basic social, OpenAPI, progress presentation (24 Oct)
- **Milestone**: Progress presentation on October 24

#### Phase 3: AI Integration (25 Nov - 8 Dec)
- **Week 8 (25 Nov - 1 Dec)**: Web chatbot + Dify AI, Demo 1 (25 Nov)
- **Week 9 (2-8 Dec)**: n8n workflows, recommendations, Demo 2 (28 Nov)
- **Milestones**: Project demos on November 25 and 28

#### Phase 4: DevOps & Scale (9 Dec - 19 Dec)
- **Week 10 (9-12 Dec)**: Kubernetes + ArgoCD, final delivery (9 Dec)
- **Week 11 (13-16 Dec)**: Observability, security hardening
- **Week 12 (17-19 Dec)**: UX polish, E2E tests, final documentation
- **Milestones**:
  - December 9: Final project delivery + draft report + final presentation
  - December 19: Project README + final report version

### Delivery Schedule
- **October 24**: Progress presentation
- **November 25**: Project demo (part 1)
- **November 28**: Project demo (part 2)
- **December 9**: Final delivery + draft report + final presentation
- **December 19**: README + final report

---

## 10. Methodology, Standards and Quality 🧭

- **Light SCRUM**: 2-week sprints, brief dailies, review/retro.
- **Conventions**: Strict TypeScript, ESLint/Prettier, conventional commits.
- **Testing**: unit (Vitest/Jest), integration (Supertest), E2E (Playwright/Cypress).
- **Docs**: OpenAPI, ADRs, diagrams (Mermaid), service READMEs.

---

## 11. Communication Flows and Orchestration 🔄

### Diagram: Registration and Authentication Flow
```mermaid
sequenceDiagram
  participant U as User
  participant FE as Frontend
  participant API as API Gateway
  participant AUTH as Auth Service
  U->>FE: Complete registration form
  FE->>API: POST /auth/register
  API->>AUTH: Validate and create user
  AUTH-->>API: User created + tokens
  API-->>FE: 201 Created + JWT
  FE->>API: POST /auth/login
  API->>AUTH: Validate credentials
  AUTH-->>API: JWT
  API-->>FE: 200 OK + tokens
```

### Diagram: Workout Routine Generation and Tracking
```mermaid
sequenceDiagram
  participant U as User
  participant FE as Frontend
  participant API as API Gateway
  participant WO as Workout Service
  participant D as Dify AI
  U->>FE: Request new routine
  FE->>API: POST /workouts (goals)
  API->>WO: Create routine
  WO->>D: AI suggestion
  D-->>WO: Routine generated
  WO-->>API: Routine saved
  API-->>FE: 201 Created (planId)
  FE->>API: POST /workouts/:id/logs
  API->>WO: Register progress
  WO-->>API: OK
  API-->>FE: Updated metrics
```

### Diagram: Social Interaction (follow, notify, feed)
```mermaid
sequenceDiagram
  participant U as User
  participant FE as Frontend
  participant API as API Gateway
  participant SO as Social Service
  participant NOTIF as Notification Service
  U->>FE: Follow another user
  FE->>API: POST /users/:id/follow
  API->>SO: Register follow
  SO-->>API: Updated state
  API-->>FE: Updated UI
  SO->>NOTIF: Notify followed
  NOTIF-->>FE: Push notification
  U->>FE: Open feed
  FE->>API: GET /feed
  API->>SO: Get posts
  SO-->>API: Posts
  API-->>FE: Render feed
```
### Diagram: Social Post Lifecycle
```mermaid
stateDiagram-v2
  [*] --> Creation
  Creation --> Notification: Post created
  Notification --> Interaction: Likes/Comments
  Interaction --> Moderation: Report
  Moderation --> Review: Admin reviews
  Review --> Action: Delete/Warn/Hide
  Action --> [*]
```

### n8n Flows (examples)

#### 1. Workflow: Telegram Chatbot

```mermaid
graph TB
  subgraph "Telegram Bot Workflow"
    START[Webhook Telegram]
    PARSE[Parse Message]
    AUTH[Check User Auth]
    CONTEXT[Get User Context]
    DIFY[Call Dify AI]
    RESPONSE[Format Response]
    SEND[Send to Telegram]
    LOG[Log Interaction]
  end

  START --> PARSE
  PARSE --> AUTH
  AUTH --> CONTEXT
  CONTEXT --> DIFY
  DIFY --> RESPONSE
  RESPONSE --> SEND
  SEND --> LOG
```

#### 2. Workflow: Daily Reminders

```mermaid
graph TB
  subgraph "Daily Reminder Workflow"
    CRON[Cron Trigger - 8:00 AM]
    USERS[Get Active Users]
    PROGRESS[Check Yesterday Progress]
    MOTIVATION[Generate Motivational Message]
    SEND_EMAIL[Send Email]
    SEND_TELEGRAM[Send Telegram]
    UPDATE_METRICS[Update Metrics]
  end

  CRON --> USERS
  USERS --> PROGRESS
  PROGRESS --> MOTIVATION
  MOTIVATION --> SEND_EMAIL
  MOTIVATION --> SEND_TELEGRAM
  SEND_EMAIL --> UPDATE_METRICS
  SEND_TELEGRAM --> UPDATE_METRICS
```

#### 3. Workflow: Content Moderation

```mermaid
graph TB
  subgraph "Content Moderation Workflow"
    TRIGGER[New Post/Comment]
    AI_CHECK[AI Content Check]
    FLAG_CHECK[Check for Flags]
    SCORE[Calculate Risk Score]
    DECISION{Score > Threshold?}
    AUTO_ACTION[Auto Action]
    MANUAL_REVIEW[Manual Review]
    NOTIFY[Notify Moderators]
  end

  TRIGGER --> AI_CHECK
  AI_CHECK --> FLAG_CHECK
  FLAG_CHECK --> SCORE
  SCORE --> DECISION
  DECISION -->|High| AUTO_ACTION
  DECISION -->|Medium| MANUAL_REVIEW
  DECISION -->|Low| NOTIFY
  AUTO_ACTION --> NOTIFY
  MANUAL_REVIEW --> NOTIFY
```

#### 4. Workflow: AI Plan Generation

```mermaid
graph TB
  subgraph "AI Plan Generation Workflow"
    REQUEST[Plan Generation Request]
    USER_DATA[Fetch User Data]
    PREFERENCES[Get Preferences]
    DIFY_CALL[Call Dify AI]
    VALIDATE[Validate Plan]
    SAVE[Save to Database]
    NOTIFY[Notify User]
    SCHEDULE[Add to Schedule]
  end

  REQUEST --> USER_DATA
  USER_DATA --> PREFERENCES
  PREFERENCES --> DIFY_CALL
  DIFY_CALL --> VALIDATE
  VALIDATE --> SAVE
  SAVE --> NOTIFY
  SAVE --> SCHEDULE
```

#### 5. Workflow: Calorie Tracking Notifications

```mermaid
graph TB
  subgraph "Calorie Tracking Workflow"
    LOG[Calorie Log Entry]
    GOAL_CHECK[Check Daily Goal]
    PROGRESS[Calculate Progress]
    ALERT{Goal Reached?}
    CONGRATULATE[Send Congratulations]
    REMINDER[Send Reminder]
    UPDATE_STREAK[Update Streak]
  end

  LOG --> GOAL_CHECK
  GOAL_CHECK --> PROGRESS
  PROGRESS --> ALERT
  ALERT -->|Yes| CONGRATULATE
  ALERT -->|No| REMINDER
  CONGRATULATE --> UPDATE_STREAK
  REMINDER --> UPDATE_STREAK
```

#### 6. Workflow: Social Engagement

```mermaid
graph TB
  subgraph "Social Engagement Workflow"
    POST[New Post Created]
    FOLLOWERS[Get Followers]
    FILTER[Filter Active Users]
    NOTIFY[Send Notifications]
    TREND_CHECK[Check Trending]
    BOOST[Boost if Trending]
    ANALYTICS[Update Analytics]
  end

  POST --> FOLLOWERS
  FOLLOWERS --> FILTER
  FILTER --> NOTIFY
  POST --> TREND_CHECK
  TREND_CHECK --> BOOST
  BOOST --> ANALYTICS
  NOTIFY --> ANALYTICS
```

### Sequence (Web AI Chat)
```mermaid
sequenceDiagram
  participant U as User
  participant FE as Frontend
  participant BE as Backend
  participant D as Dify
  U->>FE: Prompt
  FE->>BE: POST /ai/chat (JWT)
  BE->>D: Request (user context)
  D-->>BE: AI response
  BE-->>FE: Message + traces
```

### Sequence (workout plan generation)
```mermaid
sequenceDiagram
  participant U as User
  participant FE as Frontend
  participant API as API Gateway
  participant WO as Workout Service
  participant D as Dify
  U->>FE: Request weekly plan
  FE->>API: POST /workouts (goals, time, level)
  API->>WO: Create/generate plan
  WO->>D: Request AI suggestion (template + progression)
  D-->>WO: Proposed plan
  WO->>API: Save plan in DB and return ID
  API-->>FE: 201 Created (planId)
  FE-->>U: Show plan and calendar
```

### Sequence (social post and notification)
```mermaid
sequenceDiagram
  participant U as User
  participant FE as Frontend
  participant API as API Gateway
  participant SO as Social Service
  participant N8 as n8n
  participant EM as Email/Telegram
  U->>FE: Write post with photo
  FE->>API: POST /posts
  API->>SO: Create post and save media
  SO-->>API: Post created
  API-->>FE: 201 Created
  API->>N8: New post event
  N8->>EM: Notify followers
```

---

### Social Interactions: Post, Feed, Like, Comment
```mermaid
sequenceDiagram
  participant U as User
  participant FE as Frontend
  participant API as API Gateway
  participant SO as Social Service
  participant WS as WebSocket Gateway
  U->>FE: Create post (type: achievement/routine/tip/progress)
  FE->>API: POST /posts {type, content, media}
  API->>SO: Create post
  SO-->>API: 201 {postId}
  API-->>FE: 201 {postId}
  SO->>WS: event(PostCreated)
  WS-->>FE: push to followers
  U->>FE: Like post
  FE->>API: POST /posts/:id/like
  API->>SO: Register like
  SO->>WS: event(PostLiked)
  U->>FE: Comment post
  FE->>API: POST /posts/:id/comments {content}
  API->>SO: Create comment
  SO->>WS: event(CommentCreated)
```

### Basic Moderation (reports)
```mermaid
sequenceDiagram
  participant U as User
  participant FE as Frontend
  participant API as API
  participant SO as Social Service
  participant ADMIN as Admin Panel
  U->>FE: Report post/comment
  FE->>API: POST /moderation/report {entity,id,reason}
  API->>SO: Save report (status: pending)
  ADMIN->>SO: Review report queue
  SO-->>ADMIN: Details
  ADMIN->>SO: Action (hide/delete/warn)
  SO-->>API: Updated status
```

### User Interaction Diagrams (Mermaid)

### Publish Post
```mermaid
sequenceDiagram
  participant U as User
  participant FE as Frontend
  participant API as API Gateway
  participant SO as Social Service
  U->>FE: Write new post
  FE->>API: POST /posts {content, media}
  API->>SO: Create post
  SO-->>API: Post created
  API-->>FE: 201 Created
  FE-->>U: Show post in feed
```

### View Feed
```mermaid
sequenceDiagram
  participant U as User
  participant FE as Frontend
  participant API as API Gateway
  participant SO as Social Service
  U->>FE: Open feed
  FE->>API: GET /feed?type=all
  API->>SO: Get posts
  SO-->>API: List of posts
  API-->>FE: Posts and metadata
  FE-->>U: Render feed
```

### Like and Comment
```mermaid
sequenceDiagram
  participant U as User
  participant FE as Frontend
  participant API as API Gateway
  participant SO as Social Service
  participant WS as WebSocket Gateway
  U->>FE: Like a post
  FE->>API: POST /posts/:id/like
  API->>SO: Register like
  SO->>WS: event(PostLiked)
  WS-->>FE: Update likes in real time
  U->>FE: Comment post
  FE->>API: POST /posts/:id/comments {content}
  API->>SO: Create comment
  SO->>WS: event(CommentCreated)
  WS-->>FE: Show new comment
```

### Follow User
```mermaid
sequenceDiagram
  participant U as User
  participant FE as Frontend
  participant API as API Gateway
  participant SO as Social Service
  U->>FE: Click on follow user
  FE->>API: POST /users/:id/follow
  API->>SO: Register follow
  SO-->>API: Updated state
  API-->>FE: Update UI (following)
```

### Content Moderation
```mermaid
sequenceDiagram
  participant U as User
  participant FE as Frontend
  participant API as API Gateway
  participant SO as Social Service
  participant ADMIN as Admin Panel
  U->>FE: Report post/comment
  FE->>API: POST /moderation/report {entity, id, reason}
  API->>SO: Save report
  ADMIN->>SO: Review reports
  SO-->>ADMIN: Details and actions
  ADMIN->>SO: Action (hide/delete/warn)
  SO-->>API: Updated status
```

---

### Backend Class Diagram (Social)
```mermaid
classDiagram
  %% === CORE SOCIAL ENTITIES ===
  class Post {
    +id: UUID
    +userId: UUID
    +content: string
    +postType: PostType
    +workoutId: UUID?
    +imageUrls: string[]
    +videoUrl: string?
    +hashtags: string[]
    +likesCount: number
    +commentsCount: number
    +sharesCount: number
    +repostsCount: number
    +isPublic: boolean
    +isOriginal: boolean
    +originalPostId: UUID?
    +sharedFromUserId: UUID?
    +createdAt: Date
    +updatedAt: Date
    +addComment(comment: Comment)
    +addLike(userId: UUID)
    +removeLike(userId: UUID)
    +addShare(userId: UUID)
    +addRepost(userId: UUID)
    +addMedia(media: Media)
    +updateCounts()
    +validateContent()
  }

  class PostComment {
    +id: UUID
    +postId: UUID
    +userId: UUID
    +content: string
    +parentCommentId: UUID?
    +createdAt: Date
    +updatedAt: Date
    +edit(newContent: string)
    +delete()
    +addReply(reply: PostComment)
    +validateContent()
  }

  class PostLike {
    +id: UUID
    +postId: UUID
    +userId: UUID
    +createdAt: Date
    +toggle()
    +isLikedBy(userId: UUID): boolean
  }

  class PostShare {
    +id: UUID
    +postId: UUID
    +sharedByUserId: UUID
    +sharedWithUserId: UUID
    +shareType: ShareType
    +sharedAt: Date
    +execute()
    +notifyRecipient()
  }

  class PostRepost {
    +id: UUID
    +originalPostId: UUID
    +repostedByUserId: UUID
    +repostedAt: Date
    +execute()
    +notifyOriginalAuthor()
  }

  class Follow {
    +id: UUID
    +followerId: UUID
    +followingId: UUID
    +createdAt: Date
    +follow()
    +unfollow()
    +isFollowing(userId: UUID): boolean
    +getFollowersCount(): number
    +getFollowingCount(): number
  }

  class Notification {
    +id: UUID
    +userId: UUID
    +type: NotificationType
    +title: string
    +content: string
    +data: JSON
    +isRead: boolean
    +createdAt: Date
    +markAsRead()
    +markAsUnread()
    +sendPush()
    +sendEmail()
  }

  class Media {
    +id: UUID
    +url: string
    +type: MediaType
    +size: number
    +mimeType: string
    +uploadedBy: UUID
    +uploadedAt: Date
    +process()
    +optimize()
    +generateThumbnail()
    +delete()
  }

  class ModerationReport {
    +id: UUID
    +entityType: EntityType
    +entityId: UUID
    +reportedBy: UUID
    +reason: ReportReason
    +description: string
    +status: ReportStatus
    +reviewedBy: UUID?
    +reviewedAt: Date?
    +createdAt: Date
    +submit()
    +review(reviewerId: UUID)
    +resolve(action: ModerationAction)
    +escalate()
  }

  class SocialService {
    +createPost(userId: UUID, postData: CreatePostDTO): Post
    +getFeed(userId: UUID, filters: FeedFilters): FeedResponse
    +likePost(userId: UUID, postId: UUID): PostLike
    +unlikePost(userId: UUID, postId: UUID): boolean
    +addComment(userId: UUID, postId: UUID, content: string): PostComment
    +followUser(followerId: UUID, followingId: UUID): Follow
    +unfollowUser(followerId: UUID, followingId: UUID): boolean
    +sharePost(userId: UUID, postId: UUID, shareData: ShareDTO): PostShare
    +repostPost(userId: UUID, originalPostId: UUID): PostRepost
    +reportContent(userId: UUID, reportData: ReportDTO): ModerationReport
    +getNotifications(userId: UUID): Notification[]
    +markNotificationAsRead(userId: UUID, notificationId: UUID): boolean
    +getUserFeed(userId: UUID, targetUserId: UUID): Post[]
    +searchPosts(query: string, filters: SearchFilters): Post[]
  }

  class PostType {
    <<enumeration>>
    ACHIEVEMENT
    ROUTINE
    TIP
    PROGRESS
    MOTIVATION
    QUESTION
    GENERAL
  }

  class ShareType {
    <<enumeration>>
    SHARE
    REPOST
    FORWARD
  }

  class NotificationType {
    <<enumeration>>
    LIKE
    COMMENT
    FOLLOW
    SHARE
    REPOST
    MENTION
    WORKOUT_COMPLETED
    ACHIEVEMENT_UNLOCKED
  }

  class ReportReason {
    <<enumeration>>
    SPAM
    HARASSMENT
    INAPPROPRIATE_CONTENT
    COPYRIGHT_VIOLATION
    FAKE_INFORMATION
    OTHER
  }

  %% === RELATIONSHIPS ===
  Post "1" --> "*" PostComment : "has comments"
  Post "1" --> "*" PostLike : "receives likes"
  Post "1" --> "*" PostShare : "is shared"
  Post "1" --> "*" PostRepost : "is reposted"
  Post "1" --> "*" ModerationReport : "can be reported"
  Post "1" --> "*" Media : "contains media"
  PostComment "1" --> "*" PostComment : "has replies"

  SocialService ..> Post
  SocialService ..> PostComment
  SocialService ..> PostLike
  SocialService ..> PostShare
  SocialService ..> PostRepost
  SocialService ..> Follow
  SocialService ..> Notification
  SocialService ..> ModerationReport
  SocialService ..> Media

  Post --> PostType
  PostShare --> ShareType
  Notification --> NotificationType
  ModerationReport --> ReportReason

```

### Frontend Class Diagram (Social)
```mermaid
classDiagram
    class SocialApiClient {
        +string baseUrl
        +string authToken
        +get(string path, QueryParams params) Promise~T~
        +post(string path, any body) Promise~T~
        +put(string path, any body) Promise~T~
        +delete(string path) Promise~boolean~
        +uploadMedia(File file) Promise~MediaDTO~
        +setAuthToken(string token)
        +handleError(ApiError error)
    }

    class SocialStore {
        +Map~UUID, PostDTO~ posts
        +Map~UUID, UserDTO~ users
        +FeedItem[] feedItems
        +NotificationDTO[] notifications
        +boolean isLoading
        +string error
        +Date lastFetchTime
        +loadFeed(FeedFilters filters) Promise~void~
        +loadPost(UUID postId) Promise~PostDTO~
        +loadUser(UUID userId) Promise~UserDTO~
        +loadNotifications() Promise~void~
        +refreshFeed() Promise~void~
        +clearError()
        +reset()
    }

  class FeedStore {
        +FeedItem[] items
        +boolean hasMore
        +boolean isLoading
        +FeedFilters filters
        +loadFeed(FeedFilters filters) Promise~void~
        +loadMore() Promise~void~
        +refresh() Promise~void~
        +likePost(UUID postId) Promise~void~
        +unlikePost(UUID postId) Promise~void~
        +addComment(UUID postId, string content) Promise~void~
        +followUser(UUID userId) Promise~void~
        +unfollowUser(UUID userId) Promise~void~
        +sharePost(UUID postId, ShareDTO shareData) Promise~void~
        +repostPost(UUID postId) Promise~void~
        +reportPost(UUID postId, string reason) Promise~void~
        +updateItem(FeedItem item)
        +removeItem(UUID postId)
    +subscribeRealtime()
        +unsubscribeRealtime()
    }

    class NotificationStore {
        +NotificationDTO[] notifications
        +number unreadCount
        +boolean isLoading
        +loadNotifications() Promise~void~
        +markAsRead(UUID notificationId) Promise~void~
        +markAllAsRead() Promise~void~
        +deleteNotification(UUID notificationId) Promise~void~
        +subscribeRealtime()
        +unsubscribeRealtime()
        +updateUnreadCount()
    }

  class FeedItem {
        +PostDTO post
        +UserDTO author
        +CommentDTO[] comments
        +number likes
        +number shares
        +number reposts
        +MediaDTO[] media
        +boolean isLiked
        +boolean isShared
        +boolean isReposted
        +boolean isFollowed
        +boolean canEdit
        +boolean canDelete
        +onLike()
        +onComment()
        +onShare()
        +onRepost()
        +onFollow()
        +onReport()
        +onEdit()
        +onDelete()
        +render() JSX.Element
    }

    class PostComposer {
        +PostType type
        +string content
        +MediaDTO[] media
        +string[] hashtags
        +UUID workoutId
        +boolean isSubmitting
        +number charCount
        +number maxChars
        +setContent(string content)
        +setType(PostType type)
        +addMedia(MediaDTO media)
        +removeMedia(UUID mediaId)
        +addHashtag(string tag)
        +removeHashtag(string tag)
        +setWorkout(UUID workoutId)
        +clearWorkout()
        +submit() Promise~void~
        +validate() boolean
        +reset()
    }

    class CommentSection {
        +UUID postId
        +CommentDTO[] comments
        +boolean isLoading
        +boolean hasMore
        +string newComment
        +UUID replyingTo
        +loadComments() Promise~void~
        +loadMoreComments() Promise~void~
        +addComment(string content) Promise~void~
        +replyToComment(UUID commentId, string content) Promise~void~
        +editComment(UUID commentId, string content) Promise~void~
        +deleteComment(UUID commentId) Promise~void~
        +likeComment(UUID commentId) Promise~void~
        +setReplyingTo(UUID commentId)
        +render() JSX.Element
    }

  class RealtimeClient {
        +WebSocket socket
        +boolean isConnected
        +Set~string~ subscriptions
        +number reconnectAttempts
        +number maxReconnectAttempts
        +connect() Promise~void~
        +disconnect()
        +subscribe(string topic)
        +unsubscribe(string topic)
        +onEvent(RealtimeEvent event, Function callback)
        +offEvent(RealtimeEvent event, Function callback)
        +emit(string event, any data)
        +handleReconnect()
    }

    class PostDTO {
        +UUID id
        +UUID userId
        +string content
        +PostType postType
        +UUID workoutId
        +string[] imageUrls
        +string videoUrl
        +string[] hashtags
        +number likesCount
        +number commentsCount
        +number sharesCount
        +number repostsCount
        +boolean isPublic
        +boolean isOriginal
        +UUID originalPostId
        +UUID sharedFromUserId
        +Date createdAt
        +Date updatedAt
    }

    class UserDTO {
        +UUID id
        +string username
        +string fullName
        +string avatarUrl
        +string bio
        +string fitnessLevel
        +number followersCount
        +number followingCount
        +number postsCount
        +boolean isFollowing
        +boolean isFollowed
        +boolean isVerified
    }

    class CommentDTO {
        +UUID id
        +UUID postId
        +UUID userId
        +string content
        +UUID parentCommentId
        +number likesCount
        +number repliesCount
        +boolean isLiked
        +boolean canEdit
        +boolean canDelete
        +Date createdAt
        +Date updatedAt
        +UserDTO author
    }

    class MediaDTO {
        +UUID id
        +string url
        +MediaType type
        +number size
        +string mimeType
        +string thumbnailUrl
        +Date uploadedAt
    }

    class NotificationDTO {
        +UUID id
        +UUID userId
        +NotificationType type
        +string title
        +string content
        +JSON data
        +boolean isRead
        +Date createdAt
        +string actionUrl
    }

    class PostType {
        <<enumeration>>
        ACHIEVEMENT
        ROUTINE
        TIP
        PROGRESS
        MOTIVATION
        QUESTION
        GENERAL
    }

    class MediaType {
        <<enumeration>>
        IMAGE
        VIDEO
        GIF
        AUDIO
    }

    class NotificationType {
        <<enumeration>>
        LIKE
        COMMENT
        FOLLOW
        SHARE
        REPOST
        MENTION
        WORKOUT_COMPLETED
        ACHIEVEMENT_UNLOCKED
    }

    SocialApiClient ..> SocialStore : "uses"
    SocialApiClient ..> FeedStore : "uses"
    SocialApiClient ..> NotificationStore : "uses"
    SocialApiClient ..> PostComposer : "uses"

    RealtimeClient ..> SocialStore : "updates"
    RealtimeClient ..> FeedStore : "updates"
    RealtimeClient ..> NotificationStore : "updates"

    SocialStore o-- FeedStore : "contains"
    SocialStore o-- NotificationStore : "contains"

    FeedStore o-- FeedItem : "manages"
    FeedItem o-- CommentSection : "contains"

    FeedItem --> PostDTO : "displays"
    FeedItem --> UserDTO : "displays"
    FeedItem --> MediaDTO : "displays"

    CommentSection --> CommentDTO : "displays"
    CommentSection --> UserDTO : "displays"

    PostComposer --> PostType : "uses"
    PostComposer --> MediaDTO : "manages"

    NotificationStore --> NotificationDTO : "manages"
    NotificationDTO --> NotificationType : "uses"

    PostDTO --> PostType : "uses"
    MediaDTO --> MediaType : "uses"
```

---


### ER: Training Data Flow
```mermaid
erDiagram
  USER ||--o{ WORKOUT : "has"
  WORKOUT ||--o{ WORKOUT_LOG : "logs"
  WORKOUT_LOG {
    uuid id PK
    uuid workout_id FK
    date log_date
    jsonb metrics
  }
  WORKOUT {
    uuid id PK
    uuid user_id FK
    jsonb plan
    jsonb progress
  }
  USER {
    uuid id PK
    text email
    text display_name
  }
```

### ER: Nutrition Data Flow
```mermaid
erDiagram
  USER ||--o{ DIET : "has"
  DIET ||--o{ DIET_DAY : "plans"
  DIET_DAY ||--o{ MEAL : "includes"
  MEAL ||--o{ FOOD_ITEM : "contains"
  DIET {
    uuid id PK
    uuid user_id FK
    jsonb plan
  }
  DIET_DAY {
    uuid id PK
    uuid diet_id FK
    int day_of_week
  }
  MEAL {
    uuid id PK
    uuid diet_day_id FK
    time meal_time
  }
  FOOD_ITEM {
    uuid id PK
    text name
    int calories
    int proteinGrams
    int carbsGrams
    int fatGrams
  }
```

### ER: Social Data Flow
```mermaid
erDiagram
  USER ||--o{ POST : "writes"
  POST ||--o{ COMMENT : "has"
  POST ||--o{ LIKE : "receives"
  USER ||--o{ FOLLOW : "follows"
  POST {
    uuid id PK
    uuid user_id FK
    text content
    jsonb media
    int likes
  }
  COMMENT {
    uuid id PK
    uuid post_id FK
    uuid user_id FK
    text content
  }
  LIKE {
    uuid id PK
    uuid post_id FK
    uuid user_id FK
  }
  FOLLOW {
    uuid follower_id FK
    uuid followee_id FK
  }
```

### ER: AI Recommendations Data Flow
```mermaid
erDiagram
  USER ||--o{ RECOMMENDATION : "receives"
  RECOMMENDATION {
    uuid id PK
    uuid user_id FK
    text type
    text content
    date created_at
  }
```

### ER: Notifications Data Flow
```mermaid
erDiagram
  USER ||--o{ NOTIFICATION : "receives"
  NOTIFICATION {
    uuid id PK
    uuid user_id FK
    text type
    text content
    bool read
    date created_at
  }
```

---

### Dependencies and Health Checks
```mermaid
graph TD
  subgraph Externals
    SUPA[Supabase]
    DIFY[Dify]
    N8N[n8n]
    SMTP[SMTP]
  end

  subgraph Services
    API[API /health]
    USER[User /health]
    WORKOUT[Workout /health]
    NUTR[Nutrition /health]
    SOCIAL[Social /health]
    CHAT[Chat /health]
    RECO[Reco /health]
    NOTIF[Notif /health]
  end

  USER --> SUPA
  WORKOUT --> SUPA
  NUTR --> SUPA
  SOCIAL --> SUPA
  CHAT --> N8N
  RECO --> DIFY
  NOTIF --> SMTP
  API --> USER
  API --> WORKOUT
  API --> NUTR
  API --> SOCIAL
  API --> CHAT
  API --> RECO
  API --> NOTIF
```

---

### Threat Model and Security
```mermaid
graph TB
  subgraph Threats
    INJ[Injections]
    XSS[XSS]
    CSRF[CSRF]
    DDOS[DDoS]
    LEAK[Data Leak]
  end

  subgraph Controls
    WAF[WAF + Rate limit]
    AUTH[OAuth2/OIDC + JWT]
    VALID[Validation/Zod]
    TLS[TLS/HTTPS]
    RBAC[RBAC/K8s Policies]
    LOGS[Audit/Trace]
    CSP[CSP/Headers]
  end

  INJ --> VALID
  XSS --> CSP
  CSRF --> AUTH
  DDOS --> WAF
  LEAK --> RBAC
  AUTH --> LOGS
  TLS --> AUTH
```

---

### Monitoring & Observability Stack
```mermaid
graph TB
  subgraph Metrics
    PROM[Prometheus]
    GRAF[Grafana]
    ALERT[Alertmanager]
  end
  subgraph Logs
    PROMTAIL[Promtail]
    LOKI[Loki]
  end
  subgraph Traces
    OTEL[OpenTelemetry]
    JAEGER[Jaeger (optional)]
  end

  PROM --> GRAF
  PROM --> ALERT
  PROMTAIL --> LOKI --> GRAF
  OTEL --> JAEGER
```


---

## 12. AI Integration (Chatbot and Recommender) 🤖

### AI Architecture

```mermaid
graph TB
  subgraph "Frontend"
    CHAT_UI[Chat Interface]
    RECO_UI[Recommendation Cards]
  end
  
  subgraph "Backend AI Services"
    AI_GATEWAY[AI Gateway]
    CHAT_SVC[Chat Service]
    RECO_SVC[Recommendation Service]
    CONTEXT_SVC[Context Service]
  end
  
  subgraph "AI Platforms"
    DIFY[Dify AI Platform]
    N8N[n8n Workflows]
  end
  
  subgraph "Data Sources"
    USER_DATA[User Profile & History]
    WORKOUT_DATA[Workout Data]
    NUTR_DATA[Nutrition Data]
    SOCIAL_DATA[Social Interactions]
  end
  
  subgraph "External AI"
    OPENAI[OpenAI GPT]
    ANTHROPIC[Anthropic Claude]
    CUSTOM[Custom Models]
  end
  
  CHAT_UI --> AI_GATEWAY
  RECO_UI --> AI_GATEWAY
  
  AI_GATEWAY --> CHAT_SVC
  AI_GATEWAY --> RECO_SVC
  AI_GATEWAY --> CONTEXT_SVC
  
  CHAT_SVC --> DIFY
  RECO_SVC --> DIFY
  CONTEXT_SVC --> USER_DATA
  CONTEXT_SVC --> WORKOUT_DATA
  CONTEXT_SVC --> NUTR_DATA
  CONTEXT_SVC --> SOCIAL_DATA
  
  DIFY --> OPENAI
  DIFY --> ANTHROPIC
  DIFY --> CUSTOM
  
  N8N --> DIFY
```

### AI Chatbot Flow

```mermaid
sequenceDiagram
  participant U as User
  participant FE as Frontend
  participant AI as AI Gateway
  participant CTX as Context Service
  participant DIFY as Dify AI
  participant DB as Database
  
  U->>FE: Send message
  FE->>AI: POST /ai/chat {message, sessionId}
  AI->>CTX: Get user context
  CTX->>DB: Query profile + history
  DB-->>CTX: User data
  CTX-->>AI: Enriched context
  AI->>DIFY: Request with context
  DIFY->>DIFY: Process with LLM
  DIFY-->>AI: AI response
  AI->>DB: Save conversation
  AI-->>FE: Response + metadata
  FE-->>U: Show response
```

### Recommendation System

```mermaid
graph TB
  subgraph "Input Data"
    PROFILE[User Profile]
    HISTORY[Activity History]
    SOCIAL[Social Interactions]
    PREFERENCES[Preferences]
  end
  
  subgraph "Processing"
    FEATURE[Feature Engineering]
    EMBED[Embeddings]
    COLLAB[Collaborative Filtering]
    CONTENT[Content Filtering]
  end
  
  subgraph "AI Models"
    DIFY[Dify AI Orchestrator]
    RANK[Ranking Algorithm]
    DIVERSITY[Diversity Filter]
  end
  
  subgraph "Output"
    ROUTINES[Recommended Routines]
    FOODS[Recommended Foods]
    USERS[Similar Users]
    POSTS[Relevant Posts]
  end
  
  PROFILE --> FEATURE
  HISTORY --> FEATURE
  SOCIAL --> FEATURE
  PREFERENCES --> FEATURE
  
  FEATURE --> EMBED
  FEATURE --> COLLAB
  FEATURE --> CONTENT
  
  EMBED --> DIFY
  COLLAB --> DIFY
  CONTENT --> DIFY
  
  DIFY --> RANK
  RANK --> DIVERSITY
  
  DIVERSITY --> ROUTINES
  DIVERSITY --> FOODS
  DIVERSITY --> USERS
  DIVERSITY --> POSTS
```

### AI Evaluation and Metrics

```mermaid
graph TB
  subgraph "Chatbot Metrics"
    RESPONSE_TIME[Response Time]
    SATISFACTION[User Satisfaction]
    TASK_COMPLETION[Task Completion]
    CONTEXT_ACCURACY[Contextual Accuracy]
  end
  
  subgraph "Recommendation Metrics"
    CLICK_THROUGH[Click-Through Rate]
    CONVERSION[Conversion to Plan]
    RETENTION[User Retention]
    DIVERSITY_SCORE[Diversity Score]
  end
  
  subgraph "Feedback Loop"
    IMPLICIT[Implicit Feedback]
    EXPLICIT[Explicit Feedback]
    A_B_TESTING[A/B Testing]
  end
  
  subgraph "Continuous Improvement"
    MODEL_UPDATE[Model Update]
    PROMPT_OPT[Prompt Optimization]
    FEATURE_ENG[Feature Engineering]
  end
  
  RESPONSE_TIME --> IMPLICIT
  SATISFACTION --> EXPLICIT
  TASK_COMPLETION --> A_B_TESTING
  CONTEXT_ACCURACY --> MODEL_UPDATE
  
  CLICK_THROUGH --> IMPLICIT
  CONVERSION --> EXPLICIT
  RETENTION --> A_B_TESTING
  DIVERSITY_SCORE --> MODEL_UPDATE
  
  IMPLICIT --> MODEL_UPDATE
  EXPLICIT --> PROMPT_OPT
  A_B_TESTING --> FEATURE_ENG
```

- **Chatbot**: user sessions (web), history, tools (exercise search, macros, calendar).
- **Recommender**: hybrid signals (content + collaborative); Dify as orchestrator.
- **Evaluation**: prompt tests, implicit feedback (clicks/usage), explicit feedback (rating).

---

## 13. Startup Guide ⚙️

### Development Flow

```mermaid
graph TB
  subgraph "Initial Setup"
    CLONE[Clone Repository]
    ENV[Configure Variables]
    DEPS[Install Dependencies]
  end
  
  subgraph "Local Services"
    DOCKER[Start Docker Compose]
    DB[Initialize Database]
  end
  
  subgraph "Development"
    DEV[Run in Development Mode]
    TEST[Run Tests]
    LINT[Linting and Formatting]
  end
  
  subgraph "Deployment"
    BUILD[Production Build]
    K8S[Deploy to Kubernetes]
    MONITOR[Configure Monitoring]
  end
  
  CLONE --> ENV
  ENV --> DEPS
  DEPS --> DOCKER
  DOCKER --> DB
  DB --> DEV
  DEV --> TEST
  TEST --> LINT
  LINT --> BUILD
  BUILD --> K8S
  K8S --> MONITOR
```

### Development URLs

#### **Backend API (Port 3000)**
- **Main API**: http://localhost:3000
- **Interactive Docs**: http://localhost:3000/reference
- **OpenAPI Specification**: http://localhost:3000/openapi.json
- **Health Check**: http://localhost:3000/health
- **API Root Info**: http://localhost:3000/

#### **Local Supabase (Ports 54321-54329)**
- **Supabase Studio**: http://localhost:54323
- **API Gateway**: http://localhost:54321
- **Database**: postgresql://postgres:postgres@localhost:54322/postgres
- **Realtime**: ws://localhost:54321/realtime/v1/
- **Storage**: http://localhost:54321/storage/v1/
- **Auth**: http://localhost:54321/auth/v1/
- **Email Testing (Inbucket)**: http://localhost:54324

#### **Specific API Endpoints**
- **Authentication**: http://localhost:3000/api/v1/auth
- **Users**: http://localhost:3000/api/v1/users
- **Workouts**: http://localhost:3000/api/v1/workouts
- **Social**: http://localhost:3000/api/v1/social
- **Posts**: http://localhost:3000/api/v1/social/posts
- **Routines**: http://localhost:3000/api/v1/workouts/routines
- **Dashboard**: http://localhost:3000/api/v1/dashboard
- **Settings**: http://localhost:3000/api/v1/settings
- **Personal Info**: http://localhost:3000/api/v1/users/personal

#### **Testing and Development**
- **Vitest UI**: http://localhost:51204 (when running `npm run test:ui`)
- **Coverage Report**: Generated in `coverage/` after `npm run test:coverage`

### Actual Backend Project Structure

```mermaid
graph TB  
  subgraph "backend/"
    ROOT["backend/"]
    
    subgraph "src/ - Source Code"
      INDEX["index.ts - Entry Point"]
      
      subgraph "modules/ - Business Modules"
        AUTH_MOD["auth/ - Authentication"]
        USER_MOD["users/ - User Management"]
        WORKOUT_MOD["workouts/ - Workouts"]
        SOCIAL_MOD["social/ - Social Features"]
      end
      
      subgraph "routes/ - Route Handlers"
        AUTH_HANDLER["auth.handler.ts"]
        USER_HANDLER["user.handler.ts"]
        WORKOUT_HANDLER["workout.handler.ts"]
        SOCIAL_HANDLER["social.handler.ts"]
        POSTS_HANDLER["posts.handler.ts"]
        ROUTINES_HANDLER["routines.handler.ts"]
        DASHBOARD_HANDLER["dashboard.handler.ts"]
        SETTINGS_HANDLER["settings.handler.ts"]
        PERSONAL_HANDLER["personal.handler.ts"]
      end
      
      subgraph "shared/ - Shared Utils"
        DB["db/ - DB Config"]
        MIDDLEWARE["middleware/ - Middlewares"]
        UTILS["utils/ - Utilities"]
      end
      
      subgraph "types/ - TypeScript Types"
        DB_TYPES["database.types.ts"]
        CUSTOM_TYPES["Custom Types"]
      end
    end
    
    subgraph "supabase/ - Database"
      CONFIG["config.toml - Config"]
      MIGRATIONS["migrations/ - SQL Migrations"]
    end
    
    subgraph "scripts/ - Automation Scripts"
      SETUP["setup-database.sh"]
      OPENAPI["generate-complete-openapi.js"]
    end
    
    subgraph "config/ - Configuration"
      ENV["env.ts - Env Variables"]
    end
    
    subgraph "tests/ - Testing"
      UNIT_TESTS["Unit Tests"]
      INTEGRATION_TESTS["Integration Tests"]
    end
    
    subgraph "docs/ - Documentation"
      API_DOCS["API Documentation"]
    end
    
    subgraph "Config Files"
      PACKAGE["package.json"]
      TSCONFIG["tsconfig.json"]
      VITEST["vitest.config.ts"]
      DOCKERFILE["Dockerfile"]
      GITIGNORE[".gitignore"]
      ENV_EXAMPLE["env.example"]
    end
  end
  
  %% Relationships
  INDEX --> AUTH_MOD
  INDEX --> USER_MOD
  INDEX --> WORKOUT_MOD
  INDEX --> SOCIAL_MOD
  
  AUTH_MOD --> AUTH_HANDLER
  USER_MOD --> USER_HANDLER
  WORKOUT_MOD --> WORKOUT_HANDLER
  SOCIAL_MOD --> SOCIAL_HANDLER
  
  AUTH_HANDLER --> MIDDLEWARE
  USER_HANDLER --> MIDDLEWARE
  WORKOUT_HANDLER --> MIDDLEWARE
  SOCIAL_HANDLER --> MIDDLEWARE
  
  MIDDLEWARE --> UTILS
  UTILS --> DB
  DB --> MIGRATIONS
```

### Actual Frontend Project Structure

```mermaid
graph TB  
  subgraph "frontend/"
    ROOT["frontend/"]
    
    subgraph "src/ - Source Code"
      APP["app/ - App Router (Next.js 14)"]
      
      subgraph "app/ - App Router"
        LAYOUT["layout.tsx - Main Layout"]
        PAGE["page.tsx - Home Page"]
        GLOBAL_CSS["globals.css - Global Styles"]
        
        subgraph "auth/ - Authentication"
          LOGIN_PAGE["login/page.tsx"]
          REGISTER_PAGE["register/page.tsx"]
          AUTH_LAYOUT["auth/layout.tsx"]
        end
        
        subgraph "dashboard/ - Main Dashboard"
          DASHBOARD_PAGE["dashboard/page.tsx"]
          DASHBOARD_LAYOUT["dashboard/layout.tsx"]
        end
        
        subgraph "workouts/ - Workouts"
          WORKOUTS_PAGE["workouts/page.tsx"]
          WORKOUT_DETAIL["workouts/[id]/page.tsx"]
          WORKOUT_CREATE["workouts/create/page.tsx"]
        end
        
        subgraph "social/ - Social Network"
          SOCIAL_PAGE["social/page.tsx"]
          POST_DETAIL["social/posts/[id]/page.tsx"]
          PROFILE_PAGE["social/profile/[id]/page.tsx"]
        end
        
        subgraph "api/ - API Routes"
          AUTH_API["api/auth/[...nextauth]/route.ts"]
          WORKOUT_API["api/workouts/route.ts"]
          SOCIAL_API["api/social/route.ts"]
        end
      end
      
      subgraph "components/ - Reusable Components"
        UI["ui/ - shadcn/ui components"]
        FORMS["forms/ - Forms"]
        LAYOUTS["layouts/ - Specific Layouts"]
        
        subgraph "ui/ - Base Components"
          BUTTON["button.tsx"]
          INPUT["input.tsx"]
          CARD["card.tsx"]
          DIALOG["dialog.tsx"]
          TOAST["toast.tsx"]
        end
        
        subgraph "forms/ - Forms"
          LOGIN_FORM["LoginForm.tsx"]
          WORKOUT_FORM["WorkoutForm.tsx"]
          POST_FORM["PostForm.tsx"]
        end
      end
      
      subgraph "lib/ - Utils and Config"
        AUTH_CONFIG["auth.ts - Auth.js config"]
        API_CLIENT["api-client.ts - API Client"]
        UTILS["utils.ts - General Utilities"]
        VALIDATIONS["validations.ts - Zod schemas"]
        CONSTANTS["constants.ts - Constants"]
      end
      
      subgraph "hooks/ - Custom Hooks"
        USE_AUTH["useAuth.ts"]
        USE_WORKOUTS["useWorkouts.ts"]
        USE_SOCIAL["useSocial.ts"]
        USE_API["useApi.ts"]
      end
      
      subgraph "stores/ - Global State (Zustand)"
        AUTH_STORE["authStore.ts"]
        WORKOUT_STORE["workoutStore.ts"]
        SOCIAL_STORE["socialStore.ts"]
        UI_STORE["uiStore.ts"]
      end
      
      subgraph "types/ - TypeScript Types"
        API_TYPES["api.types.ts"]
        COMPONENT_TYPES["component.types.ts"]
        STORE_TYPES["store.types.ts"]
      end
    end
    
    subgraph "public/ - Static Files"
      IMAGES["images/ - Images"]
      ICONS["icons/ - Icons"]
      FONTS["fonts/ - Custom Fonts"]
    end
    
    subgraph "styles/ - Styles"
      GLOBAL_CSS["globals.css"]
      COMPONENTS_CSS["components.css"]
      UTILITIES_CSS["utilities.css"]
    end
    
    subgraph "tests/ - Testing"
      UNIT_TESTS["__tests__/ - Unit Tests"]
      E2E_TESTS["e2e/ - E2E Tests"]
      TEST_UTILS["test-utils.tsx"]
    end
    
    subgraph "Config Files"
      PACKAGE["package.json"]
      NEXT_CONFIG["next.config.js"]
      TAILWIND_CONFIG["tailwind.config.js"]
      TSCONFIG["tsconfig.json"]
      ESLINT_CONFIG[".eslintrc.json"]
      PRETTIER_CONFIG[".prettierrc"]
      PLAYWRIGHT_CONFIG["playwright.config.ts"]
    end
  end
  
  %% Main Relationships
  LAYOUT --> AUTH_PAGE
  LAYOUT --> DASHBOARD_PAGE
  LAYOUT --> WORKOUTS_PAGE
  LAYOUT --> SOCIAL_PAGE
  
  AUTH_PAGE --> LOGIN_FORM
  WORKOUTS_PAGE --> WORKOUT_FORM
  SOCIAL_PAGE --> POST_FORM
  
  LOGIN_FORM --> AUTH_STORE
  WORKOUT_FORM --> WORKOUT_STORE
  POST_FORM --> SOCIAL_STORE
  
  AUTH_STORE --> API_CLIENT
  WORKOUT_STORE --> API_CLIENT
  SOCIAL_STORE --> API_CLIENT
  
  API_CLIENT --> AUTH_API
  API_CLIENT --> WORKOUT_API
  API_CLIENT --> SOCIAL_API
```

### Module Structure Details

#### **📁 Frontend - Next.js 14 Architecture**

**App Router Structure:**
- **`app/`**: Main directory with Next.js 14 App Router
- **`app/layout.tsx`**: Root layout with global providers
- **`app/page.tsx`**: Main landing/home page
- **`app/globals.css`**: Global styles using Tailwind CSS

**Feature-based Routing:**
- **`app/auth/`**: Authentication pages (login, register)
- **`app/dashboard/`**: Main user dashboard
- **`app/workouts/`**: Workout management
- **`app/social/`**: Social network and posts
- **`app/api/`**: Next.js API routes

**Component Architecture:**
- **`components/ui/`**: shadcn/ui base components
- **`components/forms/`**: Feature-specific forms
- **`components/layouts/`**: Specific layouts

**State Management:**
- **`stores/`**: Zustand stores by feature
- **`hooks/`**: Custom reusable hooks
- **`lib/`**: Utilities, config, and API clients

#### **📁 Backend - Business Modules**

Each module follows the **Service-Middleware-Types** pattern:

```mermaid
graph LR
  subgraph "Module Pattern"
    SERVICE[service.ts - Business logic]
    MIDDLEWARE[middleware.ts - Validations]
    TYPES[types.ts - TypeScript interfaces]
    ROUTES[routes.ts - Route definitions]
  end
  
  ROUTES --> MIDDLEWARE
  MIDDLEWARE --> SERVICE
  SERVICE --> TYPES
```

**Implemented Modules:**
- **`auth/`**: JWT authentication, registration, login, refresh tokens
- **`users/`**: User profile management, configuration
- **`workouts/`**: Workouts, exercises, sessions
- **`social/`**: Posts, likes, comments, social feed

#### **📁 src/routes/ - Route Handlers**

Each handler manages a specific group of endpoints:

- **`auth.handler.ts`**: `/api/v1/auth/*`
- **`user.handler.ts`**: `/api/v1/users/*`
- **`workout.handler.ts`**: `/api/v1/workouts/*`
- **`social.handler.ts`**: `/api/v1/social/*`
- **`posts.handler.ts`**: `/api/v1/social/posts/*`
- **`routines.handler.ts`**: `/api/v1/workouts/routines/*`
- **`dashboard.handler.ts`**: `/api/v1/dashboard/*`
- **`settings.handler.ts`**: `/api/v1/settings/*`
- **`personal.handler.ts`**: `/api/v1/users/personal/*`

#### **📁 src/shared/ - Shared Utilities**

**`middleware/`**:
- `auth.middleware.ts`: JWT verification
- `error.middleware.ts`: Global error handling
- `rate-limit.middleware.ts`: Rate limiting
- `validation.middleware.ts`: Data validation

**`utils/`** (25+ utilities):
- `database.ts`: Supabase connection
- `validation.ts`: Zod validators
- `response.ts`: API response formatting
- `security.ts`: Security functions
- `logger.ts`: Logging system
- `cache.ts`: Cache management
- `email.ts`: Email sending
- `storage.ts`: File management
- And 18+ more utilities...

#### **📁 supabase/ - Database**

**`migrations/`**:
- `001_initial_schema.sql`: Initial schema
- `002_rls_policies.sql`: Security policies
- `003_seed_data.sql`: Test data
- `004_personal_info_and_enhanced_features.sql`: Advanced features

**`config.toml`**: Complete local Supabase config

#### **Automation Scripts**

- **`setup-database.sh`**: Initial DB setup
- **`generate-openapi.js`**: Unified OpenAPI documentation generation


### Available Development Commands

```bash
# Development
npm run dev              # Server with hot-reload
npm run serve            # Local production server
npm run build            # Build for production
npm run start            # Start production server

# Database
npm run db:start         # Start local Supabase
npm run db:stop          # Stop local Supabase
npm run db:reset         # Reset database
npm run db:migrate       # Apply migrations
npm run db:generate-types # Generate TypeScript types
npm run db:setup         # Initial setup

# Testing
npm run test             # Unit tests
npm run test:ui          # Testing UI
npm run test:coverage    # Coverage tests

# Code Quality
npm run lint             # Linting
npm run lint:fix         # Lint + fix
npm run type-check       # Type checking

# Documentation
npm run docs:generate          # Generate complete OpenAPI
npm run docs:serve             # Serve documentation
npm run docs:open              # Open docs in browser
```

### CI/CD Pipeline

#### **Main Pipeline - Push to Main**

```mermaid
graph TB
  subgraph "🚀 Trigger: Push to main"
    PUSH[Push to main branch]
  end
  
  subgraph "🔍 Stage 1: Validation & Preparation"
    CHECKOUT[Checkout Code]
    SETUP[Setup Node.js Environment]
    INSTALL[Install Dependencies]
    CACHE[Cache Dependencies]
  end
  
  subgraph "🧪 Stage 2: Testing"
    UNIT_TESTS[Unit Tests<br/>npm run test]
    INTEGRATION_TESTS[Integration Tests<br/>npm run test:integration]
    COVERAGE[Coverage Report<br/>npm run test:coverage]
    TEST_RESULTS[Test Results Analysis]
  end
  
  subgraph "🔍 Stage 3: Code Quality"
    LINT[Lint Code<br/>npm run lint]
    TYPE_CHECK[Type Check<br/>npm run type-check]
    SECURITY[Security Scan<br/>npm audit]
    VULNERABILITIES[Vulnerability Check]
  end
  
  subgraph "🏗️ Stage 4: Build"
    BUILD[Build Application<br/>npm run build]
    DOCKER_BUILD[Docker Build<br/>docker build -t gympal-backend]
    DOCKER_PUSH[Docker Push to Registry]
    IMAGE_TAG[Tag Image with Git SHA]
  end
  
  subgraph "🚀 Stage 5: Deploy"
    ARGOCD_SYNC[ArgoCD Sync]
    K8S_DEPLOY[Kubernetes Deploy]
    HEALTH_CHECK[Health Check]
    ROLLBACK[Rollback if Failed]
  end
  
  subgraph "📊 Stage 6: Post-Deploy"
    NOTIFY[Send Notifications]
    METRICS[Update Metrics]
    DOCS[Update Documentation]
  end
  
  %% Main Flow
  PUSH --> CHECKOUT
  CHECKOUT --> SETUP
  SETUP --> INSTALL
  INSTALL --> CACHE
  
  CACHE --> UNIT_TESTS
  CACHE --> INTEGRATION_TESTS
  UNIT_TESTS --> COVERAGE
  INTEGRATION_TESTS --> COVERAGE
  COVERAGE --> TEST_RESULTS
  
  TEST_RESULTS --> LINT
  LINT --> TYPE_CHECK
  TYPE_CHECK --> SECURITY
  SECURITY --> VULNERABILITIES
  
  VULNERABILITIES --> BUILD
  BUILD --> DOCKER_BUILD
  DOCKER_BUILD --> DOCKER_PUSH
  DOCKER_PUSH --> IMAGE_TAG
  
  IMAGE_TAG --> ARGOCD_SYNC
  ARGOCD_SYNC --> K8S_DEPLOY
  K8S_DEPLOY --> HEALTH_CHECK
  HEALTH_CHECK --> ROLLBACK
  
  HEALTH_CHECK --> NOTIFY
  NOTIFY --> METRICS
  METRICS --> DOCS
  
  %% Error Flows
  TEST_RESULTS -.->|❌ Tests Failed| PUSH
  VULNERABILITIES -.->|❌ Security Issues| PUSH
  HEALTH_CHECK -.->|❌ Health Check Failed| ROLLBACK
  ROLLBACK -.->|❌ Rollback Failed| NOTIFY
```

#### **Detailed Testing Pipeline**

```mermaid
graph TB
  subgraph "🧪 Testing Pipeline"
    START[Start Testing]
    
    subgraph "Unit Tests"
      UNIT_SETUP[Setup Test Environment]
      UNIT_RUN[Run Unit Tests<br/>vitest]
      UNIT_COVERAGE[Generate Coverage]
      UNIT_REPORT[Unit Test Report]
    end
    
    subgraph "Integration Tests"
      INT_SETUP[Setup Test Database]
      INT_RUN[Run Integration Tests<br/>vitest --config vitest.integration.config.ts]
      INT_CLEANUP[Cleanup Test Data]
      INT_REPORT[Integration Test Report]
    end
    
    subgraph "E2E Tests"
      E2E_SETUP[Setup E2E Environment]
      E2E_RUN[Run E2E Tests<br/>playwright]
      E2E_VIDEO[Record Test Videos]
      E2E_REPORT[E2E Test Report]
    end
    
    subgraph "Performance Tests"
      PERF_SETUP[Setup Performance Environment]
      PERF_RUN[Run Load Tests<br/>k6]
      PERF_METRICS[Performance Metrics]
      PERF_REPORT[Performance Report]
    end
    
    subgraph "Security Tests"
      SEC_SCAN[Security Scan<br/>npm audit]
      SEC_SAST[Static Analysis<br/>semgrep]
      SEC_DEPS[Dependency Check<br/>snyk]
      SEC_REPORT[Security Report]
    end
    
    RESULTS[Consolidate Results]
    NOTIFY_RESULTS[Notify Results]
  end
  
  START --> UNIT_SETUP
  START --> INT_SETUP
  START --> E2E_SETUP
  START --> PERF_SETUP
  START --> SEC_SCAN
  
  UNIT_SETUP --> UNIT_RUN
  UNIT_RUN --> UNIT_COVERAGE
  UNIT_COVERAGE --> UNIT_REPORT
  
  INT_SETUP --> INT_RUN
  INT_RUN --> INT_CLEANUP
  INT_CLEANUP --> INT_REPORT
  
  E2E_SETUP --> E2E_RUN
  E2E_RUN --> E2E_VIDEO
  E2E_VIDEO --> E2E_REPORT
  
  PERF_SETUP --> PERF_RUN
  PERF_RUN --> PERF_METRICS
  PERF_METRICS --> PERF_REPORT
  
  SEC_SCAN --> SEC_SAST
  SEC_SAST --> SEC_DEPS
  SEC_DEPS --> SEC_REPORT
  
  UNIT_REPORT --> RESULTS
  INT_REPORT --> RESULTS
  E2E_REPORT --> RESULTS
  PERF_REPORT --> RESULTS
  SEC_REPORT --> RESULTS
  
  RESULTS --> NOTIFY_RESULTS
```

#### **Deploy Pipeline with ArgoCD**

```mermaid
graph TB
  subgraph "🚀 ArgoCD Deploy Pipeline"
    ARGOCD_TRIGGER[ArgoCD Detects Changes]
    
    subgraph "Pre-Deploy Validation"
      VALIDATE_MANIFESTS[Validate K8s Manifests]
      CHECK_RESOURCES[Check Resource Requirements]
      VALIDATE_IMAGES[Validate Docker Images]
      SECURITY_SCAN[Security Scan Images]
    end
    
    subgraph "Deploy Strategy"
      BLUE_GREEN[Blue-Green Deployment]
      CANARY[Canary Deployment]
      ROLLING[Rolling Update]
    end
    
    subgraph "Deploy Process"
      CREATE_NAMESPACE[Create/Update Namespace]
      APPLY_CONFIGMAPS[Apply ConfigMaps]
      APPLY_SECRETS[Apply Secrets]
      DEPLOY_APP[Deploy Application]
      DEPLOY_SERVICES[Deploy Services]
      DEPLOY_INGRESS[Deploy Ingress]
    end
    
    subgraph "Post-Deploy Verification"
      HEALTH_CHECK[Health Check Endpoints]
      READINESS_CHECK[Readiness Probe]
      LIVENESS_CHECK[Liveness Probe]
      SMOKE_TESTS[Smoke Tests]
      PERFORMANCE_CHECK[Performance Check]
    end
    
    subgraph "Monitoring & Alerting"
      PROMETHEUS_METRICS[Prometheus Metrics]
      GRAFANA_DASHBOARD[Grafana Dashboard]
      ALERT_MANAGER[Alert Manager]
      LOG_AGGREGATION[Log Aggregation]
    end
    
    subgraph "Rollback Strategy"
      ROLLBACK_TRIGGER[Rollback Trigger]
      ROLLBACK_EXECUTE[Execute Rollback]
      ROLLBACK_VERIFY[Verify Rollback]
    end
  end
  
  ARGOCD_TRIGGER --> VALIDATE_MANIFESTS
  VALIDATE_MANIFESTS --> CHECK_RESOURCES
  CHECK_RESOURCES --> VALIDATE_IMAGES
  VALIDATE_IMAGES --> SECURITY_SCAN
  
  SECURITY_SCAN --> BLUE_GREEN
  BLUE_GREEN --> CANARY
  CANARY --> ROLLING
  
  ROLLING --> CREATE_NAMESPACE
  CREATE_NAMESPACE --> APPLY_CONFIGMAPS
  APPLY_CONFIGMAPS --> APPLY_SECRETS
  APPLY_SECRETS --> DEPLOY_APP
  DEPLOY_APP --> DEPLOY_SERVICES
  DEPLOY_SERVICES --> DEPLOY_INGRESS
  
  DEPLOY_INGRESS --> HEALTH_CHECK
  HEALTH_CHECK --> READINESS_CHECK
  READINESS_CHECK --> LIVENESS_CHECK
  LIVENESS_CHECK --> SMOKE_TESTS
  SMOKE_TESTS --> PERFORMANCE_CHECK
  
  PERFORMANCE_CHECK --> PROMETHEUS_METRICS
  PROMETHEUS_METRICS --> GRAFANA_DASHBOARD
  GRAFANA_DASHBOARD --> ALERT_MANAGER
  ALERT_MANAGER --> LOG_AGGREGATION
  
  HEALTH_CHECK -.->|❌ Failed| ROLLBACK_TRIGGER
  READINESS_CHECK -.->|❌ Failed| ROLLBACK_TRIGGER
  LIVENESS_CHECK -.->|❌ Failed| ROLLBACK_TRIGGER
  SMOKE_TESTS -.->|❌ Failed| ROLLBACK_TRIGGER
  PERFORMANCE_CHECK -.->|❌ Failed| ROLLBACK_TRIGGER
  
  ROLLBACK_TRIGGER --> ROLLBACK_EXECUTE
  ROLLBACK_EXECUTE --> ROLLBACK_VERIFY
```

#### **Code Quality Pipeline**

```mermaid
graph TB
  subgraph "🔍 Code Quality Pipeline"
    CODE_CHANGES[Code Changes Detected]
    
    subgraph "Static Analysis"
      ESLINT[ESLint Analysis<br/>npm run lint]
      PRETTIER[Prettier Format Check<br/>npm run format:check]
      TSC[TypeScript Compilation<br/>npm run type-check]
      SONARQUBE[SonarQube Analysis]
    end
    
    subgraph "Security Analysis"
      NPM_AUDIT[NPM Audit<br/>npm audit]
      SNYK_SCAN[Snyk Security Scan]
      SEMGREP[Semgrep SAST]
      OWASP[OWASP Dependency Check]
    end
    
    subgraph "Code Metrics"
      COMPLEXITY[Cyclomatic Complexity]
      DUPLICATION[Code Duplication]
      MAINTAINABILITY[Maintainability Index]
      RELIABILITY[Reliability Rating]
    end
    
    subgraph "Documentation"
      JSDOC[JSDoc Validation]
      OPENAPI[OpenAPI Schema Validation]
      README[README Validation]
      CHANGELOG[Changelog Validation]
    end
    
    subgraph "Quality Gates"
      GATE_TESTS[Test Coverage > 80%]
      GATE_SECURITY[No High/Critical Vulnerabilities]
      GATE_DUPLICATION[Duplication < 3%]
      GATE_MAINTAINABILITY[Maintainability > B]
    end
    
    QUALITY_REPORT[Generate Quality Report]
    NOTIFY_QUALITY[Notify Quality Results]
  end
  
  CODE_CHANGES --> ESLINT
  CODE_CHANGES --> PRETTIER
  CODE_CHANGES --> TSC
  CODE_CHANGES --> SONARQUBE
  
  ESLINT --> NPM_AUDIT
  PRETTIER --> SNYK_SCAN
  TSC --> SEMGREP
  SONARQUBE --> OWASP
  
  NPM_AUDIT --> COMPLEXITY
  SNYK_SCAN --> DUPLICATION
  SEMGREP --> MAINTAINABILITY
  OWASP --> RELIABILITY
  
  COMPLEXITY --> JSDOC
  DUPLICATION --> OPENAPI
  MAINTAINABILITY --> README
  RELIABILITY --> CHANGELOG
  
  JSDOC --> GATE_TESTS
  OPENAPI --> GATE_SECURITY
  README --> GATE_DUPLICATION
  CHANGELOG --> GATE_MAINTAINABILITY
  
  GATE_TESTS --> QUALITY_REPORT
  GATE_SECURITY --> QUALITY_REPORT
  GATE_DUPLICATION --> QUALITY_REPORT
  GATE_MAINTAINABILITY --> QUALITY_REPORT
  
  QUALITY_REPORT --> NOTIFY_QUALITY
```

#### **Monitoring & Notifications Pipeline**

```mermaid
graph TB
  subgraph "📊 Monitoring & Notifications Pipeline"
    PIPELINE_EVENTS[Pipeline Events]
    
    subgraph "Notification Channels"
      SLACK[Slack Notifications]
      EMAIL[Email Notifications]
      TEAMS[Microsoft Teams]
      DISCORD[Discord Notifications]
    end
    
    subgraph "Monitoring Stack"
      PROMETHEUS[Prometheus Metrics]
      GRAFANA[Grafana Dashboards]
      JAEGER[Jaeger Tracing]
      ELK[ELK Stack Logs]
    end
    
    subgraph "Alerting Rules"
      DEPLOY_SUCCESS[Deploy Success Alert]
      DEPLOY_FAILURE[Deploy Failure Alert]
      TEST_FAILURE[Test Failure Alert]
      SECURITY_ALERT[Security Alert]
      PERFORMANCE_ALERT[Performance Alert]
    end
    
    subgraph "Metrics Collection"
      APP_METRICS[Application Metrics]
      INFRA_METRICS[Infrastructure Metrics]
      USER_METRICS[User Behavior Metrics]
      BUSINESS_METRICS[Business Metrics]
    end
    
    subgraph "Reporting"
      DAILY_REPORT[Daily Report]
      WEEKLY_REPORT[Weekly Report]
      MONTHLY_REPORT[Monthly Report]
      INCIDENT_REPORT[Incident Report]
    end
  end
  
  PIPELINE_EVENTS --> SLACK
  PIPELINE_EVENTS --> EMAIL
  PIPELINE_EVENTS --> TEAMS
  PIPELINE_EVENTS --> DISCORD
  
  SLACK --> PROMETHEUS
  EMAIL --> GRAFANA
  TEAMS --> JAEGER
  DISCORD --> ELK
  
  PROMETHEUS --> DEPLOY_SUCCESS
  GRAFANA --> DEPLOY_FAILURE
  JAEGER --> TEST_FAILURE
  ELK --> SECURITY_ALERT
  
  DEPLOY_SUCCESS --> APP_METRICS
  DEPLOY_FAILURE --> INFRA_METRICS
  TEST_FAILURE --> USER_METRICS
  SECURITY_ALERT --> BUSINESS_METRICS
  
  APP_METRICS --> DAILY_REPORT
  INFRA_METRICS --> WEEKLY_REPORT
  USER_METRICS --> MONTHLY_REPORT
  BUSINESS_METRICS --> INCIDENT_REPORT
```

---

## 14. KPIs and Success Metrics 🎯

### Metrics Dashboard

```mermaid
graph TB
  subgraph "User Metrics"
    MAU[Monthly Active Users]
    DAU[Daily Active Users]
    RETENTION[30-day Retention]
    GROWTH[Monthly Growth]
  end
  
  subgraph "Product Metrics"
    PLAN_COMPLETION[% Plans Completed]
    AI_SATISFACTION[AI Satisfaction]
    SOCIAL_ENGAGEMENT[Social Engagement]
    FEATURE_USAGE[Feature Usage]
  end
  
  subgraph "Technical Metrics"
    API_LATENCY[API Latency]
    ERROR_RATE[Error Rate]
    UPTIME[Availability]
    RESPONSE_TIME[Response Time]
  end
  
  subgraph "Business Metrics"
    CONVERSION[Conversion to Premium Plans]
    CHURN[Churn Rate]
    LTV[Lifetime Value]
    CAC[Customer Acquisition Cost]
  end
  
  MAU --> GROWTH
  DAU --> RETENTION
  PLAN_COMPLETION --> AI_SATISFACTION
  SOCIAL_ENGAGEMENT --> FEATURE_USAGE
  API_LATENCY --> ERROR_RATE
  UPTIME --> RESPONSE_TIME
  CONVERSION --> LTV
  CHURN --> CAC
```

---

## 15. Appendices 📎

### Blockchain Integration (Optional)

```mermaid
graph TB
  subgraph "Application"
    ACHIEVEMENT[Major Achievement]
    HASH[Generate Hash]
    METADATA[Achievement Metadata]
  end
  
  subgraph "Blockchain"
    POLYGON[Polygon Testnet]
    SMART_CONTRACT[Smart Contract]
    NFT[NFT Certificate]
  end
  
  subgraph "Verification"
    VERIFY[Verify on Blockchain]
    CERTIFICATE[Digital Certificate]
    PROOF[Proof of Existence]
  end
  
  ACHIEVEMENT --> HASH
  HASH --> METADATA
  METADATA --> POLYGON
  POLYGON --> SMART_CONTRACT
  SMART_CONTRACT --> NFT
  NFT --> VERIFY
  VERIFY --> CERTIFICATE
  CERTIFICATE --> PROOF
```

### Technology Roadmap

```mermaid
timeline
  title GymPal Technology Roadmap
  
  section Phase 1 (7 Oct - 3 Nov)
    Initial Setup : Next.js 14
                   : TypeScript
                   : Tailwind CSS
                   : Supabase
  
  section Phase 2 (4 Nov - 24 Nov)
    Backend Core : Hono Framework
                  : PostgreSQL
                  : Redis Cache
                  : JWT Auth
  
  section Phase 3 (25 Nov - 8 Dec)
    AI Integration : Dify AI
                    : n8n Workflows
                    : OpenAI/Anthropic
                    : Recommendation Engine
  
  section Phase 4 (9 Dec - 19 Dec)
    DevOps & Scale : Kubernetes
                    : ArgoCD
                    : Prometheus
                    : Grafana
```


### Project Gantt Chart

```mermaid
gantt
    title GymPal Project Schedule
    dateFormat  YYYY-MM-DD
    axisFormat  %d/%m
    
    section Phase 1 - Initial Setup
    Analysis and Design          :done, setup1, 2025-10-07, 2025-10-13
    Frontend Setup               :done, setup2, 2025-10-14, 2025-10-20
    Backend Setup                :done, setup3, 2025-10-21, 2025-10-27
    Supabase Integration         :done, setup4, 2025-10-28, 2025-11-03
    
    section Phase 2 - Backend Core
    REST APIs                    :active, api1, 2025-11-04, 2025-11-10
    Authentication               :active, api2, 2025-11-11, 2025-11-17
    Database                     :active, api3, 2025-11-18, 2025-11-24
    Progress Presentation        :milestone, pres1, 2025-10-24, 0d
    
    section Phase 3 - AI Integration
    Dify AI Setup                :ai1, 2025-11-25, 2025-12-01
    n8n Workflows                :ai2, 2025-12-02, 2025-12-08
    Demo 1                       :milestone, demo1, 2025-11-25, 0d
    Demo 2                       :milestone, demo2, 2025-11-28, 0d
    
    section Phase 4 - DevOps & Scale
    Kubernetes                   :dev1, 2025-12-09, 2025-12-12
    Monitoring                   :dev2, 2025-12-13, 2025-12-16
    Final Documentation          :dev3, 2025-12-17, 2025-12-19
    Final Delivery               :milestone, final, 2025-12-09, 0d
    Thesis Delivery              :milestone, memoria, 2025-12-19, 0d
```

```mermaid
gantt
    title GymPal Prioritized Roadmap (MVP-first)
    dateFormat YYYY-MM-DD
    
    section MVP Core (Critical)
    Auth + User Profile       :crit, mvp1, 2025-10-07, 3w
    Workout CRUD              :crit, mvp2, 2025-10-28, 2w
    Basic Social              :crit, mvp3, 2025-11-11, 2w
    
    section Added Value
    AI Chatbot Web            :ai1, 2025-11-25, 2w
    Basic Recommendations     :ai2, 2025-12-09, 1w
    
    section Nice-to-Have
    n8n Telegram Bot          :n8n1, 2025-12-16, 1w
    Schedule/Calendar         :extra, 2025-12-16, 1w
```

### Roles Gantt Chart

```mermaid
gantt
    title Roles Gantt Chart - GymPal
    dateFormat  YYYY-MM-DD
    axisFormat  %d/%m
    
    section Frontend Developer
    Setup Next.js               :front1, 2025-10-07, 2025-10-20
    UI Components               :front2, 2025-10-21, 2025-11-10
    State Management            :front3, 2025-11-11, 2025-11-24
    Social Features UI          :front4, 2025-11-25, 2025-12-08
    Final Polish                :front5, 2025-12-09, 2025-12-19
    
    section Backend Developer
    API Design                  :back1, 2025-10-07, 2025-10-27
    Authentication              :back2, 2025-10-28, 2025-11-10
    CRUD Operations             :back3, 2025-11-11, 2025-11-24
    Social APIs                 :back4, 2025-11-25, 2025-12-08
    Performance Optimization    :back5, 2025-12-09, 2025-12-19
    
    section DevOps/SRE
    Infrastructure Setup        :devops1, 2025-10-07, 2025-11-03
    CI/CD Pipeline              :devops2, 2025-11-04, 2025-11-24
    Kubernetes Deployment       :devops3, 2025-11-25, 2025-12-12
    Monitoring Setup            :devops4, 2025-12-13, 2025-12-19
    
    section AI/Integrations
    Dify AI Integration         :ai1, 2025-10-28, 2025-11-24
    n8n Workflows               :ai2, 2025-11-25, 2025-12-08
    Recommendation Engine       :ai3, 2025-12-02, 2025-12-12
    AI Testing & Optimization   :ai4, 2025-12-13, 2025-12-19
    
    section Product/QA
    Requirements Analysis        :qa1, 2025-10-07, 2025-10-13
    Test Planning               :qa2, 2025-10-14, 2025-11-03
    E2E Testing                 :qa3, 2025-11-04, 2025-12-08
    Documentation & Final QA    :qa4, 2025-12-09, 2025-12-19
    
    section Milestones
    Progress Presentation       :milestone, pres1, 2025-10-24, 0d
    Demo 1                      :milestone, demo1, 2025-11-25, 0d
    Demo 2                      :milestone, demo2, 2025-11-28, 0d
    Final Delivery              :milestone, final, 2025-12-09, 0d
    Thesis Delivery             :milestone, memoria, 2025-12-19, 0d
```

## 16. TO-DO List by Roles 👥

### 🎨 Frontend Developer
- [ ] **Initial Setup (Week 1-2)**
  - [ ] Configure Next.js 14 with App Router
  - [ ] Install and configure Tailwind CSS + shadcn/ui
  - [ ] Configure strict TypeScript
  - [ ] Setup ESLint + Prettier
  - [ ] Configure Feature-Slice directory structure

- [ ] **Authentication and Base UI (Week 3-4)**
  - [ ] Implement Auth.js with Supabase
  - [ ] Create login/registration components
  - [ ] Implement main layout with sidebar
  - [ ] Create navigation system
  - [ ] Implement light/dark theme

- [ ] **State Management (Week 5-6)**
  - [ ] Configure Zustand for global state (UI, modals, notifications)
  - [ ] Implement React Query for server state
  - [ ] Create stores for auth, workouts, social
  - [ ] Implement state persistence

- [ ] **Core Features (Week 7-10)**
  - [ ] Main dashboard with metrics
  - [ ] Workout CRUD (create, edit, delete)
  - [ ] Weekly/monthly calendar view
  - [ ] Calorie tracker with food search
  - [ ] Editable user profile

- [ ] **Social Features (Weeks 11-12)**
  - [ ] Post feed
  - [ ] Likes and comments system
  - [ ] User following
  - [ ] Real-time notifications
  - [ ] Content moderation

- [ ] **AI Integration (Weeks 13-14)**
  - [ ] Chat interface with AI
  - [ ] Recommendations component
  - [ ] Integration with Dify AI
  - [ ] Conversation history

- [ ] **Testing & Optimization (Weeks 15-16)**
  - [ ] Unit tests with Jest + RTL
  - [ ] E2E tests with Cypress
  - [ ] Performance optimization
  - [ ] Accessibility (WCAG AA)
  - [ ] Responsive design

### ⚙️ Backend Developer
- [ ] **Initial Setup (Weeks 1-2)**
  - [ ] Configure Hono + TypeScript
  - [ ] Supabase client setup
  - [ ] Configure module structure
  - [ ] Setup validation with Zod
  - [ ] Configure logging and error handling

- [ ] **Authentication & Security (Weeks 3-4)**
  - [ ] Implement auth middleware
  - [ ] Configure rate limiting
  - [ ] Input validation
  - [ ] Configure CORS and security headers
  - [ ] Setup JWT tokens

- [ ] **Core APIs (Weeks 5-8)**
  - [ ] CRUD for users and profiles
  - [ ] CRUD for workouts and logs
  - [ ] Nutrition and calorie tracking APIs
  - [ ] Calendar and schedule APIs
  - [ ] Implement pagination and filters

- [ ] **Social APIs (Weeks 9-10)**
  - [ ] CRUD for posts and comments
  - [ ] Likes and follows system
  - [ ] Feed with relevance algorithms
  - [ ] Push notifications
  - [ ] Moderation and reports

- [ ] **AI Integration (Weeks 11-12)**
  - [ ] Dify AI client
  - [ ] Context builder
  - [ ] Chat and recommendations APIs
  - [ ] AI response cache
  - [ ] AI usage metrics

- [ ] **Performance & Scalability (Weeks 13-14)**
  - [ ] Implement Redis cache (optional)
  - [ ] Optimize database queries
  - [ ] Implement WebSockets for real-time
  - [ ] Configure load balancing
  - [ ] Implement circuit breakers

- [ ] **Testing & Documentation (Weeks 15-16)**
  - [ ] Unit tests with Jest
  - [ ] Integration tests
  - [ ] OpenAPI documentation
  - [ ] Health checks and monitoring
  - [ ] Performance testing

### 🚀 DevOps/SRE Engineer
- [ ] **Base Infrastructure (Weeks 1-4)**
  - [ ] Kubernetes setup (kind/minikube)
  - [ ] ArgoCD setup for GitOps
  - [ ] GitHub Container Registry setup
  - [ ] Namespace and RBAC configuration
  - [ ] Secrets management setup

- [ ] **CI/CD Pipeline (Weeks 5-8)**
  - [ ] GitHub Actions for CI
  - [ ] Docker multi-stage builds
  - [ ] Automated pipeline testing
  - [ ] Security scanning with Snyk
  - [ ] Automated deployments

- [ ] **Monitoring & Observability (Weeks 9-12)**
  - [ ] Prometheus + Grafana setup
  - [ ] Loki + Promtail configuration
  - [ ] Business metrics dashboards
  - [ ] Alerts and notifications
  - [ ] Distributed tracing (optional)

- [ ] **Security & Compliance (Weeks 13-14)**
  - [ ] TLS/HTTPS with cert-manager
  - [ ] Network policies
  - [ ] Security scanning
  - [ ] Backup and disaster recovery
  - [ ] Compliance checks

- [ ] **Scalability & Performance (Weeks 15-16)**
  - [ ] Auto-scaling configuration
  - [ ] Load testing
  - [ ] Database optimization
  - [ ] CDN setup (optional)
  - [ ] Performance monitoring

### 🤖 AI/Integrations Developer
- [ ] **AI Platform Setup (Weeks 1-2)**
  - [ ] Setup Dify AI platform
  - [ ] Setup API keys and configs
  - [ ] Create basic workflows
  - [ ] Configure AI models
  - [ ] Setup context management

- [ ] **Chatbot Implementation (Weeks 3-6)**
  - [ ] Design fitness prompts
  - [ ] Implement context builder
  - [ ] Create conversation flows
  - [ ] Integrate with backend APIs
  - [ ] Implement session management

- [ ] **Recommendation Engine (Weeks 7-10)**
  - [ ] Design recommendation algorithms
  - [ ] Implement feature engineering
  - [ ] Create hybrid models
  - [ ] Integrate with user data
  - [ ] Implement feedback loop

- [ ] **n8n Workflows (Weeks 11-12)**
  - [ ] Telegram chatbot (optional)
  - [ ] Automatic reminders
  - [ ] Content moderation
  - [ ] Generate AI plans
  - [ ] Calorie tracking notifications

- [ ] **Testing & Optimization (Weeks 13-14)**
  - [ ] Prompt tests
  - [ ] Recommendation A/B testing
  - [ ] Satisfaction metrics
  - [ ] Cost optimization
  - [ ] Performance tuning

- [ ] **Production Ready (Weeks 15-16)**
  - [ ] AI monitoring
  - [ ] Robust error handling
  - [ ] AI rate limiting
  - [ ] Response cache
  - [ ] Full documentation

### 📋 Product/QA Engineer
- [ ] **Analysis & Planning (Weeks 1-2)**
  - [ ] Detailed requirements analysis
  - [ ] User stories and acceptance criteria
  - [ ] Complete test planning
  - [ ] Define KPIs and metrics
  - [ ] QA tooling setup

- [ ] **Testing Strategy (Weeks 3-6)**
  - [ ] Unit test plan
  - [ ] Integration test plan
  - [ ] E2E test plan
  - [ ] Testing environment setup
  - [ ] Automated testing

- [ ] **Quality Assurance (Weeks 7-12)**
  - [ ] Core feature testing
  - [ ] Social features testing
  - [ ] AI integration testing
  - [ ] Performance testing
  - [ ] Security testing

- [ ] **User Experience (Weeks 13-14)**
  - [ ] Usability testing
  - [ ] Accessibility testing
  - [ ] Responsive design testing
  - [ ] User feedback collection
  - [ ] UX improvements

- [ ] **Documentation & Release (Weeks 15-16)**
  - [ ] User documentation
  - [ ] Technical documentation
  - [ ] Release notes
  - [ ] Training materials
  - [ ] Final QA and sign-off

---

## 🎯 Weekly Objectives

### Week 1 (7-13 Oct)
- **Frontend**: Setup Next.js + TypeScript
- **Backend**: Setup Hono + Supabase
- **DevOps**: Local Kubernetes setup
- **AI**: Dify AI platform setup
- **QA**: Requirements analysis

### Week 2 (14-20 Oct)
- **Frontend**: Base UI components
- **Backend**: Auth middleware
- **DevOps**: ArgoCD setup
- **AI**: Basic workflows
- **QA**: Test planning

### Week 3 (21-27 Oct)
- **Frontend**: Complete Auth UI
- **Backend**: Basic core APIs
- **DevOps**: CI/CD pipeline
- **AI**: Basic chatbot
- **QA**: Testing environments

### Week 4 (28 Oct - 3 Nov)
- **Frontend**: Main dashboard
- **Backend**: Full CRUD
- **DevOps**: Monitoring setup
- **AI**: Recommendation engine
- **QA**: Automated tests

---



