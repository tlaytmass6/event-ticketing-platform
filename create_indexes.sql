
-- Q1: looking up customers via email
CREATE INDEX idx_user_email ON USER(email);

-- Q2: filtering by event category
CREATE INDEX idx_event_category ON EVENT(category);

-- Q3: venue → event lookup
CREATE INDEX idx_playsin_venue ON PLAYS_IN(venue_id);

-- Q4: customer → ticket lookup
CREATE INDEX idx_orders_customer ON ORDERS(customer_id);

-- Q5: aggregation of venue events (GROUP BY)
CREATE INDEX idx_playsin_venue_event ON PLAYS_IN(venue_id, event_id);

-- Q6: filtering by registration date
CREATE INDEX idx_user_registration_date ON USER(registration_date);

-- Q7: update the expiration date
CREATE INDEX idx_event_date ON EVENT(date);

-- Q8: cleanup orders missing payment_id
CREATE INDEX idx_orders_payment_null ON ORDERS(payment_id);