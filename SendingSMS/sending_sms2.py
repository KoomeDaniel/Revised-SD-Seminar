from flask import Flask, request
import africastalking
import requests
from datetime import datetime

# Initialize Africa's Talking with username and API key
africastalking.initialize(
    username='sandbox',  # Replace with your Africastalking sandbox username
    api_key='Your API Key'     # Replace with your Africastalking API key
)

app = Flask(__name__)
app.config["DEBUG"] = False

# Define SMS service
sms = africastalking.SMS

@app.route('/')
def home():
    return "Hello, World!"

@app.route('/sms_callback', methods=['POST'])
def sms_callback():
    sender = request.form['from']
    print('sender',sender)
    text = request.form['text']
    
    data = { 
        'Phone_Number': sender, 
        'Message_Text': text, 
        'Date_Time': datetime.utcnow().isoformat() + 'Z', 
        'Direction': 'Received' }
    headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
    }

    # Forward the data to the OData endpoint with authentication
    url = "http://desktop-4k864f5:7048/BC210/ODataV4/Company('CRONUS%20International%20Ltd.')/csdSMSReceived"
    username = 'Your BC Username'  
    password = 'Your BC Password'  
    print('data',data)
    print(request.form)
    print(request.method)
    try:
        response = requests.post(url, json=data, auth=(username, password),headers=headers)
        # response = requests.get(url, auth=(username, password))
        print(response.json())
        response.raise_for_status()  # Raise an exception for HTTP errors
        print(f"Data forwarded successfully: {response.status_code}")
    except requests.exceptions.RequestException as e:
        print(f"Error forwarding data: {e}")

    send_sms(sender, 'Thank you for the message')
    return "Success", 201

def send_sms(recipient_phone_number, message):
    try:
        # Use the Africastalking SDK to send the message
        response = sms.send(message, [recipient_phone_number], 19161)
        print(response)  # Log the response for debugging
    except Exception as e:
        print(f"Error sending SMS: {e}")
        

@app.route('/sending_sms', methods=['POST']) 
def sending_sms(): 
    data = request.get_json()  # Retrieve JSON payload
    recipient_phone_number = data['Phone_Number'] 
    message = data['Message_Text'] 
    date_time = data.get('Date_Time', '')  # Optional

    print(f"Message: {message}")
    print(f"Date/Time: {date_time}")

    try: 
        print(f"Sending SMS to {recipient_phone_number}: {message}")
        # Send the SMS using Africastalking
        response = sms.send(message, [recipient_phone_number], 19161) 
        print(response) 
        return "Success", 201 
    except Exception as e: 
        print(f"Error sending SMS: {e}") 
        return f"Error: {e}", 500    

if __name__ == "__main__":
    app.run()
