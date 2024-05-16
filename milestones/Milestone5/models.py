"""
In this file you must implement all your database models.
If you need to use the methods from your database.py call them
statically. For instance:
# opens a new connection to your database
connection = Database.connect()
# closes the previous connection to avoid memory leaks
connection.close()
"""
from database import *
from database import Query
from models import *


class TestModel:
    """
    This is an object model example. Note that
    this model doesn't implement a DB connection.
    """


def __init__(self, ctx):
    self.ctx = ctx
    self.author = ctx.message.author.name


def response(self):
    return f'Hi, {self.author}. I am alive'


class Passenger:

    def __init__(self):
        self.db = Database()
        self.connection = self.db._connect()
        self.id = None
        self.passenger_id = None
        self.name = None
        self.last_name = None
        self.email = None
        self.payment_method = None
        self.luaggage = None

    def insert_general_user(self, user_id, name, last_name):
        query = Query.CREATE_GENERAL_USER
        values = (user_id, name, last_name)
        self.db.insert(query, values)

    def insert(self, passenger_id, name, last_name, email, payment_method,
               luggage):
        query = Query.CREATE_PASSENGER
        values = (passenger_id, name, last_name, email, payment_method,
                  luggage)
        self.db.insert(query, values)
        self.id = passenger_id
        self.name = name
        self.last_name = last_name
        self.email = email
        self.payment_method = payment_method
        self.luggage = luggage

    def get_passenger(self, passenger_id):
        query = "SELECT * FROM passenger WHERE passenger_id = %s;"
        values = (passenger_id, )
        passenger = self.db.get_response(query, values)
        if passenger is not None and len(passenger) > 0:
            self.name = passenger[0]['name']
        else:
            self.name = None

    def get_ticket(self, passenger_id):
        query = Query.GET_PASSENGER_TICKETS
        values = (int(passenger_id), )
        return Database.select(query, values=values)

    def all_payments(self):
        query = Query.GET_ALL_PAYMENTS
        return self.db.select(query)


class account:

    def __init__(self):
        self.db = Database()
        self.connection = self.db._connect()
        self.account_id = None
        self.accountowner = None
        self.profile_name = None

    def insert_account(self, account_id, accountowner, profile_name):
        query = "INSERT INTO account (account_id, accountowner, profile_name) VALUES (%s, %s, %s);"
        values = (account_id, accountowner, profile_name)
        self.db.insert(query, values)
        self.account_id = account_id
        self.accountowner = accountowner
        self.profile_name = profile_name


class delete:

    def __init__(self):
        self.db = Database()
        self.connection = self.db._connect()
        self.passenger_id = None

    def delete_account(self, passenger_id):
        query = Query.DELETE_ACCOUNT
        values = (passenger_id, )
        self.db.delete(query, values)
        try:
            self.db.delete(query, values)
            return True
        except:
            return False


class descendingOrder:

    def __init__(self):
        self.db = Database()
        self.connection = self.db._connect()

    def get_descending_order(self):
        query = Query.DESC_ORDER_STORE_RESTAURANT
        result = self.db.select(query)
        return result


class staff:

    def __init__(self):
        self.db = Database()
        self.connection = self.db._connect()

    def get_staff_shifts(self, shift_id):
        query = Query.GET_STAFF_SHIFTS
        values = (shift_id, )
        return self.db.select(query, values)

    def update_staff_shifts(self, workdays, staff_id):
        query = Query.UPDATE_STAFF_SHIFTS
        values = (workdays, staff_id)
        self.db.update(query, values)


class lounge:

    def __init__(self):
        self.db = Database()
        self.connection = self.db._connect()

    def get_flight_lounge(self, terminal_id):
        query = Query.GET_FLIGHT_LOUNGE
        values = (terminal_id, )
        return self.db.select(query, values)

    def get_lounges_and_airlines(self):
        query = Query.LOUNGE_AIRLINE
        return self.db.select(query)


class terminal:

    def __init__(self):
        self.db = Database()
        self.connection = self.db._connect()

    def get_terminal(self, terminal_id):
        query = Query.assigned_to_terminal
        values = (terminal_id, )
        return self.db.select(query, values)

    def popular_choice(self):
        query = Query.POPULAR_CHOICE
        return self.db.select(query)

    def get_passenger_details(self, passenger_id):
        query = Query.PASSENGER_ASSOCIATED_FLIGHT
        values = (passenger_id, )
        return self.db.select(query, values)

    def get_store_occurance(self):
        query = Query.STORE_OCCURANCE
        return self.db.select(query)

    def insert_terminal(self, terminal_id, name, description, Terminal_has,
                        Lounge, gate, passenger, payments):
        query = Query.TERMINAL
        values = (terminal_id, name, description, Terminal_has, Lounge, gate,
                  passenger, payments)
        self.db.insert(query, values)
        self.terminal_id = terminal_id
        self.name = name
        self.description = description
        self.Terminal_has = Terminal_has
        self.Lounge = Lounge
        self.gate = gate
        self.passenger = passenger
        self.payments = payments

    def get_all_terminals(self):
        query = Query.GET_TERMINAL
        return self.db.select(query)
