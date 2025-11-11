-- test_normalization.sql
-- demonstrating pre-normalized table

-- this table combines ticket + payment (denormalized)

CREATE TABLE PreTicketPayment (
    ticket_id INT,
    seat_number VARCHAR(10),
    qr_code INT,
    customer_id INT,
    payment_amount DECIMAL(10,2),
    payment_date DATE
);

-- Sample data (denormalized, potential anomalies)
INSERT INTO PreTicketPayment VALUES
(1, 'A1', 101010, 1, 50.00, '2025-11-20'),
(2, 'A2', 101011, 1, 50.00, '2025-11-20'),
(3, 'B1', 202020, 2, 75.00, '2025-11-21');

-- demonstration of anomalies in pre-normalized table

-- adding a new customer without a ticket
INSERT INTO PreTicketPayment (ticket_id, seat_number, qr_code, customer_id, payment_amount, payment_date)
VALUES (NULL, NULL, NULL, 3, 100.00, '2025-11-22');  -- Needs NULLs for ticket info

-- changing payment info requires multiple rows
UPDATE PreTicketPayment
SET payment_amount = 55.00
WHERE customer_id = 1;

-- deleting Lina's ticket could lose payment info
DELETE FROM PreTicketPayment
WHERE ticket_id = 1;

-- post-normalized tables (BCNF)

-- USER
CREATE TABLE USER (
    user_id INT PRIMARY KEY,
    name VARCHAR(40)
);

-- CUSTOMER
CREATE TABLE CUSTOMER (
    user_id INT PRIMARY KEY,
    FOREIGN KEY (user_id) REFERENCES USER(user_id)
);

-- ORGANIZER
CREATE TABLE ORGANIZER (
    user_id INT PRIMARY KEY,
    FOREIGN KEY (user_id) REFERENCES USER(user_id)
);

-- EVENT
CREATE TABLE EVENT (
    event_id INT PRIMARY KEY,
    date DATE,
    time TIME
);

-- VENUE
CREATE TABLE VENUE (
    venue_id INT PRIMARY KEY,
    capacity INT,
    address VARCHAR(100)
);

-- PLAYS_IN
CREATE TABLE PLAYS_IN (
    event_id INT,
    venue_id INT,
    PRIMARY KEY(event_id, venue_id),
    FOREIGN KEY (event_id) REFERENCES EVENT(event_id),
    FOREIGN KEY (venue_id) REFERENCES VENUE(venue_id)
);

-- TICKET
CREATE TABLE TICKET (
    ticket_id INT PRIMARY KEY,
    seat_number VARCHAR(10),
    qr_code INT UNIQUE
);

-- PAYMENT
CREATE TABLE PAYMENT (
    payment_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    FOREIGN KEY (customer_id) REFERENCES CUSTOMER(user_id)
);

-- ORDERS
CREATE TABLE ORDERS (
    customer_id INT,
    ticket_id INT,
    payment_id INT,
    PRIMARY KEY(customer_id, ticket_id),
    FOREIGN KEY (customer_id) REFERENCES CUSTOMER(user_id),
    FOREIGN KEY (ticket_id) REFERENCES TICKET(ticket_id),
    FOREIGN KEY (payment_id) REFERENCES PAYMENT(payment_id)
);

-- ORGANIZES
CREATE TABLE ORGANIZES (
    organizer_id INT,
    event_id INT,
    PRIMARY KEY(organizer_id, event_id),
    FOREIGN KEY (organizer_id) REFERENCES ORGANIZER(user_id),
    FOREIGN KEY (event_id) REFERENCES EVENT(event_id)
);

-- SHOWS
CREATE TABLE SHOWS (
    event_id INT,
    ticket_id INT,
    PRIMARY KEY(ticket_id),
    FOREIGN KEY (event_id) REFERENCES EVENT(event_id),
    FOREIGN KEY (ticket_id) REFERENCES TICKET(ticket_id)
);

-- sample normalized data

-- USERS
INSERT INTO USER VALUES (1, 'Lina'), (2, 'Mouna'), (3, 'Dana');

-- CUSTOMERS
INSERT INTO CUSTOMER VALUES (1), (2), (3);

-- EVENTS
INSERT INTO EVENT VALUES (1, '2025-12-01', '19:00:00'), 
                         (2, '2025-12-05', '12:00:00');

-- VENUES
INSERT INTO VENUE VALUES (1, 500, 'Kurfürstendamm 12, Berlin'),
                         (2, 1000, 'Marienplatz 5, Munich');

-- PLAYS_IN
INSERT INTO PLAYS_IN VALUES (1,1),(2,2);

-- TICKETS
INSERT INTO TICKET VALUES (1,'A1',101010),(2,'A2',101011),(3,'B1',202020);

-- PAYMENTS
INSERT INTO PAYMENT VALUES (1,1,100.00,'2025-11-20'),
                           (2,2,75.00,'2025-11-21');

-- ORDERS
INSERT INTO ORDERS VALUES (1,1,1),(1,2,1),(2,3,2);

-- SHOWS
INSERT INTO SHOWS VALUES (1,1),(1,2),(2,3);

-- ORGANIZES
INSERT INTO ORGANIZES VALUES (10,1),(11,2);

-- validation queries 

-- join tickets with orders and payments
SELECT o.customer_id, t.seat_number, p.amount, e.date, e.time
FROM ORDERS o
JOIN TICKET t ON o.ticket_id = t.ticket_id
JOIN PAYMENT p ON o.payment_id = p.payment_id
JOIN SHOWS s ON t.ticket_id = s.ticket_id
JOIN EVENT e ON s.event_id = e.event_id;

-- check which organizer is organizing which event
SELECT org.organizer_id, ev.event_id, ev.date
FROM ORGANIZES org
JOIN EVENT ev ON org.event_id = ev.event_id;
