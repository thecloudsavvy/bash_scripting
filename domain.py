import smtplib
import pandas as pd
import time
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

# Load email addresses from CSV
email_df = pd.read_csv('email.csv')

# Email content
subject = "Oakland Design Build"
body = """
Hello,

I hope this finds you well. I am reaching out to you with an exciting opportunity to acquire a premium domain OaklandDesignBuild.com that aligns perfectly with your business.

This domain contains highly searched keywords which fits perfectly with your area of practice and the real value of the domain is that it defines your service in Oakland, CA and surrounding environs.

It will also help you cut down on ads spending because you own the right keyword prospects are searching for.

You can decide to redirect the domain to your current website or build another website on it to further capture more targeted prospects.

Price: $499 (one time purchase).

If you're interested in this opportunity, kindly visit www.OaklandDesignBuild.com to buy now.

Best Regards,
Domain expert.
"""

def send_email(to_addresses):
    try:
        msg = MIMEMultipart()
        msg['From'] = email_user
        msg['To'] = ", ".join(to_addresses)
        msg['Subject'] = subject

        msg.attach(MIMEText(body, 'plain'))

        server = smtplib.SMTP(smtp_server, smtp_port)
        server.starttls()
        server.login(email_user, email_password)
        text = msg.as_string()
        server.sendmail(email_user, to_addresses, text)
        server.quit()
        print(f"Email sent to {', '.join(to_addresses)}")
    except Exception as e:
        print(f"Failed to send email to {', '.join(to_addresses)}. Error: {e}")

# Send emails
hourly_limit = 200
batch_size = 50
emails_sent = 0

for i in range(0, len(email_df), batch_size):
    batch = email_df[i:i+batch_size]['email'].tolist()
    send_email(batch)
    emails_sent += len(batch)
    time.sleep(1)  # Add a 1-second delay between each batch

    # Check if the hourly limit is reached
    if emails_sent >= hourly_limit:
        print("Hourly limit reached. Pausing for an hour.")
        time.sleep(3600)  # Sleep for 1 hour
        emails_sent = 0  # Reset the counter

print("All emails sent.")
