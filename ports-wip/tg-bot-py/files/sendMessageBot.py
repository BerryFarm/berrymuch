import random
import http.client
import json


# Test key for demonstration
BOT_TOKEN = ''

# Prime number and generator for key exchange
prime = 99194853094755497  # A large prime number
generator = 5  # A primitive root modulo `prime`

# Function to generate private key
def generate_private_key(prime):
    return random.randrange(2, prime-2)

# Function to compute public key
def compute_public_key(base, private_key, prime):
    return pow(base, private_key, prime)

# Function to compute shared secret
def compute_shared_secret(other_public, private_key, prime):
    return pow(other_public, private_key, prime)

# Function to send secure request
def send_secure_request(secret, message_text, chat_id):
    # Placeholder for encryption (in practice, use a real encryption method)
    # Concatenate the message text and secret with a delimiter
    data = {
        'text': message_text,
        'secret': secret,
        'chat_id': chat_id
    }

    # Setup HTTP connection
    conn = http.client.HTTPSConnection("api.telegram.org")
    headers = {'Content-type': 'application/json'}
    json_data = json.dumps(data)
    conn.request("POST", "/bot{}/sendMessage".format(BOT_TOKEN), body=json_data, headers=headers)
    response = conn.getresponse()
    response_text = response.read()
    conn.close()
    print(response_text.decode('utf-8'))



# Alice's keys
alice_private = generate_private_key(prime)
alice_public = compute_public_key(generator, alice_private, prime)

# Bob's keys (simulating the other party, could be your server-side application)
bob_private = generate_private_key(prime)
bob_public = compute_public_key(generator, bob_private, prime)

# Compute the shared secret
alice_secret = compute_shared_secret(bob_public, alice_private, prime)
bob_secret = compute_shared_secret(alice_public, bob_private, prime)

# Ensure both secrets match
assert alice_secret == bob_secret

chat_id =  5002406982
# Use the shared secret to send a "secure" message
send_secure_request(str(alice_secret), "Hello, this is a test message", chat_id)




