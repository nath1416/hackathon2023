import json
# Import database module.
import firebase_admin
import random
# from firebase_admin import db 
from firebase_admin import credentials
from firebase_admin import firestore

from aimain import  isAtricleGoodFromComments
 
# adding Folder_2 to the system path
# sys.path.insert(0, r'C:\Users\bougi\Documents\PolyTechnique-Montreal\Trimestre 2\Hackaton\hackathon2023\google_dataset')

COLLECTION_DB_AI = "sortedBetter"

def init_firebase():
    cred = credentials.Certificate("PrivateKey.json")

    firebase_admin.initialize_app(cred)
    global datab
    datab = firestore.client()

def send_database(dict_data:dict, collection:str, document:str):
    print(f"Sending {collection}{document}")
    datab.collection(collection).document(document).set(dict_data)

def get_comments_database():
    data_db = datab.collection("data")
    data_dcs = data_db.stream()

    for data in data_dcs:
        data_dic = data.to_dict()
        # print(type(data_dic))
        current_comments = []
        
        if data_dic["type"] == "NewsApi":
            #continue
            current_comments.append(data_dic["body"])
        else:
            continue
        # elif data_dic["type"] == "Reddit":
        #     for comment in data_dic["comments"]:
        #         if comment["body"].strip() != "":
        #             current_comments.append(comment["body"])

        print(current_comments)
        if isAtricleGoodFromComments(current_comments):
            print("Good News")
            
            send_database(data_dic, "sortedBetter1", str(random.getrandbits(128)))

def get_ai_approval(comments):
    pass


def main():
    init_firebase()
    get_comments_database()

if __name__ == "__main__":
    main()