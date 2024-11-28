from flask import Flask, request
import africastalking

# Initialize Africa's Talking with username and API key
africastalking.initialize(
    username='sandbox',  # Replace with your Africastalking sandbox username
    api_key='atsk_8b7f4396108879e04e77b993d25d32304a3debc8c76c10cf3fcfa7f070d21dbc7fdec912'     # Replace with your Africastalking API key
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
    print(request.form)
    print(request.method)
    send_sms(sender, 'Thank you for the message')
    return "Success", 201

def send_sms(recipient_phone_number, message):
    try:
        # Use the Africastalking SDK to send the message
        response = sms.send(message, [recipient_phone_number], 19160)
        print(response)  # Log the response for debugging
    except Exception as e:
        print(f"Error sending SMS: {e}")

if __name__ == "__main__":
    app.run()
