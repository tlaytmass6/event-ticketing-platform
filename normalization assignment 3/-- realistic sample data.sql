-- realistic sample data

-- customers
INSERT INTO Customer (Name, Status) VALUES
('Lina', 'active'),
('Mouna', 'vip'),
('Dana', 'new');

-- venues
INSERT INTO Venue (Capacity, Address) VALUES
(500, 'Kurfürstendamm 12, Berlin, Germany'),
(1000, 'Marienplatz 5, Munich, Germany'),
(250, 'Kaiserstrasse 8, Frankfurt, Germany');

-- events
INSERT INTO Event (EventName, EventDate, EventTime, VenueID) VALUES
('Jazz Night', '2025-12-01', '19:00:00', 1),
('Food Festival', '2025-12-05', '12:00:00', 2),
('Comedy Night', '2025-12-10', '20:30:00', 3);

-- tickets
INSERT INTO Ticket (QRCode, Payment) VALUES
(101010, 50.00),  -- Ticket 1 for Jazz Night
(101011, 50.00),  -- Ticket 2 for Jazz Night
(202020, 75.00),  -- Ticket 1 for Food Festival
(202021, 75.00),  -- Ticket 2 for Food Festival
(303030, 30.00),  -- Ticket 1 for Comedy Night
(303031, 30.00);  -- Ticket 2 for Comedy Night

-- orders
INSERT INTO Orders (Quantity, Amount) VALUES
(2, 100.00),  -- Lina buys 2 tickets for Jazz Night
(1, 75.00),   -- Mouna buys 1 ticket for Food Festival
(1, 75.00),   -- Mouna buys 1 more ticket for Food Festival
(2, 60.00);   -- Dana buys 2 tickets for Comedy Night

-- customer-organizer (links customers to transactions)
INSERT INTO CustomerOrganizer (CustID) VALUES
(1),  -- Lina
(2),  -- Mouna (first order)
(2),  -- Mouna (second order)
(3);  -- Dana

-- organizes 
INSERT INTO Organizes (TicketID, EventID) VALUES
(1, 1),  -- Ticket 1 for Jazz Night
(2, 1),  -- Ticket 2 for Jazz Night
(3, 2),  -- Ticket 1 for Food Festival
(4, 2),  -- Ticket 2 for Food Festival
(5, 3),  -- Ticket 1 for Comedy Night
(6, 3);  -- Ticket 2 for Comedy Night
