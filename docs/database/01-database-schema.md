# Database Schema Documentation

This document describes the complete database schema for GymPal, implemented in Supabase (PostgreSQL).

## Overview

The database uses PostgreSQL with the following key features:
- **Row Level Security (RLS)**: Security policies at the database level
- **UUID Primary Keys**: All tables use UUID for primary keys
- **Timestamps**: Automatic `created_at` and `updated_at` tracking
- **Foreign Keys**: Referential integrity with cascade deletes
- **Indexes**: Optimized for common query patterns
- **Triggers**: Automatic counter updates and timestamp management

## Schema Structure

### Core Tables

1. **profiles** - User profiles (references Supabase Auth)
2. **user_personal_info** - Physical information (age, weight, height, BMI)
3. **user_fitness_profile** - Fitness goals and preferences
4. **user_dietary_preferences** - Dietary restrictions and preferences
5. **user_stats** - Historical statistics tracking
6. **user_settings** - User configuration and preferences

### Workout & Exercise Tables

7. **exercises** - Exercise library
8. **workouts** - User-created workout routines
9. **workout_exercises** - Junction table (workouts ↔ exercises)
10. **workout_sessions** - Completed workout sessions
11. **exercise_set_logs** - Detailed set tracking
12. **scheduled_workouts** - Calendar scheduled workouts
13. **shared_workouts** - Shared workout routines

### Social Tables

14. **posts** - Social media posts
15. **post_likes** - Post likes
16. **post_comments** - Post comments (with threading)
17. **post_shares** - Post sharing
18. **post_reposts** - Post reposts
19. **follows** - User following relationships

---

## Complete Schema Definition

### profiles

Main user profile table. References `auth.users` from Supabase Auth.

```sql
CREATE TABLE profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    username VARCHAR(50) UNIQUE,
    full_name VARCHAR(100),
    avatar_url TEXT,
    bio TEXT,
    date_of_birth DATE,
    gender VARCHAR(20) CHECK (gender IN ('male', 'female', 'other', 'prefer_not_to_say')),
    fitness_level VARCHAR(20) DEFAULT 'beginner' 
        CHECK (fitness_level IN ('beginner', 'intermediate', 'advanced', 'expert')),
    timezone VARCHAR(50) DEFAULT 'UTC',
    language VARCHAR(10) DEFAULT 'en',
    is_active BOOLEAN DEFAULT true,
    preferences JSONB DEFAULT '{}',
    social_links JSONB DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

**Indexes:**
- `idx_profiles_username` on `username` (WHERE username IS NOT NULL)
- `idx_profiles_active` on `is_active` (WHERE is_active = true)
- `idx_profiles_fitness_level` on `fitness_level`

---

### user_personal_info

Detailed physical information for users.

```sql
CREATE TABLE user_personal_info (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    age INTEGER CHECK (age >= 13 AND age <= 120),
    weight_kg DECIMAL(5,2) CHECK (weight_kg > 0 AND weight_kg <= 500),
    height_cm INTEGER CHECK (height_cm > 0 AND height_cm <= 300),
    bmi DECIMAL(4,2) GENERATED ALWAYS AS (
        weight_kg / ((height_cm/100.0) * (height_cm/100.0))
    ) STORED,
    body_fat_percentage DECIMAL(4,2) 
        CHECK (body_fat_percentage >= 0 AND body_fat_percentage <= 100),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

**Indexes:**
- `idx_user_personal_info_user_id` on `user_id`
- `idx_user_personal_info_bmi` on `bmi`

---

### user_fitness_profile

Fitness goals, experience level, and workout preferences.

```sql
CREATE TABLE user_fitness_profile (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    experience_level VARCHAR(20) DEFAULT 'beginner' 
        CHECK (experience_level IN ('beginner', 'intermediate', 'advanced', 'expert')),
    primary_goal VARCHAR(50) NOT NULL,
    secondary_goals TEXT[] DEFAULT '{}',
    workout_frequency INTEGER 
        CHECK (workout_frequency >= 1 AND workout_frequency <= 7),
    preferred_workout_duration INTEGER 
        CHECK (preferred_workout_duration > 0 AND preferred_workout_duration <= 300),
    available_equipment TEXT[] DEFAULT '{}',
    workout_preferences JSONB DEFAULT '{}',
    injury_history TEXT[] DEFAULT '{}',
    medical_restrictions TEXT[] DEFAULT '{}',
    fitness_goals_timeline TEXT,
    motivation_level INTEGER 
        CHECK (motivation_level >= 1 AND motivation_level <= 10),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

**Indexes:**
- `idx_user_fitness_profile_user_id` on `user_id`
- `idx_user_fitness_profile_goal` on `primary_goal`

---

### user_dietary_preferences

Dietary restrictions, allergies, and nutritional goals.

```sql
CREATE TABLE user_dietary_preferences (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    dietary_restrictions TEXT[] DEFAULT '{}',
    allergies TEXT[] DEFAULT '{}',
    preferred_cuisines TEXT[] DEFAULT '{}',
    disliked_foods TEXT[] DEFAULT '{}',
    daily_calorie_target INTEGER 
        CHECK (daily_calorie_target > 0 AND daily_calorie_target <= 10000),
    protein_target_percentage DECIMAL(4,2) 
        CHECK (protein_target_percentage >= 0 AND protein_target_percentage <= 100),
    carb_target_percentage DECIMAL(4,2) 
        CHECK (carb_target_percentage >= 0 AND carb_target_percentage <= 100),
    fat_target_percentage DECIMAL(4,2) 
        CHECK (fat_target_percentage >= 0 AND fat_target_percentage <= 100),
    meal_preferences TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

**Indexes:**
- `idx_user_dietary_preferences_user_id` on `user_id`

---

### user_stats

Historical statistics tracking for users.

```sql
CREATE TABLE user_stats (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    height_cm DECIMAL(5,2) CHECK (height_cm > 0 AND height_cm <= 300),
    weight_kg DECIMAL(5,2) CHECK (weight_kg > 0 AND weight_kg <= 500),
    body_fat_percentage DECIMAL(4,2) 
        CHECK (body_fat_percentage >= 0 AND body_fat_percentage <= 100),
    target_weight_kg DECIMAL(5,2) 
        CHECK (target_weight_kg > 0 AND target_weight_kg <= 500),
    recorded_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

**Indexes:**
- `idx_user_stats_user_id` on `user_id`
- `idx_user_stats_recorded_at` on `recorded_at`

---

### exercises

Global exercise library.

```sql
CREATE TABLE exercises (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL,
    description TEXT,
    muscle_group VARCHAR(50) NOT NULL,
    muscle_groups TEXT[] DEFAULT '{}',
    equipment TEXT[] DEFAULT '{}',
    difficulty VARCHAR(20) 
        CHECK (difficulty IN ('beginner', 'intermediate', 'advanced', 'expert')),
    instructions TEXT,
    video_url TEXT,
    image_url TEXT,
    tags TEXT[] DEFAULT '{}',
    is_public BOOLEAN DEFAULT true,
    created_by UUID REFERENCES profiles(id) ON DELETE SET NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

**Indexes:**
- `idx_exercises_muscle_group` on `muscle_group`
- `idx_exercises_difficulty` on `difficulty`
- `idx_exercises_public` on `is_public` (WHERE is_public = true)
- `idx_exercises_created_by` on `created_by`

---

### workouts

User-created workout routines.

```sql
CREATE TABLE workouts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    type VARCHAR(50),
    difficulty VARCHAR(20) 
        CHECK (difficulty IN ('beginner', 'intermediate', 'advanced', 'expert')),
    duration_minutes INTEGER 
        CHECK (duration_minutes > 0 AND duration_minutes <= 300),
    is_template BOOLEAN DEFAULT false,
    is_public BOOLEAN DEFAULT false,
    is_shared BOOLEAN DEFAULT false,
    target_goal VARCHAR(100),
    target_level VARCHAR(20),
    days_per_week INTEGER CHECK (days_per_week >= 1 AND days_per_week <= 7),
    equipment_required TEXT[] DEFAULT '{}',
    user_notes TEXT,
    tags TEXT[] DEFAULT '{}',
    share_count INTEGER DEFAULT 0,
    like_count INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

**Indexes:**
- `idx_workouts_user_id` on `user_id`
- `idx_workouts_public` on `is_public` (WHERE is_public = true)
- `idx_workouts_difficulty` on `difficulty`
- `idx_workouts_type` on `type`

---

### workout_exercises

Junction table linking workouts to exercises with set/rep configuration.

```sql
CREATE TABLE workout_exercises (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    workout_id UUID NOT NULL REFERENCES workouts(id) ON DELETE CASCADE,
    exercise_id UUID NOT NULL REFERENCES exercises(id) ON DELETE CASCADE,
    order_index INTEGER NOT NULL DEFAULT 0,
    sets INTEGER CHECK (sets > 0 AND sets <= 50),
    reps INTEGER CHECK (reps > 0 AND reps <= 1000),
    weight_kg DECIMAL(5,2) CHECK (weight_kg >= 0 AND weight_kg <= 1000),
    rest_seconds INTEGER CHECK (rest_seconds >= 0 AND rest_seconds <= 600),
    notes TEXT
);
```

**Indexes:**
- `idx_workout_exercises_workout_id` on `workout_id`
- `idx_workout_exercises_exercise_id` on `exercise_id`
- `idx_workout_exercises_order` on `(workout_id, order_index)`

---

### workout_sessions

Completed workout session tracking.

```sql
CREATE TABLE workout_sessions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    workout_id UUID REFERENCES workouts(id) ON DELETE SET NULL,
    started_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    completed_at TIMESTAMP WITH TIME ZONE,
    duration_minutes INTEGER 
        CHECK (duration_minutes > 0 AND duration_minutes <= 300),
    calories_burned INTEGER 
        CHECK (calories_burned >= 0 AND calories_burned <= 10000),
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

**Indexes:**
- `idx_workout_sessions_user_id` on `user_id`
- `idx_workout_sessions_workout_id` on `workout_id`
- `idx_workout_sessions_started_at` on `started_at`

---

### exercise_set_logs

Detailed tracking of each set performed during workouts.

```sql
CREATE TABLE exercise_set_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    workout_session_id UUID REFERENCES workout_sessions(id) ON DELETE CASCADE,
    scheduled_workout_id UUID REFERENCES scheduled_workouts(id) ON DELETE CASCADE,
    exercise_id UUID NOT NULL REFERENCES exercises(id) ON DELETE CASCADE,
    set_number INTEGER NOT NULL CHECK (set_number > 0),
    weight_kg NUMERIC CHECK (weight_kg >= 0 AND weight_kg <= 1000),
    reps_completed INTEGER CHECK (reps_completed >= 0 AND reps_completed <= 1000),
    completed BOOLEAN DEFAULT true,
    rpe INTEGER CHECK (rpe >= 1 AND rpe <= 10),
    rir INTEGER CHECK (rir >= 0 AND rir <= 20),
    failure BOOLEAN DEFAULT false,
    rest_seconds INTEGER CHECK (rest_seconds >= 0 AND rest_seconds <= 3600),
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

**Indexes:**
- `idx_exercise_set_logs_workout_session_id` on `workout_session_id`
- `idx_exercise_set_logs_scheduled_workout_id` on `scheduled_workout_id`
- `idx_exercise_set_logs_exercise_id` on `exercise_id`
- `idx_exercise_set_logs_created_at` on `created_at`

---

### scheduled_workouts

Calendar entries for scheduled workouts.

```sql
CREATE TABLE scheduled_workouts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    workout_id UUID NOT NULL REFERENCES workouts(id) ON DELETE CASCADE,
    scheduled_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'scheduled' 
        CHECK (status IN ('scheduled', 'completed', 'cancelled')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

**Indexes:**
- `idx_scheduled_workouts_user_id` on `user_id`
- `idx_scheduled_workouts_date` on `scheduled_date`

---

### shared_workouts

Shared workout routines between users.

```sql
CREATE TABLE shared_workouts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    original_workout_id UUID NOT NULL REFERENCES workouts(id) ON DELETE CASCADE,
    shared_by_user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    shared_with_user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    shared_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    is_accepted BOOLEAN DEFAULT false,
    accepted_at TIMESTAMP WITH TIME ZONE
);
```

**Indexes:**
- `idx_shared_workouts_original` on `original_workout_id`
- `idx_shared_workouts_shared_by` on `shared_by_user_id`
- `idx_shared_workouts_shared_with` on `shared_with_user_id`

---

### posts

Social media posts.

```sql
CREATE TABLE posts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    post_type VARCHAR(20) DEFAULT 'general' 
        CHECK (post_type IN ('achievement', 'routine', 'tip', 'progress', 
                             'motivation', 'question', 'general')),
    workout_id UUID REFERENCES workouts(id) ON DELETE SET NULL,
    image_urls TEXT[] DEFAULT '{}',
    video_url TEXT,
    hashtags TEXT[] DEFAULT '{}',
    likes_count INTEGER DEFAULT 0,
    comments_count INTEGER DEFAULT 0,
    shares_count INTEGER DEFAULT 0,
    reposts_count INTEGER DEFAULT 0,
    is_public BOOLEAN DEFAULT true,
    is_original BOOLEAN DEFAULT true,
    original_post_id UUID REFERENCES posts(id) ON DELETE SET NULL,
    shared_from_user_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

**Indexes:**
- `idx_posts_user_id` on `user_id`
- `idx_posts_public` on `is_public` (WHERE is_public = true)
- `idx_posts_type` on `post_type`
- `idx_posts_created_at` on `created_at`
- `idx_posts_workout_id` on `workout_id` (WHERE workout_id IS NOT NULL)

---

### post_likes

Post likes tracking.

```sql
CREATE TABLE post_likes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    post_id UUID NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id, post_id)
);
```

**Indexes:**
- `idx_post_likes_user_id` on `user_id`
- `idx_post_likes_post_id` on `post_id`

---

### post_comments

Post comments with threading support.

```sql
CREATE TABLE post_comments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    post_id UUID NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    parent_comment_id UUID REFERENCES post_comments(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

**Indexes:**
- `idx_post_comments_user_id` on `user_id`
- `idx_post_comments_post_id` on `post_id`
- `idx_post_comments_parent` on `parent_comment_id` (WHERE parent_comment_id IS NOT NULL)

---

### post_shares

Post sharing tracking.

```sql
CREATE TABLE post_shares (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    post_id UUID NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
    shared_by_user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    shared_with_user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    share_type VARCHAR(20) DEFAULT 'share' 
        CHECK (share_type IN ('share', 'repost', 'forward')),
    shared_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

**Indexes:**
- `idx_post_shares_post_id` on `post_id`
- `idx_post_shares_shared_by` on `shared_by_user_id`
- `idx_post_shares_shared_with` on `shared_with_user_id` (WHERE shared_with_user_id IS NOT NULL)

---

### post_reposts

Post reposts tracking.

```sql
CREATE TABLE post_reposts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    original_post_id UUID NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
    reposted_by_user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    reposted_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(original_post_id, reposted_by_user_id)
);
```

**Indexes:**
- `idx_post_reposts_original` on `original_post_id`
- `idx_post_reposts_reposted_by` on `reposted_by_user_id`

---

### follows

User following relationships.

```sql
CREATE TABLE follows (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    follower_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    following_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(follower_id, following_id),
    CHECK(follower_id != following_id)
);
```

**Indexes:**
- `idx_follows_follower` on `follower_id`
- `idx_follows_following` on `following_id`

---

### user_settings

User configuration and preferences.

```sql
CREATE TABLE user_settings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    email_notifications BOOLEAN DEFAULT true,
    push_notifications BOOLEAN DEFAULT true,
    workout_reminders BOOLEAN DEFAULT true,
    timezone VARCHAR(50) DEFAULT 'UTC',
    language VARCHAR(10) DEFAULT 'en',
    theme VARCHAR(20) DEFAULT 'light' 
        CHECK (theme IN ('light', 'dark', 'auto')),
    profile_visibility BOOLEAN DEFAULT true,
    workout_visibility BOOLEAN DEFAULT true,
    progress_visibility BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id)
);
```

**Indexes:**
- `idx_user_settings_user_id` on `user_id`

---

## Triggers and Functions

### Automatic Timestamp Updates

All tables with `updated_at` columns have triggers that automatically update the timestamp:

```sql
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';
```

### Post Counter Updates

Automatic counter updates for posts:

```sql
CREATE OR REPLACE FUNCTION update_post_likes_count()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE posts SET likes_count = likes_count + 1 WHERE id = NEW.post_id;
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE posts SET likes_count = GREATEST(likes_count - 1, 0) WHERE id = OLD.post_id;
        RETURN OLD;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_post_likes_count_trigger
    AFTER INSERT OR DELETE ON post_likes
    FOR EACH ROW EXECUTE FUNCTION update_post_likes_count();
```

Similar triggers exist for `comments_count` on posts.

---

## Row Level Security (RLS)

All tables have RLS policies enabled. Key policies:

### Profiles
- Users can read public profiles and their own profile
- Users can only update their own profile

### Workouts
- Users can read public workouts and their own workouts
- Users can only create/update/delete their own workouts

### Posts
- Users can read public posts
- Users can only create/update/delete their own posts

### Follows
- Users can read their own follow relationships
- Users can only create/delete their own follow relationships

---

## Entity Relationship Diagram

See the main documentation for complete ER diagrams showing all relationships between tables.

---

## Migration Files

The schema is managed through Supabase migrations:
- `001_schema.sql` - Complete initial schema
- Additional migrations for schema updates

---

## Notes

- All UUIDs use `uuid_generate_v4()` or `gen_random_uuid()`
- All timestamps use `TIMESTAMP WITH TIME ZONE`
- JSONB columns are used for flexible data storage (preferences, social_links, etc.)
- Array columns (TEXT[]) are used for tags, equipment, goals, etc.
- Generated columns (like BMI) are computed automatically
- Cascade deletes ensure data integrity when users are deleted
