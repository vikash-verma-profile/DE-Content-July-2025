import re

# Sample data
customers = [
    {"name": "john doe", "email": "john.doe@example.com", "phone": "9876543210"},
    {"name": "jane smith", "email": "janesmith@company", "phone": "1234567890"},
    {"name": "mike", "email": "mike@example.com", "phone": "8123456789"},
    {"name": "emma watson", "email": "emma.watson@sample.com", "phone": "6789012345"},
]

email_pattern = r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$'
phone_pattern = r'^[789]\d{9}$'

valid_emails = []
invalid_emails = []
valid_phones = []
invalid_phones = []

# Convert names to title case
for customer in customers:
    customer["name"] = customer["name"].title()

# Validate emails and phones
for customer in customers:
    email = customer["email"]
    phone = customer["phone"]

    if re.match(email_pattern, email):
        valid_emails.append(email)
    else:
        invalid_emails.append(email)

    if re.match(phone_pattern, phone):
        valid_phones.append(phone)
    else:
        invalid_phones.append(phone)

# Filter customers by domain
example_customers = list(filter(lambda c: c['email'].endswith("@example.com"), customers))

# Summary
print("=== Cleaned Customer Records ===")
for c in customers:
    print(c)

print("\n=== Summary ===")
print(f"Valid Emails: {len(valid_emails)}")
print(f"Invalid Emails: {len(invalid_emails)}")
print(f"Valid Phone Numbers: {len(valid_phones)}")
print(f"Invalid Phone Numbers: {len(invalid_phones)}")

print("\n=== Customers with @example.com ===")
for ec in example_customers:
    print(ec)
       