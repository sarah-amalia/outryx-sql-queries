-- outryx SQL Queries
-- Support Operations — Supabase (PostgreSQL)

-- 1. Find all open tickets
SELECT * FROM tickets
WHERE status = 'open';

-- 2. Find all tickets with user details
SELECT t.id, u.name, t.subject,
t.category, t.priority, t.status
FROM tickets t
JOIN users u ON t.user_id = u.id
ORDER BY t.created_at DESC;

-- 3. Count tickets by category
SELECT category, COUNT(*) AS total_tickets
FROM tickets
GROUP BY category
ORDER BY total_tickets DESC;

-- 4. Find urgent tickets
SELECT t.id, u.name, u.email,
t.subject, t.priority
FROM tickets t
JOIN users u ON t.user_id = u.id
WHERE t.priority = 'urgent';

-- 5. Find resolved tickets this week
SELECT t.id, u.name, t.subject, t.resolved_at
FROM tickets t
JOIN users u ON t.user_id = u.id
WHERE t.status = 'closed'
AND t.resolved_at >= NOW() - INTERVAL '7 days';

-- 6. Find users on free plan
SELECT name, email, plan, status
FROM users
WHERE plan = 'free'
ORDER BY name;

-- 7. Count campaigns per user
SELECT u.name, COUNT(c.id) AS total_campaigns
FROM users u
LEFT JOIN campaigns c ON u.id = c.user_id
GROUP BY u.name
ORDER BY total_campaigns DESC;

-- 8. Find all sent campaigns with subscriber count
SELECT c.name, u.name AS user_name,
c.subscribers_count, c.sent_at
FROM campaigns c
JOIN users u ON c.user_id = u.id
WHERE c.status = 'sent'
ORDER BY c.subscribers_count DESC;
