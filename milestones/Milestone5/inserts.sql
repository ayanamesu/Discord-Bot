USE airportmanagementsysdb;

-- Insert into General User table
INSERT INTO generaluser (user_id, name, last_name) VALUES ('1', "Wing", "Lee");
INSERT INTO generaluser (user_id, name, last_name) VALUES ('2', "Jose", "Garcia");
INSERT INTO generaluser (user_id, name, last_name) VALUES ('3', "Rachel", "True");

-- Inserts into payment method table
INSERT INTO paymentmethod (method_id, name, description) VALUES ('1', "Cash", "For smaller amounts of money");
INSERT INTO PaymentMethod (method_id, name, description) VALUES ('2', "Credit Card", "Credit Card info is required");
INSERT INTO PaymentMethod (method_id, name, description) VALUES ('3', "Debit Card", "Debit Card info is required");

-- Inserts into luggage table
INSERT INTO luggage (luggage_id, weight, name) VALUES ('1', "50 lbs", "Pounds"); 
INSERT INTO luggage (luggage_id, weight, name) VALUES ('2', "40 lbs", "Pounds");
INSERT INTO luggage (luggage_id, weight, name) VALUES ('3', "30 lbs", "Pounds");
INSERT INTO luggage (luggage_id, weight, name) VALUES ('4', "25 lbs", "Pounds");

-- Insert into tickets
-- SELECT * FROM tickets;
INSERT INTO tickets (ticket_id, payment_type, name) VALUES ('1','Credit Card', 'Wing');
INSERT INTO tickets (ticket_id, payment_type, name) VALUES ('2','Cash', 'Jose');
INSERT INTO tickets (ticket_id, payment_type, name) VALUES ('3','Cash', 'Rachel');


-- Insert into Account table
INSERT INTO Account (account_id, accountowner, profile_name) VALUES (1,'1','Wing Lee');
INSERT INTO Account (account_id, accountowner, profile_name) VALUES (2,'2', 'Jose Garcia');
INSERT INTO Account (account_id, accountowner, profile_name) VALUES (3,'3', 'Rachel True');

-- Inserts into Passenger table
INSERT INTO Passenger (passenger_id, name, last_name, email, payment_method, luggage) VALUES ('1', 'Wing', 'Lee', 'wing@gmail.com', '2', '1');
INSERT INTO Passenger (passenger_id, name, last_name, email, payment_method, luggage) VALUES ('2', 'Rachel', 'True', 'rachrock@gmail.com', '1', '3');
INSERT INTO Passenger (passenger_id, name, last_name, email, payment_method, luggage) VALUES ('3', 'Jose', 'Garcia', 'jose@gmail.com', '1', '4');



-- Insert roles table
INSERT INTO roles (role_id, roleName, roleDescription) VALUES ('1', 'Engineer', 'Airline Engineer fixes and inspect planes');
INSERT INTO roles (role_id, roleName, roleDescription) VALUES ('2', 'Security', 'Patrols around terminal');
INSERT INTO roles (role_id, roleName, roleDescription) VALUES ('3', 'Manager', 'Store Manager');
INSERT INTO roles (role_id, roleName, roleDescription) VALUES ('4', 'Baggage Handler', 'Handles luggage');

-- Insert Company Airline table
INSERT INTO companyairline (airline_id, airlineName, airlinelocation) VALUES ('1', 'United', 'Terminal 1');
INSERT INTO companyairline (airline_id, airlineName, airlinelocation) VALUES ('2', 'Cathy Pacific', 'Terminal 2');
INSERT INTO companyairline (airline_id, airlineName, airlinelocation) VALUES ('3', 'Southwest', 'Terminal 2');

-- Insert into Shifts table
INSERT INTO Shifts (shift_id, schedules, workdays) VALUES ('1', '6AM-7PM', 'MON-FRI');
INSERT INTO Shifts (shift_id, schedules, workdays) VALUES ('2', '10AM-11PM', 'MON-THR');
INSERT INTO Shifts (shift_id, schedules, workdays) VALUES ('3', '3AM-5PM', 'TUES-SUN');

-- Insert into Staff table
INSERT INTO staff (staff_id, name, last_name, email, Company_airline, role, shifts) VALUES ('1', 'Matt', 'Lam', 'mattilam@mail.com', '1', '2', '1');
INSERT INTO staff (staff_id, name, last_name, email, Company_airline, role, shifts) VALUES ('2', 'Anh', 'Hoa', 'anh@mail.com', '2', '4', '1');
INSERT INTO staff (staff_id, name, last_name, email, Company_airline, role, shifts) VALUES ('3', 'Sally', 'Lee', 'Sal@mail.com', '2', '1', '2');

-- Insert into Airline table
INSERT INTO Airline (airline_id, name, description) VALUES ('1','United Airlines', 'Domestic');
INSERT INTO Airline (airline_id, name, description) VALUES ('2','Cathy Pacific', 'International');
INSERT INTO Airline (airline_id, name, description) VALUES ('3','Southwest Airline', 'Domestic');

-- Insert into Lounge table
INSERT INTO Lounge (lounge_id, name, airline) VALUES ('1','The Sunset', '3');
INSERT INTO Lounge (lounge_id, name, airline) VALUES ('2','Boeing', '1');
INSERT INTO Lounge (lounge_id, name, airline) VALUES ('3','Cathy Pacific', '2');


-- Insert into Stores table
-- SELECT * FROM Stores;
INSERT INTO Stores (store_id, name, location) VALUES ('1','Gucci', 'Term 1');
INSERT INTO Stores (store_id, name, location) VALUES ('2','Balenciaga', 'Term 1');
INSERT INTO Stores (store_id, name, location) VALUES ('3','Rolex', 'Term 2');

-- Insert into restaurant
-- SELECT * FROM Restaurant;
INSERT INTO Restaurant (restaurant_id, name, location) VALUES ('1','The Sunset', 'Term 1');
INSERT INTO Restaurant (restaurant_id, name, location) VALUES ('2','Shake Shack', 'Term 1');
INSERT INTO Restaurant (restaurant_id, name, location) VALUES ('3','L&L BBQ', 'Term 2');

-- Insert into flight
-- SELECT * FROM flight;
INSERT INTO flight (flight_id, airplaneName, Description) VALUES ('1','United Airlines', 'Boeing 737 MAX');
INSERT INTO flight (flight_id, airplaneName, Description) VALUES ('2','Cathy Pacific', 'Boeing 777');
INSERT INTO flight (flight_id, airplaneName, Description) VALUES ('3','Southwest Airlines', 'Boeing 737 MAX');

-- Insert into gate
-- SELECT * FROM gate;
INSERT INTO gate (gate_id, name, flightPlane) VALUES ('1','Gate 1', '1');
INSERT INTO gate (gate_id, name, flightPlane) VALUES ('2','Gate 2', '2');
INSERT INTO gate (gate_id, name, flightPlane) VALUES ('3','Gate 3', '3');

-- Insert into terminal
-- SELECT * FROM terminal;
INSERT INTO terminal (terminal_id, name, description, Terminal_has, Lounge, gate, passenger, payments) VALUES ('1','Terminal 1', 'Main Terminal', '1', '3', '2', 1, '59 USD');
INSERT INTO terminal (terminal_id, name, description, Terminal_has, Lounge, gate, passenger, payments) VALUES ('2','Terminal 2', 'Sub Terminal', '2', '2', '1',  2, '600 USD');
INSERT INTO terminal (terminal_id, name, description, Terminal_has, Lounge, gate, passenger, payments) VALUES ('3','Terminal 3', 'Sub Terminal', '3', '1', '3', 3, '77 USD');

-- Insert into terminalhas
-- SELECT * FROM terminalhas;
INSERT INTO terminalhas (terminalhas_id, stores_id, restaurant_id) VALUES ('1', '1', '1');
INSERT INTO terminalhas (terminalhas_id, stores_id, restaurant_id) VALUES ('2', '2', '2');
INSERT INTO terminalhas (terminalhas_id, stores_id, restaurant_id) VALUES ('3', '3', '3');

-- Insert into assignedtoterminal
-- SELECT * FROM assignedtoterminal;
INSERT INTO assignedtoterminal (Assigned_id, terminal_id, staff) VALUES ('1', '1', '1');
INSERT INTO assignedtoterminal (Assigned_id, terminal_id, staff) VALUES ('2', '2', '3');
INSERT INTO assignedtoterminal (Assigned_id, terminal_id, staff) VALUES ('3', '3', '2');




