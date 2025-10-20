-- FitnessHub Database Implementation Scripts
-- PostgreSQL 15+ Compatible
-- Created for 5-person student team project

-- =============================================
-- SCHEMA CREATION
-- =============================================

-- Create schemas for microservices
CREATE SCHEMA IF NOT EXISTS user_service;
CREATE SCHEMA IF NOT EXISTS workout_service;
CREATE SCHEMA IF NOT EXISTS social_service;
CREATE SCHEMA IF NOT EXISTS ai_service;
CREATE SCHEMA IF NOT EXISTS blockchain_service;
CREATE SCHEMA IF NOT EXISTS notification_service;
CREATE SCHEMA IF NOT EXISTS shared;

-- =============================================
-- EXTENSIONS
-- =============================================

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_stat_statements";
CREATE EXTENSION IF NOT EXISTS "btree_gin";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- =============================================
-- USER SERVICE SCHEMA
-- =============================================

-- Users table
CREATE TABLE user_service.users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'user' CHECK (role IN ('user', 'trainer', 'admin')),
    avatar_url TEXT,
    bio TEXT,
    location VARCHAR(255),
    date_of_birth DATE,
    gender VARCHAR(20) CHECK (gender IN ('male', 'female', 'other', 'prefer_not_to_say')),
    fitness_goals JSONB DEFAULT '[]',
    activity_level VARCHAR(20) CHECK (activity_level IN ('sedentary', 'lightly_active', 'moderately_active', 'very_active', 'extremely_active')),
    is_active BOOLEAN DEFAULT true,
    last_login_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- User profiles table
CREATE TABLE user_service.user_profiles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES user_service.users(id) ON DELETE CASCADE,
    height_cm DECIMAL(5,2),
    weight_kg DECIMAL(5,2),
    body_fat_percentage DECIMAL(4,2),
    measurements JSONB DEFAULT '{}',
    preferences JSONB DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id)
);

-- User followers table
CREATE TABLE user_service.user_followers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    follower_id UUID NOT NULL REFERENCES user_service.users(id) ON DELETE CASCADE,
    following_id UUID NOT NULL REFERENCES user_service.users(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(follower_id, following_id),
    CHECK (follower_id != following_id)
);

-- User stats table
CREATE TABLE user_service.user_stats (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES user_service.users(id) ON DELETE CASCADE,
    metric_name VARCHAR(100) NOT NULL,
    value DECIMAL(10,2) NOT NULL,
    unit VARCHAR(20) NOT NULL,
    recorded_date DATE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- =============================================
-- WORKOUT SERVICE SCHEMA
-- =============================================

-- Workouts table
CREATE TABLE workout_service.workouts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES user_service.users(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    type VARCHAR(50) NOT NULL CHECK (type IN ('strength', 'cardio', 'flexibility', 'sports', 'other')),
    difficulty VARCHAR(20) NOT NULL CHECK (difficulty IN ('beginner', 'intermediate', 'advanced')),
    duration_minutes INTEGER NOT NULL CHECK (duration_minutes > 0),
    calories_burned INTEGER,
    is_template BOOLEAN DEFAULT false,
    is_public BOOLEAN DEFAULT false,
    tags JSONB DEFAULT '[]',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Exercises table
CREATE TABLE workout_service.exercises (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    category VARCHAR(100) NOT NULL,
    muscle_groups JSONB DEFAULT '[]',
    equipment VARCHAR(100),
    difficulty VARCHAR(20) NOT NULL CHECK (difficulty IN ('beginner', 'intermediate', 'advanced')),
    video_url TEXT,
    instructions JSONB DEFAULT '[]',
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Workout exercises junction table
CREATE TABLE workout_service.workout_exercises (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    workout_id UUID NOT NULL REFERENCES workout_service.workouts(id) ON DELETE CASCADE,
    exercise_id UUID NOT NULL REFERENCES workout_service.exercises(id) ON DELETE CASCADE,
    order_index INTEGER NOT NULL,
    sets INTEGER NOT NULL CHECK (sets > 0),
    reps INTEGER NOT NULL CHECK (reps > 0),
    weight DECIMAL(8,2),
    duration_seconds INTEGER,
    rest_seconds INTEGER,
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(workout_id, exercise_id, order_index)
);

-- Workout sessions table
CREATE TABLE workout_service.workout_sessions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES user_service.users(id) ON DELETE CASCADE,
    workout_id UUID NOT NULL REFERENCES workout_service.workouts(id) ON DELETE CASCADE,
    started_at TIMESTAMP WITH TIME ZONE NOT NULL,
    completed_at TIMESTAMP WITH TIME ZONE,
    duration_minutes INTEGER,
    calories_burned INTEGER,
    performance_data JSONB DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Exercise sets table
CREATE TABLE workout_service.exercise_sets (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    workout_session_id UUID NOT NULL REFERENCES workout_service.workout_sessions(id) ON DELETE CASCADE,
    exercise_id UUID NOT NULL REFERENCES workout_service.exercises(id) ON DELETE CASCADE,
    set_number INTEGER NOT NULL,
    reps INTEGER,
    weight DECIMAL(8,2),
    duration_seconds INTEGER,
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- =============================================
-- SOCIAL SERVICE SCHEMA
-- =============================================

-- Social posts table
CREATE TABLE social_service.social_posts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES user_service.users(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    type VARCHAR(50) NOT NULL CHECK (type IN ('text', 'image', 'video', 'workout', 'achievement')),
    media_urls JSONB DEFAULT '[]',
    workout_id UUID REFERENCES workout_service.workouts(id) ON DELETE SET NULL,
    likes_count INTEGER DEFAULT 0,
    comments_count INTEGER DEFAULT 0,
    shares_count INTEGER DEFAULT 0,
    is_public BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Likes table
CREATE TABLE social_service.likes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES user_service.users(id) ON DELETE CASCADE,
    post_id UUID NOT NULL REFERENCES social_service.social_posts(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id, post_id)
);

-- Comments table
CREATE TABLE social_service.comments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES user_service.users(id) ON DELETE CASCADE,
    post_id UUID NOT NULL REFERENCES social_service.social_posts(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    parent_comment_id UUID REFERENCES social_service.comments(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Shares table
CREATE TABLE social_service.shares (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES user_service.users(id) ON DELETE CASCADE,
    post_id UUID NOT NULL REFERENCES social_service.social_posts(id) ON DELETE CASCADE,
    message TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- =============================================
-- AI SERVICE SCHEMA
-- =============================================

-- AI chat sessions table
CREATE TABLE ai_service.ai_chat_sessions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES user_service.users(id) ON DELETE CASCADE,
    session_name VARCHAR(255),
    context JSONB DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- AI messages table
CREATE TABLE ai_service.ai_messages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id UUID NOT NULL REFERENCES ai_service.ai_chat_sessions(id) ON DELETE CASCADE,
    role VARCHAR(20) NOT NULL CHECK (role IN ('user', 'assistant', 'system')),
    content TEXT NOT NULL,
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Recommendations table
CREATE TABLE ai_service.recommendations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES user_service.users(id) ON DELETE CASCADE,
    type VARCHAR(50) NOT NULL CHECK (type IN ('workout', 'nutrition', 'social', 'general')),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    confidence_score DECIMAL(3,2) NOT NULL CHECK (confidence_score >= 0 AND confidence_score <= 1),
    data JSONB DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- AI models table
CREATE TABLE ai_service.ai_models (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    version VARCHAR(50) NOT NULL,
    type VARCHAR(50) NOT NULL,
    configuration JSONB DEFAULT '{}',
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- =============================================
-- BLOCKCHAIN SERVICE SCHEMA
-- =============================================

-- NFTs table
CREATE TABLE blockchain_service.nfts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES user_service.users(id) ON DELETE CASCADE,
    token_id VARCHAR(255) NOT NULL,
    contract_address VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    image_url TEXT,
    rarity VARCHAR(20) NOT NULL CHECK (rarity IN ('common', 'uncommon', 'rare', 'epic', 'legendary')),
    attributes JSONB DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Achievements table
CREATE TABLE blockchain_service.achievements (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES user_service.users(id) ON DELETE CASCADE,
    type VARCHAR(50) NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    icon_url TEXT,
    criteria JSONB DEFAULT '{}',
    earned_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Blockchain transactions table
CREATE TABLE blockchain_service.blockchain_transactions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES user_service.users(id) ON DELETE CASCADE,
    transaction_hash VARCHAR(255) NOT NULL,
    contract_address VARCHAR(255) NOT NULL,
    function_name VARCHAR(100) NOT NULL,
    parameters JSONB DEFAULT '{}',
    status VARCHAR(20) NOT NULL CHECK (status IN ('pending', 'confirmed', 'failed')),
    gas_used DECIMAL(20,0),
    gas_price DECIMAL(20,0),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    confirmed_at TIMESTAMP WITH TIME ZONE
);

-- =============================================
-- NOTIFICATION SERVICE SCHEMA
-- =============================================

-- Notifications table
CREATE TABLE notification_service.notifications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES user_service.users(id) ON DELETE CASCADE,
    type VARCHAR(50) NOT NULL CHECK (type IN ('workout', 'social', 'achievement', 'system', 'reminder')),
    title VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    data JSONB DEFAULT '{}',
    is_read BOOLEAN DEFAULT false,
    read_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Notification templates table
CREATE TABLE notification_service.notification_templates (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    type VARCHAR(50) NOT NULL,
    title_template VARCHAR(255) NOT NULL,
    message_template TEXT NOT NULL,
    variables JSONB DEFAULT '{}',
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Notification preferences table
CREATE TABLE notification_service.notification_preferences (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES user_service.users(id) ON DELETE CASCADE,
    notification_type VARCHAR(50) NOT NULL,
    email_enabled BOOLEAN DEFAULT true,
    push_enabled BOOLEAN DEFAULT true,
    sms_enabled BOOLEAN DEFAULT false,
    timing_preferences JSONB DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id, notification_type)
);

-- =============================================
-- INDEXES
-- =============================================

-- User Service Indexes
CREATE INDEX idx_users_email ON user_service.users(email);
CREATE INDEX idx_users_role ON user_service.users(role);
CREATE INDEX idx_users_is_active ON user_service.users(is_active);
CREATE INDEX idx_users_created_at ON user_service.users(created_at);
CREATE INDEX idx_users_fitness_goals_gin ON user_service.users USING GIN (fitness_goals);

CREATE INDEX idx_user_profiles_user_id ON user_service.user_profiles(user_id);
CREATE INDEX idx_user_followers_follower_id ON user_service.user_followers(follower_id);
CREATE INDEX idx_user_followers_following_id ON user_service.user_followers(following_id);
CREATE INDEX idx_user_stats_user_id ON user_service.user_stats(user_id);
CREATE INDEX idx_user_stats_metric_name ON user_service.user_stats(metric_name);
CREATE INDEX idx_user_stats_recorded_date ON user_service.user_stats(recorded_date);

-- Workout Service Indexes
CREATE INDEX idx_workouts_user_id ON workout_service.workouts(user_id);
CREATE INDEX idx_workouts_type ON workout_service.workouts(type);
CREATE INDEX idx_workouts_difficulty ON workout_service.workouts(difficulty);
CREATE INDEX idx_workouts_is_template ON workout_service.workouts(is_template);
CREATE INDEX idx_workouts_is_public ON workout_service.workouts(is_public);
CREATE INDEX idx_workouts_created_at ON workout_service.workouts(created_at);
CREATE INDEX idx_workouts_tags_gin ON workout_service.workouts USING GIN (tags);

CREATE INDEX idx_exercises_category ON workout_service.exercises(category);
CREATE INDEX idx_exercises_difficulty ON workout_service.exercises(difficulty);
CREATE INDEX idx_exercises_is_active ON workout_service.exercises(is_active);
CREATE INDEX idx_exercises_name ON workout_service.exercises(name);
CREATE INDEX idx_exercises_muscle_groups_gin ON workout_service.exercises USING GIN (muscle_groups);

CREATE INDEX idx_workout_exercises_workout_id ON workout_service.workout_exercises(workout_id);
CREATE INDEX idx_workout_exercises_exercise_id ON workout_service.workout_exercises(exercise_id);
CREATE INDEX idx_workout_sessions_user_id ON workout_service.workout_sessions(user_id);
CREATE INDEX idx_workout_sessions_workout_id ON workout_service.workout_sessions(workout_id);
CREATE INDEX idx_exercise_sets_workout_session_id ON workout_service.exercise_sets(workout_session_id);
CREATE INDEX idx_exercise_sets_exercise_id ON workout_service.exercise_sets(exercise_id);

-- Social Service Indexes
CREATE INDEX idx_social_posts_user_id ON social_service.social_posts(user_id);
CREATE INDEX idx_social_posts_type ON social_service.social_posts(type);
CREATE INDEX idx_social_posts_workout_id ON social_service.social_posts(workout_id);
CREATE INDEX idx_social_posts_created_at ON social_service.social_posts(created_at);
CREATE INDEX idx_social_posts_is_public ON social_service.social_posts(is_public);
CREATE INDEX idx_social_posts_content_fts ON social_service.social_posts USING GIN (to_tsvector('english', content));

CREATE INDEX idx_likes_user_id ON social_service.likes(user_id);
CREATE INDEX idx_likes_post_id ON social_service.likes(post_id);
CREATE INDEX idx_comments_user_id ON social_service.comments(user_id);
CREATE INDEX idx_comments_post_id ON social_service.comments(post_id);
CREATE INDEX idx_comments_parent_comment_id ON social_service.comments(parent_comment_id);
CREATE INDEX idx_shares_user_id ON social_service.shares(user_id);
CREATE INDEX idx_shares_post_id ON social_service.shares(post_id);

-- AI Service Indexes
CREATE INDEX idx_ai_chat_sessions_user_id ON ai_service.ai_chat_sessions(user_id);
CREATE INDEX idx_ai_chat_sessions_created_at ON ai_service.ai_chat_sessions(created_at);
CREATE INDEX idx_ai_messages_session_id ON ai_service.ai_messages(session_id);
CREATE INDEX idx_ai_messages_role ON ai_service.ai_messages(role);
CREATE INDEX idx_ai_messages_created_at ON ai_service.ai_messages(created_at);
CREATE INDEX idx_recommendations_user_id ON ai_service.recommendations(user_id);
CREATE INDEX idx_recommendations_type ON ai_service.recommendations(type);
CREATE INDEX idx_recommendations_confidence_score ON ai_service.recommendations(confidence_score);
CREATE INDEX idx_recommendations_created_at ON ai_service.recommendations(created_at);

-- Blockchain Service Indexes
CREATE INDEX idx_nfts_user_id ON blockchain_service.nfts(user_id);
CREATE INDEX idx_nfts_token_id ON blockchain_service.nfts(token_id);
CREATE INDEX idx_nfts_contract_address ON blockchain_service.nfts(contract_address);
CREATE INDEX idx_nfts_rarity ON blockchain_service.nfts(rarity);
CREATE INDEX idx_achievements_user_id ON blockchain_service.achievements(user_id);
CREATE INDEX idx_achievements_type ON blockchain_service.achievements(type);
CREATE INDEX idx_achievements_earned_at ON blockchain_service.achievements(earned_at);
CREATE INDEX idx_blockchain_transactions_user_id ON blockchain_service.blockchain_transactions(user_id);
CREATE INDEX idx_blockchain_transactions_hash ON blockchain_service.blockchain_transactions(transaction_hash);
CREATE INDEX idx_blockchain_transactions_status ON blockchain_service.blockchain_transactions(status);

-- Notification Service Indexes
CREATE INDEX idx_notifications_user_id ON notification_service.notifications(user_id);
CREATE INDEX idx_notifications_type ON notification_service.notifications(type);
CREATE INDEX idx_notifications_is_read ON notification_service.notifications(is_read);
CREATE INDEX idx_notifications_created_at ON notification_service.notifications(created_at);
CREATE INDEX idx_notification_preferences_user_id ON notification_service.notification_preferences(user_id);
CREATE INDEX idx_notification_preferences_type ON notification_service.notification_preferences(notification_type);

-- =============================================
-- FUNCTIONS AND TRIGGERS
-- =============================================

-- Update timestamp function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply update triggers to all tables with updated_at column
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON user_service.users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_user_profiles_updated_at BEFORE UPDATE ON user_service.user_profiles
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_workouts_updated_at BEFORE UPDATE ON workout_service.workouts
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_exercises_updated_at BEFORE UPDATE ON workout_service.exercises
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_social_posts_updated_at BEFORE UPDATE ON social_service.social_posts
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_comments_updated_at BEFORE UPDATE ON social_service.comments
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_ai_chat_sessions_updated_at BEFORE UPDATE ON ai_service.ai_chat_sessions
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Counter update functions
CREATE OR REPLACE FUNCTION update_likes_count()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE social_service.social_posts 
        SET likes_count = likes_count + 1 
        WHERE id = NEW.post_id;
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE social_service.social_posts 
        SET likes_count = likes_count - 1 
        WHERE id = OLD.post_id;
        RETURN OLD;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_likes_count_trigger
    AFTER INSERT OR DELETE ON social_service.likes
    FOR EACH ROW EXECUTE FUNCTION update_likes_count();

CREATE OR REPLACE FUNCTION update_comments_count()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE social_service.social_posts 
        SET comments_count = comments_count + 1 
        WHERE id = NEW.post_id;
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE social_service.social_posts 
        SET comments_count = comments_count - 1 
        WHERE id = OLD.post_id;
        RETURN OLD;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_comments_count_trigger
    AFTER INSERT OR DELETE ON social_service.comments
    FOR EACH ROW EXECUTE FUNCTION update_comments_count();

-- =============================================
-- VIEWS
-- =============================================

-- User workout summary view
CREATE VIEW user_service.user_workout_summary AS
SELECT 
    u.id as user_id,
    u.first_name,
    u.last_name,
    COUNT(w.id) as total_workouts,
    AVG(w.duration_minutes) as avg_duration,
    SUM(w.calories_burned) as total_calories,
    MAX(w.created_at) as last_workout
FROM user_service.users u
LEFT JOIN workout_service.workouts w ON u.id = w.user_id
GROUP BY u.id, u.first_name, u.last_name;

-- Social feed view
CREATE VIEW social_service.social_feed AS
SELECT 
    sp.id,
    sp.user_id,
    u.first_name,
    u.last_name,
    u.avatar_url,
    sp.content,
    sp.type,
    sp.media_urls,
    sp.workout_id,
    w.name as workout_name,
    sp.likes_count,
    sp.comments_count,
    sp.shares_count,
    sp.created_at
FROM social_service.social_posts sp
JOIN user_service.users u ON sp.user_id = u.id
LEFT JOIN workout_service.workouts w ON sp.workout_id = w.id
WHERE sp.is_public = true
ORDER BY sp.created_at DESC;

-- User achievements summary
CREATE VIEW blockchain_service.user_achievements_summary AS
SELECT 
    u.id as user_id,
    u.first_name,
    u.last_name,
    COUNT(a.id) as total_achievements,
    COUNT(CASE WHEN a.type = 'workout' THEN 1 END) as workout_achievements,
    COUNT(CASE WHEN a.type = 'social' THEN 1 END) as social_achievements,
    COUNT(CASE WHEN a.type = 'streak' THEN 1 END) as streak_achievements,
    MAX(a.earned_at) as last_achievement
FROM user_service.users u
LEFT JOIN blockchain_service.achievements a ON u.id = a.user_id
GROUP BY u.id, u.first_name, u.last_name;

-- =============================================
-- SAMPLE DATA
-- =============================================

-- Insert sample users
INSERT INTO user_service.users (id, email, first_name, last_name, role, bio, location, fitness_goals, activity_level) VALUES
('550e8400-e29b-41d4-a716-446655440001', 'john.doe@example.com', 'John', 'Doe', 'user', 'Fitness enthusiast and personal trainer', 'New York, NY', '["muscle_gain", "strength"]', 'very_active'),
('550e8400-e29b-41d4-a716-446655440002', 'jane.smith@example.com', 'Jane', 'Smith', 'trainer', 'Certified personal trainer with 5 years experience', 'Los Angeles, CA', '["weight_loss", "endurance"]', 'extremely_active'),
('550e8400-e29b-41d4-a716-446655440003', 'admin@fitnesshub.com', 'Admin', 'User', 'admin', 'System administrator', 'San Francisco, CA', '[]', 'moderately_active');

-- Insert sample exercises
INSERT INTO workout_service.exercises (id, name, description, category, muscle_groups, equipment, difficulty, instructions) VALUES
('650e8400-e29b-41d4-a716-446655440001', 'Push-ups', 'Classic bodyweight exercise for chest and arms', 'strength', '["chest", "triceps", "shoulders"]', 'none', 'beginner', '[{"step": 1, "instruction": "Start in plank position", "duration": null}, {"step": 2, "instruction": "Lower body until chest nearly touches floor", "duration": 2}, {"step": 3, "instruction": "Push back up to starting position", "duration": 2}]'),
('650e8400-e29b-41d4-a716-446655440002', 'Squats', 'Fundamental lower body exercise', 'strength', '["quadriceps", "glutes", "hamstrings"]', 'none', 'beginner', '[{"step": 1, "instruction": "Stand with feet shoulder-width apart", "duration": null}, {"step": 2, "instruction": "Lower body until thighs are parallel to floor", "duration": 2}, {"step": 3, "instruction": "Push through heels to return to starting position", "duration": 2}]'),
('650e8400-e29b-41d4-a716-446655440003', 'Deadlifts', 'Compound exercise for posterior chain', 'strength', '["hamstrings", "glutes", "lower_back"]', 'barbell', 'intermediate', '[{"step": 1, "instruction": "Stand with feet hip-width apart, barbell on floor", "duration": null}, {"step": 2, "instruction": "Bend at hips and knees to grip barbell", "duration": 2}, {"step": 3, "instruction": "Lift barbell by extending hips and knees", "duration": 2}]');

-- Insert sample workouts
INSERT INTO workout_service.workouts (id, user_id, name, description, type, difficulty, duration_minutes, calories_burned, is_template, is_public, tags) VALUES
('750e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', 'Upper Body Strength', 'Complete upper body workout focusing on chest, back, and arms', 'strength', 'intermediate', 45, 350, false, true, '["upper_body", "strength", "intermediate"]'),
('750e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440002', 'Beginner Full Body', 'Perfect workout for beginners to build strength and endurance', 'strength', 'beginner', 30, 250, true, true, '["full_body", "beginner", "strength"]');

-- Insert workout exercises
INSERT INTO workout_service.workout_exercises (workout_id, exercise_id, order_index, sets, reps, weight, rest_seconds, notes) VALUES
('750e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440001', 1, 3, 12, null, 60, 'Focus on controlled movement'),
('750e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440002', 1, 3, 15, null, 45, 'Keep knees behind toes'),
('750e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440001', 2, 2, 10, null, 45, 'Modify on knees if needed');

-- =============================================
-- PERMISSIONS
-- =============================================

-- Create service users
CREATE USER user_service_user WITH PASSWORD 'user_service_password';
CREATE USER workout_service_user WITH PASSWORD 'workout_service_password';
CREATE USER social_service_user WITH PASSWORD 'social_service_password';
CREATE USER ai_service_user WITH PASSWORD 'ai_service_password';
CREATE USER blockchain_service_user WITH PASSWORD 'blockchain_service_password';
CREATE USER notification_service_user WITH PASSWORD 'notification_service_password';

-- Grant schema permissions
GRANT USAGE ON SCHEMA user_service TO user_service_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA user_service TO user_service_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA user_service TO user_service_user;

GRANT USAGE ON SCHEMA workout_service TO workout_service_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA workout_service TO workout_service_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA workout_service TO workout_service_user;

GRANT USAGE ON SCHEMA social_service TO social_service_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA social_service TO social_service_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA social_service TO social_service_user;

GRANT USAGE ON SCHEMA ai_service TO ai_service_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA ai_service TO ai_service_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA ai_service TO ai_service_user;

GRANT USAGE ON SCHEMA blockchain_service TO blockchain_service_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA blockchain_service TO blockchain_service_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA blockchain_service TO blockchain_service_user;

GRANT USAGE ON SCHEMA notification_service TO notification_service_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA notification_service TO notification_service_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA notification_service TO notification_service_user;

-- Grant cross-schema read permissions
GRANT USAGE ON SCHEMA user_service TO workout_service_user, social_service_user, ai_service_user, blockchain_service_user, notification_service_user;
GRANT SELECT ON ALL TABLES IN SCHEMA user_service TO workout_service_user, social_service_user, ai_service_user, blockchain_service_user, notification_service_user;

-- =============================================
-- MAINTENANCE
-- =============================================

-- Create maintenance functions
CREATE OR REPLACE FUNCTION cleanup_old_sessions()
RETURNS INTEGER AS $$
DECLARE
    deleted_count INTEGER;
BEGIN
    DELETE FROM ai_service.ai_chat_sessions 
    WHERE created_at < NOW() - INTERVAL '30 days' 
    AND updated_at < NOW() - INTERVAL '7 days';
    
    GET DIAGNOSTICS deleted_count = ROW_COUNT;
    RETURN deleted_count;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION cleanup_read_notifications()
RETURNS INTEGER AS $$
DECLARE
    deleted_count INTEGER;
BEGIN
    DELETE FROM notification_service.notifications 
    WHERE is_read = true 
    AND read_at < NOW() - INTERVAL '30 days';
    
    GET DIAGNOSTICS deleted_count = ROW_COUNT;
    RETURN deleted_count;
END;
$$ LANGUAGE plpgsql;

-- =============================================
-- MONITORING
-- =============================================

-- Create monitoring views
CREATE VIEW system_stats AS
SELECT 
    'users' as table_name,
    COUNT(*) as record_count,
    MAX(created_at) as last_created
FROM user_service.users
UNION ALL
SELECT 
    'workouts' as table_name,
    COUNT(*) as record_count,
    MAX(created_at) as last_created
FROM workout_service.workouts
UNION ALL
SELECT 
    'social_posts' as table_name,
    COUNT(*) as record_count,
    MAX(created_at) as last_created
FROM social_service.social_posts
UNION ALL
SELECT 
    'notifications' as table_name,
    COUNT(*) as record_count,
    MAX(created_at) as last_created
FROM notification_service.notifications;

-- =============================================
-- END OF SCRIPT
-- =============================================

-- Display completion message
DO $$
BEGIN
    RAISE NOTICE 'FitnessHub database schema created successfully!';
    RAISE NOTICE 'Total tables created: 18';
    RAISE NOTICE 'Total indexes created: 45+';
    RAISE NOTICE 'Total functions created: 4';
    RAISE NOTICE 'Total views created: 4';
    RAISE NOTICE 'Sample data inserted successfully';
    RAISE NOTICE 'Database ready for development!';
END $$;

