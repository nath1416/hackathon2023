import firebase_admin
from firebase_admin import db
import json
import os

def init_database():
    cred_obj = firebase_admin.credentials.Certificate("./api/PrivateKey.json")
    default_app = firebase_admin.initialize_app(cred_obj, {'databaseURL':"https://gudz-a5d02-default-.firebaseio.com"})

# def push_root(reference_path:str, data:json):
#     ref = db.reference(reference_path)

#     with open("book_info.json", "r") as f:
#         file_contents = json.load(f)
#         ref.set(file_contents)


def open_multiples_json(paths:list):
    reference_db = db.reference("/data")
    for path in paths:
        for file in os.listdir(path):
            print(f"Sending files: {path}{file}")
            with open(f"{path}{file}", "r") as f:
                file_contents = json.load(f)
            reference_db.set(file_contents)

def main():
    print("Starting...")
    list_path = ["./database/NewsApi/", "./database/Reddit/"]
    init_database()
    open_multiples_json(list_path)

if __name__ == "__main__":
    main()