# Database Entity-Relationship Diagrams

## Table of Contents

1. [High-Level ERD](#high-level-erd)
2. [User Management ERD](#user-management-erd)
3. [Workout Management ERD](#workout-management-erd)
4. [Social Features ERD](#social-features-erd)
5. [AI Integration ERD](#ai-integration-erd)
6. [Blockchain Integration ERD](#blockchain-integration-erd)
7. [Notification System ERD](#notification-system-erd)
8. [Complete System ERD](#complete-system-erd)

---

## High-Level ERD

### Core Entities and Relationships

```mermaid
erDiagram
    USERS {
        uuid id PK
        string email UK
        string first_name
        string last_name
        string role
        string avatar_url
        text bio
        string location
        date date_of_birth
        string gender
        jsonb fitness_goals
        string activity_level
        boolean is_active
        timestamp last_login_at
        timestamp created_at
        timestamp updated_at
    }

    WORKOUTS {
        uuid id PK
        uuid user_id FK
        string name
        text description
        string type
        string difficulty
        integer duration_minutes
        integer calories_burned
        boolean is_template
        boolean is_public
        jsonb tags
        timestamp created_at
        timestamp updated_at
    }

    EXERCISES {
        uuid id PK
        string name
        text description
        string category
        jsonb muscle_groups
        string equipment
        string difficulty
        string video_url
        jsonb instructions
        boolean is_active
        timestamp created_at
        timestamp updated_at
    }

    SOCIAL_POSTS {
        uuid id PK
        uuid user_id FK
        text content
        string type
        jsonb media_urls
        uuid workout_id FK
        integer likes_count
        integer comments_count
        integer shares_count
        boolean is_public
        timestamp created_at
        timestamp updated_at
    }

    AI_CHAT_SESSIONS {
        uuid id PK
        uuid user_id FK
        string session_name
        jsonb context
        timestamp created_at
        timestamp updated_at
    }

    NFTS {
        uuid id PK
        uuid user_id FK
        string token_id
        string contract_address
        string name
        text description
        string image_url
        string rarity
        jsonb attributes
        timestamp created_at
    }

    NOTIFICATIONS {
        uuid id PK
        uuid user_id FK
        string type
        string title
        text message
        jsonb data
        boolean is_read
        timestamp read_at
        timestamp created_at
    }

    USERS ||--o{ WORKOUTS : creates
    USERS ||--o{ SOCIAL_POSTS : posts
    USERS ||--o{ AI_CHAT_SESSIONS : has
    USERS ||--o{ NFTS : owns
    USERS ||--o{ NOTIFICATIONS : receives
    WORKOUTS ||--o{ SOCIAL_POSTS : featured_in
```

---

## User Management ERD

### User Profile and Authentication

```mermaid
erDiagram
    USERS {
        uuid id PK
        string email UK
        string first_name
        string last_name
        string role
        string avatar_url
        text bio
        string location
        date date_of_birth
        string gender
        jsonb fitness_goals
        string activity_level
        boolean is_active
        timestamp last_login_at
        timestamp created_at
        timestamp updated_at
    }

    USER_PROFILES {
        uuid id PK
        uuid user_id FK
        decimal height_cm
        decimal weight_kg
        decimal body_fat_percentage
        jsonb measurements
        jsonb preferences
        timestamp created_at
        timestamp updated_at
    }

    USER_FOLLOWERS {
        uuid id PK
        uuid follower_id FK
        uuid following_id FK
        timestamp created_at
    }

    USER_STATS {
        uuid id PK
        uuid user_id FK
        string metric_name
        decimal value
        string unit
        date recorded_date
        timestamp created_at
    }

    ACHIEVEMENTS {
        uuid id PK
        uuid user_id FK
        string type
        string title
        text description
        string icon_url
        jsonb criteria
        timestamp earned_at
    }

    USERS ||--|| USER_PROFILES : has
    USERS ||--o{ USER_FOLLOWERS : follows
    USERS ||--o{ USER_FOLLOWERS : followed_by
    USERS ||--o{ USER_STATS : has
    USERS ||--o{ ACHIEVEMENTS : earns
```

---

## Workout Management ERD

### Workout and Exercise System

```mermaid
erDiagram
    WORKOUTS {
        uuid id PK
        uuid user_id FK
        string name
        text description
        string type
        string difficulty
        integer duration_minutes
        integer calories_burned
        boolean is_template
        boolean is_public
        jsonb tags
        timestamp created_at
        timestamp updated_at
    }

    EXERCISES {
        uuid id PK
        string name
        text description
        string category
        jsonb muscle_groups
        string equipment
        string difficulty
        string video_url
        jsonb instructions
        boolean is_active
        timestamp created_at
        timestamp updated_at
    }

    WORKOUT_EXERCISES {
        uuid id PK
        uuid workout_id FK
        uuid exercise_id FK
        integer order_index
        integer sets
        integer reps
        decimal weight
        integer duration_seconds
        integer rest_seconds
        text notes
        timestamp created_at
    }

    WORKOUT_SESSIONS {
        uuid id PK
        uuid user_id FK
        uuid workout_id FK
        timestamp started_at
        timestamp completed_at
        integer duration_minutes
        integer calories_burned
        jsonb performance_data
        timestamp created_at
    }

    EXERCISE_SETS {
        uuid id PK
        uuid workout_session_id FK
        uuid exercise_id FK
        integer set_number
        integer reps
        decimal weight
        integer duration_seconds
        text notes
        timestamp created_at
    }

    WORKOUTS ||--o{ WORKOUT_EXERCISES : contains
    EXERCISES ||--o{ WORKOUT_EXERCISES : included_in
    WORKOUTS ||--o{ WORKOUT_SESSIONS : executed_as
    WORKOUT_SESSIONS ||--o{ EXERCISE_SETS : contains
    EXERCISES ||--o{ EXERCISE_SETS : performed_in
```

---

## Social Features ERD

### Social Networking and Interactions

```mermaid
erDiagram
    SOCIAL_POSTS {
        uuid id PK
        uuid user_id FK
        text content
        string type
        jsonb media_urls
        uuid workout_id FK
        integer likes_count
        integer comments_count
        integer shares_count
        boolean is_public
        timestamp created_at
        timestamp updated_at
    }

    LIKES {
        uuid id PK
        uuid user_id FK
        uuid post_id FK
        timestamp created_at
    }

    COMMENTS {
        uuid id PK
        uuid user_id FK
        uuid post_id FK
        text content
        uuid parent_comment_id FK
        timestamp created_at
        timestamp updated_at
    }

    SHARES {
        uuid id PK
        uuid user_id FK
        uuid post_id FK
        text message
        timestamp created_at
    }

    USER_FOLLOWERS {
        uuid id PK
        uuid follower_id FK
        uuid following_id FK
        timestamp created_at
    }

    SOCIAL_POSTS ||--o{ LIKES : receives
    SOCIAL_POSTS ||--o{ COMMENTS : has
    SOCIAL_POSTS ||--o{ SHARES : shared_as
    COMMENTS ||--o{ COMMENTS : replies_to
    USER_FOLLOWERS ||--o{ SOCIAL_POSTS : sees
```

---

## AI Integration ERD

### AI Chat and Recommendations

```mermaid
erDiagram
    AI_CHAT_SESSIONS {
        uuid id PK
        uuid user_id FK
        string session_name
        jsonb context
        timestamp created_at
        timestamp updated_at
    }

    AI_MESSAGES {
        uuid id PK
        uuid session_id FK
        string role
        text content
        jsonb metadata
        timestamp created_at
    }

    RECOMMENDATIONS {
        uuid id PK
        uuid user_id FK
        string type
        string title
        text description
        decimal confidence_score
        jsonb data
        timestamp created_at
    }

    AI_MODELS {
        uuid id PK
        string name
        string version
        string type
        jsonb configuration
        boolean is_active
        timestamp created_at
        timestamp updated_at
    }

    AI_PREDICTIONS {
        uuid id PK
        uuid user_id FK
        uuid model_id FK
        string prediction_type
        jsonb input_data
        jsonb output_data
        decimal confidence
        timestamp created_at
    }

    AI_CHAT_SESSIONS ||--o{ AI_MESSAGES : contains
    AI_MODELS ||--o{ AI_PREDICTIONS : generates
    USERS ||--o{ AI_PREDICTIONS : receives
```

---

## Blockchain Integration ERD

### NFT and Blockchain Features

```mermaid
erDiagram
    NFTS {
        uuid id PK
        uuid user_id FK
        string token_id
        string contract_address
        string name
        text description
        string image_url
        string rarity
        jsonb attributes
        timestamp created_at
    }

    BLOCKCHAIN_TRANSACTIONS {
        uuid id PK
        uuid user_id FK
        string transaction_hash
        string contract_address
        string function_name
        jsonb parameters
        string status
        decimal gas_used
        decimal gas_price
        timestamp created_at
        timestamp confirmed_at
    }

    SMART_CONTRACTS {
        uuid id PK
        string contract_address
        string name
        string version
        jsonb abi
        string network
        boolean is_active
        timestamp deployed_at
        timestamp updated_at
    }

    NFT_COLLECTIONS {
        uuid id PK
        string name
        text description
        string image_url
        string contract_address
        integer total_supply
        integer minted_count
        string creator_id
        timestamp created_at
    }

    NFT_MINTS {
        uuid id PK
        uuid user_id FK
        uuid collection_id FK
        uuid nft_id FK
        string transaction_hash
        decimal mint_price
        timestamp minted_at
    }

    NFTS ||--o{ BLOCKCHAIN_TRANSACTIONS : created_by
    SMART_CONTRACTS ||--o{ BLOCKCHAIN_TRANSACTIONS : executed_on
    NFT_COLLECTIONS ||--o{ NFTS : contains
    NFT_COLLECTIONS ||--o{ NFT_MINTS : minted_from
    USERS ||--o{ NFT_MINTS : performs
```

---

## Notification System ERD

### Notification Management

```mermaid
erDiagram
    NOTIFICATIONS {
        uuid id PK
        uuid user_id FK
        string type
        string title
        text message
        jsonb data
        boolean is_read
        timestamp read_at
        timestamp created_at
    }

    NOTIFICATION_TEMPLATES {
        uuid id PK
        string type
        string title_template
        text message_template
        jsonb variables
        boolean is_active
        timestamp created_at
        timestamp updated_at
    }

    NOTIFICATION_PREFERENCES {
        uuid id PK
        uuid user_id FK
        string notification_type
        boolean email_enabled
        boolean push_enabled
        boolean sms_enabled
        jsonb timing_preferences
        timestamp created_at
        timestamp updated_at
    }

    NOTIFICATION_QUEUE {
        uuid id PK
        uuid user_id FK
        string type
        string channel
        jsonb payload
        string status
        integer retry_count
        timestamp scheduled_at
        timestamp processed_at
        timestamp created_at
    }

    NOTIFICATIONS ||--o{ NOTIFICATION_TEMPLATES : uses
    USERS ||--o{ NOTIFICATION_PREFERENCES : has
    USERS ||--o{ NOTIFICATION_QUEUE : queued_for
```

---

## Complete System ERD

### Full Database Schema Overview

```mermaid
erDiagram
    %% Core User Management
    USERS {
        uuid id PK
        string email UK
        string first_name
        string last_name
        string role
        string avatar_url
        text bio
        string location
        date date_of_birth
        string gender
        jsonb fitness_goals
        string activity_level
        boolean is_active
        timestamp last_login_at
        timestamp created_at
        timestamp updated_at
    }

    USER_PROFILES {
        uuid id PK
        uuid user_id FK
        decimal height_cm
        decimal weight_kg
        decimal body_fat_percentage
        jsonb measurements
        jsonb preferences
        timestamp created_at
        timestamp updated_at
    }

    %% Workout Management
    WORKOUTS {
        uuid id PK
        uuid user_id FK
        string name
        text description
        string type
        string difficulty
        integer duration_minutes
        integer calories_burned
        boolean is_template
        boolean is_public
        jsonb tags
        timestamp created_at
        timestamp updated_at
    }

    EXERCISES {
        uuid id PK
        string name
        text description
        string category
        jsonb muscle_groups
        string equipment
        string difficulty
        string video_url
        jsonb instructions
        boolean is_active
        timestamp created_at
        timestamp updated_at
    }

    WORKOUT_EXERCISES {
        uuid id PK
        uuid workout_id FK
        uuid exercise_id FK
        integer order_index
        integer sets
        integer reps
        decimal weight
        integer duration_seconds
        integer rest_seconds
        text notes
        timestamp created_at
    }

    %% Social Features
    SOCIAL_POSTS {
        uuid id PK
        uuid user_id FK
        text content
        string type
        jsonb media_urls
        uuid workout_id FK
        integer likes_count
        integer comments_count
        integer shares_count
        boolean is_public
        timestamp created_at
        timestamp updated_at
    }

    USER_FOLLOWERS {
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

    COMMENTS {
        uuid id PK
        uuid user_id FK
        uuid post_id FK
        text content
        uuid parent_comment_id FK
        timestamp created_at
        timestamp updated_at
    }

    %% AI Integration
    AI_CHAT_SESSIONS {
        uuid id PK
        uuid user_id FK
        string session_name
        jsonb context
        timestamp created_at
        timestamp updated_at
    }

    AI_MESSAGES {
        uuid id PK
        uuid session_id FK
        string role
        text content
        jsonb metadata
        timestamp created_at
    }

    RECOMMENDATIONS {
        uuid id PK
        uuid user_id FK
        string type
        string title
        text description
        decimal confidence_score
        jsonb data
        timestamp created_at
    }

    %% Blockchain Integration
    NFTS {
        uuid id PK
        uuid user_id FK
        string token_id
        string contract_address
        string name
        text description
        string image_url
        string rarity
        jsonb attributes
        timestamp created_at
    }

    ACHIEVEMENTS {
        uuid id PK
        uuid user_id FK
        string type
        string title
        text description
        string icon_url
        jsonb criteria
        timestamp earned_at
    }

    %% Notifications
    NOTIFICATIONS {
        uuid id PK
        uuid user_id FK
        string type
        string title
        text message
        jsonb data
        boolean is_read
        timestamp read_at
        timestamp created_at
    }

    %% Relationships
    USERS ||--|| USER_PROFILES : has
    USERS ||--o{ WORKOUTS : creates
    USERS ||--o{ SOCIAL_POSTS : posts
    USERS ||--o{ AI_CHAT_SESSIONS : has
    USERS ||--o{ RECOMMENDATIONS : receives
    USERS ||--o{ NFTS : owns
    USERS ||--o{ ACHIEVEMENTS : earns
    USERS ||--o{ NOTIFICATIONS : receives
    USERS ||--o{ USER_FOLLOWERS : follows
    USERS ||--o{ USER_FOLLOWERS : followed_by
    USERS ||--o{ LIKES : likes
    USERS ||--o{ COMMENTS : comments

    WORKOUTS ||--o{ WORKOUT_EXERCISES : contains
    EXERCISES ||--o{ WORKOUT_EXERCISES : included_in
    WORKOUTS ||--o{ SOCIAL_POSTS : featured_in

    SOCIAL_POSTS ||--o{ LIKES : receives
    SOCIAL_POSTS ||--o{ COMMENTS : has
    COMMENTS ||--o{ COMMENTS : replies_to

    AI_CHAT_SESSIONS ||--o{ AI_MESSAGES : contains
```

---

## Database Schema Summary

### Table Count by Domain

| Domain | Tables | Description |
|--------|--------|-------------|
| **User Management** | 4 | Users, profiles, followers, stats |
| **Workout Management** | 4 | Workouts, exercises, sessions, sets |
| **Social Features** | 4 | Posts, likes, comments, shares |
| **AI Integration** | 3 | Chat sessions, messages, recommendations |
| **Blockchain** | 2 | NFTs, achievements |
| **Notifications** | 1 | Notification system |
| **Total** | **18** | Complete database schema |

### Key Relationships

1. **One-to-One**: Users ↔ User Profiles
2. **One-to-Many**: Users → Workouts, Posts, Sessions, etc.
3. **Many-to-Many**: Users ↔ Users (followers), Workouts ↔ Exercises
4. **Self-Referencing**: Comments → Comments (replies)
