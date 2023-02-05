import json
# Import database module.
import firebase_admin
# from firebase_admin import db 
from firebase_admin import credentials
from firebase_admin import firestore

cred = credentials.Certificate("api/PrivateKey.json")

firebase_admin.initialize_app(cred)
datab = firestore.client()
types_obj = datab.collection("data")

types = types_obj.stream()

for type in types:
    print(type.id)
    print(type.to_dict())
print("End")


# # Read the data at the posts reference (this is a blocking operation)
# print(ref.get())


# def init_firebase():
#     cred = credentials.Certificate("api/PrivateKey.json")

#     firebase_admin.initialize_app(cred)
#     global db
#     db = firestore.client()

# def  get_comments_database():
#     database = db.reference("/data")
#     all_data = database.get()
#     print(len(all_data))

# def main():
#     init_firebase()
#     get_comments_database()

# if __name__ == "__main__":
#     main()