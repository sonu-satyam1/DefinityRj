import json
import os

# Go up from libs → project root
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
# testdata folder under project root
TESTDATA_DIR = os.path.join(BASE_DIR, "testdata")
# final json file path
FILE = os.path.join(TESTDATA_DIR, "runtime_data.json")



def _read():
    if not os.path.exists(FILE):
        return {}
    with open(FILE, "r") as f:
        return json.load(f)


def _write(data):
    os.makedirs(TESTDATA_DIR, exist_ok=True)   # ensure folder exists
    with open(FILE, "w") as f:
        json.dump(data, f, indent=2)


class RuntimeData:

    def save_value(self, key, value):
        data = _read()
        data[key] = value
        _write(data)
        return value

    def get_value(self, key):
        data = _read()
        if key not in data:
            raise Exception(f"Runtime value not found for key: {key}")
        return data[key]

    def has_value(self, key):
        data = _read()
        return key in data

    def clear_all(self):
        _write({})

    def get_runtime_field_inside_object(self, object_key, field_key):
        obj = self.get_value(object_key)
        return obj.get(field_key)

    def update_object_field(self, object_key, field, value):
        """
        Update or add a field inside an object stored in runtime_data.json
        Example:
            RuntimeData.Update Object Field    TALENT    SSN    123456789
        """

        data = _read()

        obj = data.get(object_key)

        # if not exists or not a dict, create new dict
        if not isinstance(obj, dict):
            obj = {}

        # update / add field
        obj[field] = value

        # save back
        data[object_key] = obj
        _write(data)

        return value

