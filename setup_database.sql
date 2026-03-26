-- Hexapath AI - Supabase Database Setup Script
-- Run this in the Supabase SQL Editor (New Query)

-- 1. Create Users Table
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(255),
    username VARCHAR(100) UNIQUE,
    email VARCHAR(255) UNIQUE,
    password_hash VARCHAR(255),
    department VARCHAR(100),
    experience_level VARCHAR(50),
    skills JSONB DEFAULT '[]',
    role VARCHAR(50) DEFAULT 'learner'
);

-- 2. Create Skills Table
CREATE TABLE IF NOT EXISTS skills (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE,
    description TEXT
);

-- 3. Create Courses Table
CREATE TABLE IF NOT EXISTS courses (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    description TEXT,
    target_skill_id INTEGER REFERENCES skills(id)
);

-- 4. Create Assessments Table
CREATE TABLE IF NOT EXISTS assessments (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    course_id INTEGER REFERENCES courses(id),
    max_score INTEGER DEFAULT 100
);

-- 5. Create Adaptive Sessions Table
CREATE TABLE IF NOT EXISTS adaptive_sessions (
    id VARCHAR(50) PRIMARY KEY,
    user_id INTEGER,
    domain VARCHAR(255),
    role VARCHAR(255),
    skills VARCHAR(1000),
    current_skill_index INTEGER DEFAULT 0,
    history TEXT DEFAULT '[]',
    proficiency_scores TEXT DEFAULT '{}',
    is_completed INTEGER DEFAULT 0,
    created_at VARCHAR(50)
);

-- 6. Create OTP Verifications Table
CREATE TABLE IF NOT EXISTS otp_verifications (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    otp_code VARCHAR(6) NOT NULL,
    expires_at TIMESTAMP NOT NULL DEFAULT (CURRENT_TIMESTAMP + INTERVAL '10 minutes'),
    user_data_json TEXT NOT NULL
);

-- 7. Create Progress Records Table
CREATE TABLE IF NOT EXISTS progress_records (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    desired_role VARCHAR(150),
    industry VARCHAR(100),
    experience_level VARCHAR(50),
    career_fit_pct FLOAT DEFAULT 0,
    total_hard_gaps INTEGER DEFAULT 0,
    total_soft_gaps INTEGER DEFAULT 0,
    hard_gaps JSONB DEFAULT '[]',
    soft_gaps JSONB DEFAULT '[]',
    hard_matches JSONB DEFAULT '[]',
    soft_matches JSONB DEFAULT '[]',
    learning_path JSONB DEFAULT '[]',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 8. Create Assessment Records Table
CREATE TABLE IF NOT EXISTS assessment_records (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    score FLOAT DEFAULT 0,
    passed INTEGER DEFAULT 0,
    total_questions INTEGER DEFAULT 0,
    correct_count INTEGER DEFAULT 0,
    per_skill JSONB DEFAULT '{}',
    feedback VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 9. Create Course Progress Table
CREATE TABLE IF NOT EXISTS course_progress (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    course_id VARCHAR(100),
    course_name VARCHAR(255),
    platform VARCHAR(100),
    total_modules INTEGER DEFAULT 5,
    completed_modules INTEGER DEFAULT 0,
    completion_pct FLOAT DEFAULT 0,
    status VARCHAR(50) DEFAULT 'In Progress',
    last_accessed TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 10. Create Support Tickets Table
CREATE TABLE IF NOT EXISTS support_tickets (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    user_name VARCHAR(255),
    user_email VARCHAR(255),
    subject VARCHAR(300),
    category VARCHAR(100),
    message TEXT,
    status VARCHAR(50) DEFAULT 'open',
    priority VARCHAR(50) DEFAULT 'medium',
    admin_reply TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Indexes for Performance
CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_progress_user_id ON progress_records(user_id);
CREATE INDEX IF NOT EXISTS idx_assessment_user_id ON assessment_records(user_id);
CREATE INDEX IF NOT EXISTS idx_course_progress_user_id ON course_progress(user_id);
