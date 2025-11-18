-- Q1: look up a customer by email
SELECT user_id, name
FROM USER
WHERE email = 'customer@example.com';

-- Q2: obtain a particular category's events
SELECT event_id, name, date
FROM EVENT
WHERE category = 'Concert';

-- Q3: list every event that is planned at a particular place
SELECT e.event_id, e.name, e.date
FROM PLAYS_IN pi
JOIN EVENT e ON pi.event_id = e.event_id
WHERE pi.venue_id = 12;

-- Q4: find every ticket sold to a particular customer
SELECT t.ticket_id, t.seat_number
FROM ORDERS o
JOIN TICKET t ON o.ticket_id = t.ticket_id
WHERE o.customer_id = 456;

-- Q5: identify venues that are currently hosting more that 3 events
SELECT v.venue_id, v.name, COUNT(*) AS event_count
FROM PLAYS_IN pi
JOIN VENUE v ON pi.venue_id = v.venue_id
GROUP BY v.venue_id, v.name
HAVING COUNT(*) > 3;

-- Q6: find every user who signed up after a certain date
SELECT user_id, name, registration_date
FROM USER
WHERE registration_date > '2025-01-01';

-- Q7: DML – Bulk UPDATE (mark tickets as 'expired' for past events)
UPDATE TICKET
SET status = 'EXPIRED'
WHERE ticket_id IN (
    SELECT s.ticket_id
    FROM SHOWS s
    JOIN EVENT e ON s.event_id = e.event_id
    WHERE e.date < CURRENT_DATE
);

-- Q8: DML – Bulk DELETE (remove orders with no updated payment )
DELETE FROM ORDERS
WHERE payment_id IS NULL;