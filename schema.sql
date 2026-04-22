-- outryx Database Schema
-- Supabase (PostgreSQL)

-- Users table
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  plan VARCHAR(20) NOT NULL DEFAULT 'free',
  status VARCHAR(20) NOT NULL DEFAULT 'active',
  created_at TIMESTAMP DEFAULT NOW()
);

-- Tickets table
CREATE TABLE tickets (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  subject VARCHAR(255) NOT NULL,
  category VARCHAR(100) NOT NULL,
  priority VARCHAR(20) NOT NULL DEFAULT 'medium',
  status VARCHAR(20) NOT NULL DEFAULT 'open',
  created_at TIMESTAMP DEFAULT NOW(),
  resolved_at TIMESTAMP
);

-- Campaigns table
CREATE TABLE campaigns (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  name VARCHAR(255) NOT NULL,
  status VARCHAR(20) NOT NULL DEFAULT 'draft',
  subscribers_count INTEGER DEFAULT 0,
  sent_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW()
);
