-- create_normalized_schema
CREATE TABLE Customer (
    CustID INT AUTO_INCREMENT,
    Name VARCHAR(40) NOT NULL,
    Status ENUM('new','active','vip') NOT NULL DEFAULT 'active',
    PRIMARY KEY (CustID)
) ENGINE=InnoDB;

CREATE TABLE Venue (
    VenueID INT AUTO_INCREMENT,
    Capacity INT,
    Address VARCHAR(100),
    PRIMARY KEY (VenueID)
) ENGINE=InnoDB;

CREATE TABLE Event (
    EventID INT AUTO_INCREMENT,
    EventName VARCHAR(40) NOT NULL,
    EventDate DATE NOT NULL,
    EventTime TIME NOT NULL,
    VenueID INT,
    PRIMARY KEY (EventID),
    FOREIGN KEY (VenueID) REFERENCES Venue(VenueID)
) ENGINE=InnoDB;

CREATE TABLE Ticket (
    TicketID INT AUTO_INCREMENT,
    QRCode INT,
    Payment DECIMAL(10,2) CHECK (Payment > 0),
    PRIMARY KEY (TicketID)
) ENGINE=InnoDB;

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT,
    Quantity INT,
    Amount DECIMAL(10,2) CHECK (Amount > 0),
    PRIMARY KEY (OrderID)
) ENGINE=InnoDB;

CREATE TABLE CustomerOrganizer (
    TransactionID INT AUTO_INCREMENT,
    CustID INT,
    PRIMARY KEY (TransactionID),
    FOREIGN KEY (CustID) REFERENCES Customer(CustID)
) ENGINE=InnoDB;

CREATE TABLE Organizes (
    TicketID INT,
    EventID INT,
    PRIMARY KEY (TicketID, EventID),
    FOREIGN KEY (TicketID) REFERENCES Ticket(TicketID),
    FOREIGN KEY (EventID) REFERENCES Event(EventID)
) ENGINE=InnoDB;
