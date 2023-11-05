import random
import signal
import sys 
from clickhouse_driver import Client # pip install clickhouse-driver

client = Client('localhost', port=9000, user='default', password='password')

names = ['Alice', 'Bob', 'Charlie', 'David']
emails = ['alice@example.com', 'bob@example.com', 'charlie@example.com', 'david@example.com']
preferred_numbers = [1234, 5678, 9012, 3456]

def signal_handler(sig, frame):
    print('Shutting down...')
    sys.exit(0)

signal.signal(signal.SIGINT, signal_handler)

try:
    print('Inserting data... Press CTRL+C to stop.')
    while True:
        id = random.randint(1, 10000)
        name = random.choice(names)
        email = random.choice(emails)
        preferred_number = random.choice(preferred_numbers)
        client.execute('INSERT INTO users (id, name, email, preferred_number) VALUES', [(id, name, email, preferred_number)])
        print(f"Adding {id} {name} {email} {preferred_number}")
except KeyboardInterrupt:
    pass
finally:
    print('Program terminated.')
