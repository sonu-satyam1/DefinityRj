# TestDataLibrary.py

import random

def get_variables():
    random_tag_number = random.randint(1, 9999)
    random_rate = random.randint(1, 100)
    random_ssn = random.randint(100000000, 999999999)  # 9-digit number
    address1 = f'Cincinnati{random_tag_number}'
    city = f'Bangalore{random_tag_number}'
    newly_added_skill = f'Skill {random_tag_number}'
    last_name = random_tag_number
    email = f'UIAuto{random_tag_number}@gmail.com'
    phone = random.randint(1000000000, 9999999999)  # 10-digit phone number
    zip_code = random.randint(10000, 99999)           # 5-digit ZIP code
    experience = random.randint(1, 10)
    time_in =  random.randint(1, 5)
    view_name = f'view{random_tag_number}'
    return {
        'new_tag_bulk_edit': f'Test{random_tag_number}',
        'regular_rate': random_rate,
        'ssn': random_ssn,
        'address1':address1,
        'last_name' : last_name,
        'city':city,
        'email':email,
        'phone': phone,
        'zip': zip_code,
        'experience': experience,
        'hours': experience,
        'time_in': time_in,
        'newly_added_skill':newly_added_skill,
        'view_name':view_name

    }


