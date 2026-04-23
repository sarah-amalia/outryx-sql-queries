# Outryx SQL Queries

Database schema and SQL queries for the outryx.

## About

This repository documents the database structure and SQL queries used to manage support operations for Outryx — an email marketing automation platform.

## Database Schema

### users
Stores Outryx customer account information.

| Column | Type | Description |
|---|---|---|
| id | SERIAL | Primary key |
| name | VARCHAR | Customer full name |
| email | VARCHAR | Unique email address |
| plan | VARCHAR | Subscription plan (free/pro/enterprise) |
| status | VARCHAR | Account status (active/inactive) |
| created_at | TIMESTAMP | Account creation date |

### tickets
Stores customer support tickets.

| Column | Type | Description |
|---|---|---|
| id | SERIAL | Primary key |
| user_id | INTEGER | Foreign key to users |
| subject | VARCHAR | Ticket subject |
| category | VARCHAR | Issue category |
| priority | VARCHAR | Priority level (low/medium/high/urgent) |
| status | VARCHAR | Ticket status (open/closed) |
| created_at | TIMESTAMP | Ticket creation date |
| resolved_at | TIMESTAMP | Resolution date |

### campaigns
Stores email campaign data.

| Column | Type | Description |
|---|---|---|
| id | SERIAL | Primary key |
| user_id | INTEGER | Foreign key to users |
| name | VARCHAR | Campaign name |
| status | VARCHAR | Campaign status (draft/sent) |
| subscribers_count | INTEGER | Number of subscribers |
| sent_at | TIMESTAMP | Campaign send date |
| created_at | TIMESTAMP | Campaign creation date |

## Queries

### 1. Find all open tickets
```sql
SELECT * FROM tickets 
WHERE status = 'open';
```

### 2. Find all tickets with user details
```sql
SELECT t.id, u.name, t.subject, 
t.category, t.priority, t.status
FROM tickets t
JOIN users u ON t.user_id = u.id
ORDER BY t.created_at DESC;
```

### 3. Count tickets by category
```sql
SELECT category, COUNT(*) as total_tickets
FROM tickets
GROUP BY category
ORDER BY total_tickets DESC;
```

### 4. Find urgent tickets
```sql
SELECT t.id, u.name, u.email, 
t.subject, t.priority
FROM tickets t
JOIN users u ON t.user_id = u.id
WHERE t.priority = 'urgent';
```

### 5. Find resolved tickets this week
```sql
SELECT t.id, u.name, t.subject, t.resolved_at
FROM tickets t
JOIN users u ON t.user_id = u.id
WHERE t.status = 'closed'
AND t.resolved_at >= NOW() - INTERVAL '7 days';
```

### 6. Find users on free plan
```sql
SELECT name, email, plan, status
FROM users
WHERE plan = 'free'
ORDER BY name;
```

### 7. Count campaigns per user
```sql
SELECT u.name, COUNT(c.id) as total_campaigns
FROM users u
LEFT JOIN campaigns c ON u.id = c.user_id
GROUP BY u.name
ORDER BY total_campaigns DESC;
```

### 8. Find all sent campaigns with subscriber count
```sql
SELECT c.name, u.name as user_name,
c.subscribers_count, c.sent_at
FROM campaigns c
JOIN users u ON c.user_id = u.id
WHERE c.status = 'sent'
ORDER BY c.subscribers_count DESC;
```

## Tools Used
- Supabase (PostgreSQL)
- SQL

## Project Context

- [outryx.vercel.app](https://outryx.vercel.app)
- [Help Center - Zoho Desk](https://outryx.zohodesk.com/portal/en/home)
- [outryx System Status](https://stats.uptimerobot.com/4Jr0kuTwcT/802877012)
- [API Docs - Postman](
https://documenter.getpostman.com/view/47296527/2sBXqFLh6V)
- [Incident Report - on GitHub](https://github.com/sarah-amalia/outryx-incident-report/blob/main/INC-001.md)
