# 📚 Complete API Endpoints Documentation

This document lists all available API endpoints in the GymPal backend, organized by category.

## Endpoint Summary

| Category | Endpoints | Description |
|-----------|-----------|-------------|
| 🔐 **Authentication** | 8 | Register, login, logout, refresh, profile, password management, account deletion |
| 👤 **Users** | 6 | Profile management, search, statistics, achievements |
| 💪 **Workouts** | 12 | Workout CRUD, exercises management, sessions, statistics |
| 🏋️ **Exercises** | 5 | Exercise catalog, categories, muscle groups, equipment |
| 📱 **Social** | 11 | Posts, likes, comments, reposts, follows, user interactions |
| 👤 **Personal** | 3 | Personal info, fitness profile management |
| 📊 **Dashboard** | 7 | Statistics, analytics, recent activity, leaderboard, calendar |
| 📅 **Calendar** | 3 | Calendar management, scheduled workouts |
| ⚙️ **Settings** | 9 | User preferences, notifications, privacy, account settings |
| 🤖 **AI** | 5 | Chat with agents, conversation management, history |

**Total: 69 endpoints**

---

## 🔐 Authentication Endpoints

### POST /api/v1/auth/register
Register a new user account.

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "securePassword123",
  "username": "fitness_user",
  "full_name": "John Doe"
}
```

### POST /api/v1/auth/login
Authenticate user and receive JWT tokens.

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "securePassword123"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": {
      "id": "uuid",
      "email": "user@example.com",
      "username": "fitness_user"
    }
  }
}
```

### GET /api/v1/auth/me
Get current authenticated user profile.

### POST /api/v1/auth/logout
Logout current user session.

### POST /api/v1/auth/refresh
Refresh access token using refresh token.

### POST /api/v1/auth/reset-password
Request password reset email.

### PUT /api/v1/auth/change-password/{id}
Change user password.

### DELETE /api/v1/auth/delete-account/{id}
Delete user account permanently.

---

## 👤 User Endpoints

### GET /api/v1/users/profile
Get current user profile.

### GET /api/v1/users/{id}
Get public user profile by ID.

### GET /api/v1/users/{id}/stats
Get user statistics.

### GET /api/v1/users/{id}/achievements
Get user achievements.

### GET /api/v1/users/search
Search users by username or name.

**Query Parameters:**
- `q` (string): Search query
- `page` (number): Page number
- `limit` (number): Results per page

### GET /api/v1/users/account
Get account information.

---

## 💪 Workout Endpoints

### GET /api/v1/workouts
List user workouts with pagination and filters.

**Query Parameters:**
- `page` (number): Page number
- `limit` (number): Items per page
- `type` (string): Workout type filter
- `difficulty` (string): Difficulty level filter
- `is_public` (boolean): Public workouts only

**Response:**
```json
{
  "success": true,
  "data": {
    "workouts": [
      {
        "id": "uuid",
        "name": "Strength Routine",
        "description": "Full body strength training",
        "type": "strength",
        "difficulty": "intermediate",
        "duration_minutes": 60,
        "exercises": [...],
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

### POST /api/v1/workouts
Create a new workout routine.

**Request Body:**
```json
{
  "name": "Strength Routine",
  "description": "Full body strength training",
  "type": "strength",
  "difficulty": "intermediate",
  "duration_minutes": 60,
  "exercises": [
    {
      "exercise_id": "uuid",
      "sets": 3,
      "reps": 10,
      "weight_kg": 50,
      "rest_seconds": 60,
      "order_index": 0
    }
  ]
}
```

### GET /api/v1/workouts/{id}
Get workout details by ID.

### PUT /api/v1/workouts/{id}
Update workout routine.

### DELETE /api/v1/workouts/{id}
Delete workout routine.

### GET /api/v1/workouts/{id}/exercises
Get exercises in a workout.

### POST /api/v1/workouts/{id}/exercises
Add exercise to workout.

### PUT /api/v1/workouts/{id}/exercises/{exerciseId}
Update exercise in workout.

### DELETE /api/v1/workouts/{id}/exercises/{exerciseId}
Remove exercise from workout.

### POST /api/v1/workouts/{id}/start
Start a workout session.

### POST /api/v1/workouts/{id}/complete
Complete a workout session.

### GET /api/v1/workouts/sessions
List workout sessions.

### GET /api/v1/workouts/sessions/{sessionId}
Get workout session details.

### GET /api/v1/workouts/users/{userId}/count
Get total workout count for user.

### GET /api/v1/workouts/users/{userId}/completed-count
Get completed workout count.

### GET /api/v1/workouts/users/{userId}/completed-exercises-count
Get completed exercises count.

### GET /api/v1/workouts/users/{userId}/streak
Get workout streak information.

---

## 🏋️ Exercise Endpoints

### GET /api/v1/exercises
List exercises with filters.

**Query Parameters:**
- `page` (number): Page number
- `limit` (number): Items per page
- `category` (string): Exercise category
- `muscleGroup` (string): Muscle group filter
- `equipment` (string): Equipment filter

### GET /api/v1/exercises/{id}
Get exercise details by ID.

### GET /api/v1/exercises/categories
Get all exercise categories.

### GET /api/v1/exercises/muscle-groups
Get all muscle groups.

### GET /api/v1/exercises/equipment
Get all equipment types.

---

## 📱 Social Endpoints

### GET /api/v1/social/posts
List posts with filters.

**Query Parameters:**
- `page` (number): Page number
- `limit` (number): Items per page
- `type` (string): Post type filter
- `user_id` (string): Filter by user
- `hashtags` (string): Filter by hashtags

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
          "full_name": "John Doe",
          "avatar_url": "https://example.com/avatar.jpg"
        },
        "content": "Just completed my first 100kg bench press! 💪",
        "post_type": "achievement",
        "image_urls": ["https://example.com/photo1.jpg"],
        "hashtags": ["#benchpress", "#achievement"],
        "likes_count": 25,
        "comments_count": 8,
        "reposts_count": 2,
        "is_original": true,
        "created_at": "2024-01-20T15:30:00Z"
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

### POST /api/v1/social/posts
Create a new post.

**Request Body:**
```json
{
  "content": "Just completed my first 100kg bench press! 💪",
  "post_type": "achievement",
  "image_urls": ["https://example.com/photo1.jpg"],
  "hashtags": ["#benchpress", "#achievement"],
  "workout_id": "uuid",
  "is_public": true
}
```

### GET /api/v1/social/posts/{id}
Get post details by ID.

### POST /api/v1/social/posts/{id}/like
Like or unlike a post.

### POST /api/v1/social/posts/{id}/repost
Repost a post.

**Request Body:**
```json
{
  "comment": "Awesome routine! I'm going to try it"
}
```

### GET /api/v1/social/posts/{id}/comments
Get comments for a post.

### POST /api/v1/social/posts/{id}/comments
Add comment to a post.

### PUT /api/v1/social/comments/{commentId}
Update a comment.

### DELETE /api/v1/social/comments/{commentId}
Delete a comment.

### POST /api/v1/social/users/{userId}/follow
Follow a user.

### POST /api/v1/social/users/{userId}/unfollow
Unfollow a user.

### GET /api/v1/social/users/{userId}/followers
Get user's followers list.

### GET /api/v1/social/users/{userId}/following
Get users that a user is following.

### GET /api/v1/social/users/{userId}/reposts
Get user's reposts.

---

## 👤 Personal Information Endpoints

### GET /api/v1/personal
Get complete personal information.

### GET /api/v1/personal/info
Get personal physical information (age, weight, height, BMI).

**Response:**
```json
{
  "success": true,
  "data": {
    "age": 25,
    "weight_kg": 75.5,
    "height_cm": 180,
    "bmi": 23.3,
    "body_fat_percentage": 15.2,
    "created_at": "2024-01-15T10:30:00Z",
    "updated_at": "2024-01-20T14:45:00Z"
  }
}
```

### PUT /api/v1/personal/info
Update personal physical information.

**Request Body:**
```json
{
  "age": 25,
  "weight_kg": 75.5,
  "height_cm": 180,
  "body_fat_percentage": 15.2
}
```

### GET /api/v1/personal/fitness
Get fitness profile (goals, experience level, preferences).

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

### PUT /api/v1/personal/fitness
Create or update fitness profile.

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

---

## 📊 Dashboard Endpoints

### GET /api/v1/dashboard
Get dashboard overview.

### GET /api/v1/dashboard/stats
Get user statistics summary.

**Response:**
```json
{
  "success": true,
  "data": {
    "total_workouts": 45,
    "total_exercises": 120,
    "total_sessions": 180,
    "current_streak": 7,
    "total_calories_burned": 125000
  }
}
```

### GET /api/v1/dashboard/recent-activity
Get recent user activity.

### GET /api/v1/dashboard/workout-progress
Get workout progress analytics.

### GET /api/v1/dashboard/analytics
Get detailed analytics data.

### GET /api/v1/dashboard/leaderboard
Get leaderboard rankings.

### GET /api/v1/dashboard/calendar
Get calendar view data.

---

## 📅 Calendar Endpoints

### GET /api/v1/calendar
Get calendar events.

### POST /api/v1/calendar/add-workout
Schedule a workout on calendar.

**Request Body:**
```json
{
  "workout_id": "uuid",
  "scheduled_date": "2024-01-25",
  "status": "scheduled"
}
```

### GET /api/v1/calendar/{id}
Get calendar event by ID.

### PUT /api/v1/calendar/{id}
Update calendar event.

### DELETE /api/v1/calendar/{id}
Delete calendar event.

---

## ⚙️ Settings Endpoints

### GET /api/v1/settings
Get all user settings.

### PUT /api/v1/settings
Update user settings.

### GET /api/v1/settings/preferences
Get user preferences.

### PUT /api/v1/settings/preferences
Update user preferences.

### GET /api/v1/settings/notifications
Get notification settings.

### PUT /api/v1/settings/notifications
Update notification settings.

### GET /api/v1/settings/privacy
Get privacy settings.

### PUT /api/v1/settings/privacy
Update privacy settings.

### GET /api/v1/settings/account
Get account settings.

### PUT /api/v1/settings/account
Update account settings.

### GET /api/v1/settings/fitness
Get fitness-related settings.

### PUT /api/v1/settings/fitness
Update fitness settings.

### GET /api/v1/settings/social
Get social settings.

### PUT /api/v1/settings/social
Update social settings.

### GET /api/v1/settings/activity-log
Get account activity log.

### POST /api/v1/settings/export-data
Export user data.

### POST /api/v1/settings/import-data
Import user data.

---

## 🤖 AI Endpoints

### POST /api/v1/ai/chat/agent
Chat with AI agent to generate workout routines.

**Request Body:**
```json
{
  "text": "I want to build muscle and I can train 4 days per week",
  "conversationId": "uuid"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "response": "Great! Let me help you create a muscle-building routine...",
    "conversationId": "uuid",
    "agentType": "reception"
  }
}
```

**Note:** The system uses sequential agent communication:
1. **Reception Agent**: Collects initial user information (goals, experience, preferences)
2. **Data Agent**: Collects routine-specific data (days, muscle groups, duration)
3. **Routine Agent**: Generates the complete workout routine from combined data

### GET /api/v1/ai/chat/history
Get chat history.

**Query Parameters:**
- `conversationId` (string, optional): Filter by conversation ID

### GET /api/v1/ai/chat/conversations
List all user conversations.

### POST /api/v1/ai/chat/conversations
Create a new conversation.

**Request Body:**
```json
{
  "title": "My Workout Plan"
}
```

### GET /api/v1/ai/chat/conversations/{id}
Get conversation details.

### PUT /api/v1/ai/chat/conversations/{id}
Rename conversation.

### DELETE /api/v1/ai/chat/conversations/{id}
Delete conversation.

---

## Authentication

All endpoints (except `/api/v1/auth/register` and `/api/v1/auth/login`) require authentication via Bearer token in the Authorization header:

```
Authorization: Bearer <access_token>
```

## Error Responses

All endpoints follow a consistent error response format:

```json
{
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "message": "Human-readable error message"
  }
}
```

Common HTTP status codes:
- `200`: Success
- `201`: Created
- `400`: Bad Request (validation error)
- `401`: Unauthorized (authentication required)
- `403`: Forbidden (insufficient permissions)
- `404`: Not Found
- `500`: Internal Server Error

## Rate Limiting

API requests are rate-limited to prevent abuse. Limits vary by endpoint:
- Authentication endpoints: 5 requests per minute
- General endpoints: 100 requests per minute
- AI endpoints: 10 requests per minute

## Base URL

- **Development**: `http://localhost:3000`
- **Production**: `https://api.gympal.app`

## OpenAPI Documentation

Interactive API documentation is available at:
- `/api/reference` - Scalar API Reference interface
