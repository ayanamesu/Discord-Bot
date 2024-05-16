# In this file you must implement your main query methods
# so they can be used by your database models to interact with your bot.

import os
import pymysql.cursors

#TODO: add the values for these database keys in your secrets on replit
db_host = os.environ["DB_HOST"]
db_username = os.environ["DB_USER"]
db_password = os.environ["DB_PASSWORD"]
db_name = os.environ["DB_NAME"]


class Database:

    # This method was already implemented for you
    def _connect(self):
        """
        This method creates a connection with your database
        IMPORTANT: all the environment variables must be set correctly
                   before attempting to run this method. Otherwise, it
                   will throw an error message stating that the attempt
                   to connect to your database failed.
        """
        try:
            conn = pymysql.connect(host=db_host,
                                   port=3306,
                                   user=db_username,
                                   password=db_password,
                                   db=db_name,
                                   charset="utf8mb4",
                                   cursorclass=pymysql.cursors.DictCursor)
            print("Bot connected to database {}".format(db_name))
            return conn
        except ConnectionError as err:
            print(f"An error has occurred: {err.args[1]}")
            print("\n")
            return None

    #TODO: needs to implement the internal logic of all the main query operations
    def get_response(self,
                     query,
                     values=None,
                     fetch=False,
                     many_entities=False):
        """
        query: the SQL query with wildcards (if applicable) to avoid injection attacks
        values: the values passed in the query
        fetch: If set to True, then the method fetches data from the database (i.e with SELECT)
        many_entities: If set to True, the method can insert multiple entities at a time.
        """
        connection = self._connect()
        cursor = connection.cursor()
        if values:
            if many_entities:
                cursor.executemany(query, values)
            else:
                cursor.execute(query, values)
        else:
            cursor.execute(query)
        connection.commit()
        if fetch:
            response = cursor.fetchall()
        else:
            response = None
        connection.close()
        return response

    # the following methods were already implemented for you.
    @staticmethod
    def select(query, values=None, fetch=True):
        database = Database()
        return database.get_response(query, values=values, fetch=fetch)

    @staticmethod
    def insert(query, values=None, many_entities=False):
        database = Database()
        return database.get_response(query,
                                     values=values,
                                     many_entities=many_entities)

    @staticmethod
    def update(query, values=None):
        database = Database()
        return database.get_response(query, values=values)

    @staticmethod
    def delete(query, values=None):
        database = Database()
        return database.get_response(query, values=values)


class Query:
    ALL_STAFF = """SELECT * FROM staff s
                      JOIN companyairline c ON c.airline_id = s.Company_airline
                      JOIN Roles r ON r.role_id = s.role"""

    GET_STAFF = """SELECT * FROM Staff s
                      JOIN companyairline c ON c.airline_id = s.Company_airline
                      JOIN Roles r ON r.role_id = s.role
                      WHERE s.staff_id = %s"""

    GET_STAFF_SHIFTS = """SELECT staff.name, staff.shifts, shifts.workdays
                                FROM staff
                                JOIN shifts ON staff.shifts = shifts.shift_id
                                WHERE staff.shifts = %s;"""

    UPDATE_STAFF_SHIFTS = """UPDATE shifts
                            SET workdays = %s
                            WHERE shift_id = (SELECT shifts FROM staff WHERE staff_id = %s);"""

    DELETE_STAFF = """DELETE staff, assignedtoterminal
                        FROM staff
                        JOIN assignedtoterminal ON assignedtoterminal.staff = staff.staff_id
                        WHERE staff.staff_id = %s;"""

    STAFF_LIST = """SELECT * FROM staff"""

    assigned_to_terminal = "SELECT * FROM assignedtoterminal WHERE terminal_id = %s"

    DELETE_ACCOUNT = """DELETE passenger, account
                        FROM passenger
                        JOIN account ON account.accountowner = passenger.passenger_id
                        WHERE passenger.passenger_id = %s;"""

    GET_ACCOUNT = """SELECT * FROM account;"""

    INSERT_PASSENGER_PAY = """INSERT INTO terminal (passenger, name, payments)
                                SELECT passenger.passenger_id, passenger.name, paymentmethod.method_id
                                FROM passenger
                                JOIN paymentmethod ON paymentmethod.method_id = passenger.payment_method
                                WHERE passenger.passenger_id = %s;"""

    GET_ALL_PAYMENTS = """SELECT paymentmethod.method_id, passenger.name, passenger.last_name, passenger.payment_method
                                FROM paymentmethod 
                                JOIN passenger ON passenger.payment_method = paymentmethod.method_id;"""

    UPDATE_TERMINAL_INFO = """UPDATE terminal AS T
                                SET T.lounge = 1,
                                T.gate = 2
                                WHERE T.terminal_id = 1;"""

    GET_TERMINAL = """SELECT * FROM terminal"""

    GET_STORE_LIST = """SELECT * FROM terminalhas
                                JOIN stores ON terminalhas.stores_id = stores.store_id
                                WHERE terminalhas.terminalhas_id = %s;"""

    GET_RESTAURANT_LIST = """SELECT * FROM terminalhas
                                JOIN restaurant ON terminalhas.restaurant_id = restaurant.restaurant_id
                                WHERE terminalhas.terminalhas_id = %s;"""

    GET_FLIGHT_GATE = """SELECT flight.* 
                                FROM terminal
                                JOIN gate ON terminal.gate = gate.gate_id
                                JOIN flight ON gate.flightplane = flight.flight_id
                                WHERE terminal.terminal_id = %s;"""

    GET_FLIGHT_LOUNGE = """SELECT flight.*, lounge.name AS lounge_name, airline.name AS airline_name
                                FROM terminal
                                JOIN gate ON terminal.gate = gate.gate_id
                                JOIN flight ON gate.flightplane = flight.flight_id
                                JOIN lounge ON terminal.lounge = lounge.lounge_id
                                JOIN airline ON lounge.airline = airline.airline_id
                                WHERE terminal.terminal_id = %s;"""

    GET_PASSENGER_TICKETS = """SELECT * FROM tickets
                                    JOIN passenger ON tickets.name = passenger.name
                                    WHERE passenger.passenger_id = %s;"""

    CREATE_PASSENGER = """INSERT INTO passenger (passenger_id, name, last_name, email, payment_method, luggage) VALUES (%s, %s, %s, %s, %s, %s)"""

    GET_PASSENGER = "SELECT * FROM passengers WHERE id = %s"

    UPDATE_PASSENGER = "UPDATE passengers SET name = %s, last_name = %s, payment_method = %s, luggage = %s WHERE id = %s"

    CREATE_GENERAL_USER = "INSERT INTO generaluser (user_id, name, last_name) VALUES (%s, %s, %s)"

    DESC_ORDER_STORE_RESTAURANT = """SELECT th.terminalhas_id, s.name AS store_name, s.location AS store_location, r.name AS restaurant_name, r.location AS restaurant_location
                                FROM terminalhas AS th
                                LEFT JOIN stores AS s ON th.stores_id = s.store_id
                                LEFT JOIN restaurant AS r ON th.restaurant_id = r.restaurant_id
                                ORDER BY th.terminalhas_id DESC;"""

    LOUNGE_AIRLINE = """SELECT lounge.lounge_id, lounge.name AS lounge_name, airline.name AS airline_name
                        FROM lounge
                        INNER JOIN airline ON lounge.airline = airline.airline_id;"""

    POPULAR_CHOICE = """SELECT terminalhas.terminalhas_id AS terminal_id, 'store' as type, stores.name
                    FROM terminalhas
                    INNER JOIN stores ON terminalhas.stores_id = stores.store_id
                    UNION ALL
                    SELECT terminalhas.terminalhas_id AS terminal_id, 'restaurant' as type, restaurant.name
                    FROM terminalhas
                    INNER JOIN restaurant ON terminalhas.restaurant_id = restaurant.restaurant_id
                    ORDER BY terminal_id, type;"""

    PASSENGER_ASSOCIATED_FLIGHT = """SELECT 
                                        p.passenger_id, 
                                        p.name, 
                                        p.last_name, 
                                        p.email, 
                                        f.flight_id, 
                                        f.airplaneName, 
                                        f.description
                                    FROM 
                                        terminal t
                                    INNER JOIN 
                                        gate g ON t.gate = g.gate_id
                                    INNER JOIN 
                                        flight f ON g.flightPlane = f.flight_id
                                    INNER JOIN 
                                        passenger p ON t.passenger = p.passenger_id
                                    WHERE 
                                        p.passenger_id = %s;"""

    STORE_OCCURANCE = """SELECT 
                            s.store_id, 
                            s.name, 
                            s.location
                        FROM 
                            stores s
                        INNER JOIN 
                            terminalhas th ON s.store_id = th.stores_id
                        WHERE 
                            s.name IN (
                                SELECT 
                                    s.name
                                FROM 
                                    stores s
                                INNER JOIN 
                                    terminalhas th ON s.store_id = th.stores_id
                                GROUP BY 
                                    s.name
                                HAVING 
                                    COUNT(DISTINCT th.terminalhas_id) > 1
                            );"""
    TERMINAL = """INSERT INTO terminal (terminal_id, name, description, Terminal_has, Lounge, gate, passenger, payments) 
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s);"""
