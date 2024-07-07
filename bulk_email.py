import smtplib
import pandas as pd
import time
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

# Load email addresses from CSV
email_df = pd.read_csv('mf.csv')

# Email configuration
smtp_server = 'mail.privateemail.com'
smtp_port = 587
email_user = 'domain@kloudninja.online'
email_password = '@26Mujrab'

# Email content
subject = "MISSOURI FULFILLMENT"
body = """\
Hello,

I hope this finds you well. I am reaching out to you with an exciting opportunity to acquire a premium domain FulfillmentMissouri.com that aligns perfectly with your business.

This domain contains highly searched keywords which fits perfectly with your area of practice and the real value of the domain is that it defines your service in Missouri and surrounding environs.

It will also help you cut down on ads spending because you own the right keyword Clients are searching for.

You can decide to redirect the domain to your current website to attract more targeted prospect and generate more leads.

Price: $599 (one time purchase).

If you're interested in this opportunity, kindly visit www.FulfillmentMissouri.com to buy now.

Best Regards,
Domain expert.

"""

def send_email(to_address):
    try:
        msg = MIMEMultipart()
        msg['From'] = email_user
        msg['To'] = to_address
        msg['Subject'] = subject

        msg.attach(MIMEText(body, 'plain'))

        server = smtplib.SMTP(smtp_server, smtp_port)
        server.starttls()
        server.login(email_user, email_password)
        text = msg.as_string()
        server.sendmail(email_user, to_address, text)
        server.quit()
        print(f"Email sent to {to_address}")
    except Exception as e:
        print(f"Failed to send email to {to_address}. Error: {e}")

# Send emails
for index, row in email_df.iterrows():
    send_email(row['email'])
    time.sleep(1)  # Add a 1-second delay between each email

print("All emails sent.")
