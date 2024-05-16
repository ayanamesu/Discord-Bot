"""
The code below is just representative of the implementation of a Bot. 
However, this code was not meant to be compiled as it. It is the responsability 
of all the students to modifify this code such that it can fit the 
requirements for this assignments.
"""

import discord
import os
from discord.ext import commands
from database import *
from models import *

#TODO:  add your Discord Token as a value to your secrets on replit using the DISCORD_TOKEN key
TOKEN = os.environ["DISCORD_TOKEN"]

intents = discord.Intents.all()

bot = commands.Bot(command_prefix='!', intents=discord.Intents.all())


@bot.event
async def on_ready():
  print(f"{bot.user.name} has joined the server")
  database = Database()
  if database._connect():
    print(f"{bot.user.name} is connected to {db_name}")
  else:
    print(f"{bot.user.name} couldn't connect to the database")


@bot.command(
    name="test",
    description="write your database business requirement for this command here"
)
async def _test(ctx, arg1):
  #testModel = TestModel(ctx, arg1)
  #response = testModel.response()
  response = f'Hello {arg1} from your Discord bot! I was made with Python and Replit!'
  await ctx.send(response)

  # TODO: complete the following tasks:
  #       (1) Replace the commands' names with your own commands
  #       (2) Write the description of your business requirement in the description parameter
  #       (3) Implement your commands' methods.


@bot.command(name="new_general_user",
             description="creating a new general user")
async def createGeneralUser(ctx, user_id, name, last_name):
  passenger = Passenger()
  passenger.insert_general_user(user_id, name, last_name)
  await ctx.send(f"General user {name} {last_name} created successfully.")


@bot.command(name="new_account", description="creating a new account")
async def createAccount(ctx, account_id, accountowner, profile_name):
  accounts = account()
  accounts.insert_account(account_id, accountowner, profile_name)
  await ctx.send(
      f"Account {account_id} for {accountowner} created successfully.")


@bot.command(name="new_passenger", description="creating a new passenger")
async def createPassenger(ctx, passenger_id, name, last_name, email,
                          payment_method, luggage):
  passenger = Passenger()
  passenger.insert(passenger_id, name, last_name, email, payment_method,
                   luggage)
  await ctx.send(f"Passenger {name} {last_name} created successfully.")


@bot.command(name="get_ticket", description="Get a ticket for a passenger")
async def get_ticket(ctx, passenger_id: int):
  ticket = Passenger().get_ticket(passenger_id)
  if ticket and len(ticket) > 0:
    await ctx.send(
        f"Ticket ID: {ticket[0]['ticket_id']}, payment_type: {ticket[0]['payment_type']}, name: {ticket[0]['name']}"
    )
  else:
    await ctx.send(f"No ticket found for passenger ID: {passenger_id}")


@bot.command(
    name="delete_account",
    description="Delete a passenger account and passenger info along with it")
async def delete_account(ctx, passenger_id: int):
  delete_model = delete()
  result = delete_model.delete_account(passenger_id)
  if result:
    await ctx.send(f"Account with ID {passenger_id} has been deleted.")
  else:
    await ctx.send(f"Failed to delete account with ID {passenger_id}.")


@bot.command(
    name="get_descending_order",
    description=
    "Show a list of restaurants and stores in each terminal in decending order"
)
async def get_descending_order(ctx, *args):
  descending_order = descendingOrder()
  result = descending_order.get_descending_order()
  if result is None:
    await ctx.send("No data found")
  else:
    result_str = "\n".join([
        f"Terminal ID: {row['terminalhas_id']}, Store Name: {row['store_name']}, Store Location: {row['store_location']}, Restaurant Name: {row['restaurant_name']}, Restaurant Location: {row['restaurant_location']}"
        for row in result
    ])
    await ctx.send(result_str)


@bot.command(
    name="shifts",
    description=
    "Pick a shift number and edit its days, the staff with that shift number will then have the days updated formatted in (Mon-Sun)."
)
async def update_staff_shifts(ctx, shift_id: int, workdays: str):
  staff_model = staff()
  old_shifts = staff_model.get_staff_shifts(shift_id)
  await ctx.send(f"Old Shift {shift_id} had workdays {old_shifts}")
  staff_model.update_staff_shifts(workdays, shift_id)
  new_shifts = staff_model.get_staff_shifts(shift_id)
  await ctx.send(
      f"Shift {shift_id} has been updated with workdays {new_shifts}")


@bot.command(
    name="get_flight_lounge",
    description="List airlines associated with what lounge and terminal")
async def get_flight_lounge(ctx, terminal_id: int):
  lounge_model = lounge()
  results = lounge_model.get_flight_lounge(terminal_id)
  if results:
    for row in results:
      await ctx.send(
          f"Flight ID: {row['flight_id']}, Lounge Name: {row['lounge_name']}, Airline Name: {row['airline_name']}"
      )
  else:
    await ctx.send("No results found.")


@bot.command(
    name="get_terminal",
    description=
    "List all staff who are terminal workers working at a specific terminal")
async def get_terminal(ctx, terminal_id: int):
  terminal_model = terminal()
  results = terminal_model.get_terminal(terminal_id)
  if results:
    for row in results:
      await ctx.send(f"Terminal ID: {row['terminal_id']}")
  else:
    await ctx.send("No results found.")


@bot.command(
    name="Lounge_Airline",
    description=
    "incorporate a list to show the lounge number and their associated airline company"
)
async def get_lounges_and_airlines(ctx, *args):
  lounge_model = lounge()
  results = lounge_model.get_lounges_and_airlines()
  if results:
    for row in results:
      await ctx.send(
          f"Lounge ID: {row['lounge_id']}, Lounge Name: {row['lounge_name']}, Airline Name: {row['airline_name']}"
      )
  else:
    await ctx.send("No results found.")


@bot.command(
    name="popular",
    description=
    "Incorporate a list of restaurants who are popular among each terminal")
async def popular_choice(ctx, *args):
  terminalmodel = terminal()
  popular_choice = terminalmodel.popular_choice()
  for choice in popular_choice:
    await ctx.send(
        f"Terminal ID: {choice['terminal_id']}, Type: {choice['type']}, Name: {choice['name']}"
    )


@bot.command(
    name="flights",
    description="Provide a list of passenger associated with a flight")
async def flights(ctx, passenger_id: int):
  terminalmodel = terminal()
  details = terminalmodel.get_passenger_details(passenger_id)
  for detail in details:
    await ctx.send(
        f"Passenger ID: {detail['passenger_id']}, Name: {detail['name']}, Last Name: {detail['last_name']}, Email: {detail['email']}, Flight ID: {detail['flight_id']}, Airplane Name: {detail['airplaneName']}, Flight Description: {detail['description']}"
    )


@bot.command(
    name="occurance",
    description="List the stores that are present in more than one terminal")
async def get_store_occurance(ctx, *args):
  terminalmodel = terminal()
  result = terminalmodel.get_store_occurance()
  formatted_result = '\n'.join([str(row) for row in result])
  await ctx.send(formatted_result)


@bot.command(
    name="insert_terminal",
    description=
    "Incorporate a log of payments done by the passenger during their visit to the terminal and able to create a new insert to the terminal log"
)
async def insert_terminal(ctx, terminal_id, name, description, Terminal_has,
                          Lounge, gate, passenger, payments):
  terminal_model = terminal()
  terminal_model.insert_terminal(terminal_id, name, description, Terminal_has,
                                 Lounge, gate, passenger, payments)
  await ctx.send(f"Terminal {terminal_id} has been inserted successfully.")
  term = terminal_model.get_all_terminals()
  for terminals in term:
    await ctx.send(
        f"Terminal ID: {terminals['terminal_id']}, Name: {terminals['name']}, Description: {terminals['description']}, Terminal_has: {terminals['Terminal_has']}, Lounge: {terminals['Lounge']}, Gate: {terminals['gate']}, Passenger: {terminals['passenger']}, Payments: {terminals['payments']}"
    )


@bot.command(
    name="payments",
    description=
    "Incorporate an entry that is ordered by the passenger showing their info")
async def payments(ctx):
  passenger_model = Passenger()
  payments = passenger_model.all_payments()
  for payment in payments:
    await ctx.send(
        f"Method ID: {payment['method_id']}, Name: {payment['name']}, Last Name: {payment['last_name']}, Payment Method: {payment['payment_method']}"
    )


bot.run(TOKEN)
