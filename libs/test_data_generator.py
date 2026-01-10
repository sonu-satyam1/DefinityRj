from datetime import datetime
import random
import string

class TestDataGenerator:

    def generate_random_email(self, prefix="testuser", domain="example.com"):
        ts = datetime.now().strftime("%Y%m%d%H%M%S")
        return f"{prefix}_{ts}@{domain}"

    def generate_random_mobile(self, length=10):
        return ''.join(random.choices(string.digits, k=length))

    def generate_unique_name_details(self, first_name="Test"):
        ts = datetime.now().strftime("%Y%m%d%H%M%S")
        last_name = ts
        full_name = f"{first_name} {last_name}"
        return first_name, last_name, full_name
