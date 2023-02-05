import firebase_admin
import random
# from firebase_admin import db 
from firebase_admin import credentials
from firebase_admin import firestore

from aimain import  isAtricleGoodFromComments
 

def init_firebase():
    cred = credentials.Certificate("PrivateKey.json")

    firebase_admin.initialize_app(cred)
    global datab
    datab = firestore.client()

def send_database(dict_data:dict, collection:str, document:str):
    print(f"Sending {collection}{document}...")
    datab.collection(collection).document(document).set(dict_data)

def get_comments_database():
    data_db = datab.collection("data")
    data_dcs = data_db.stream()
    file_history = open("exploredData.txt", "r+")

    for data in data_dcs:
        data_dic = data.to_dict() 
        # print(type(data_dic))
        current_comments = []
        
        if str(data_dic["title"]) in file_history.read():
            continue

        if data_dic["type"] == "NewsApi" :
            #continue
            file_history.write(data_dic["title"] + "\n")
            current_comments.append(data_dic["body"])
        else:
            continue
        # elif data_dic["type"] == "Reddit":
        #     file.write(data_dic["title"])
        #     for comment in data_dic["comments"]:
        #         if comment["body"].strip() != "":
        #             current_comments.append(comment["body"])

        print(current_comments)
        (categorie, percent) = isAtricleGoodFromComments(current_comments)
        if categorie != "" and percent > 0.70:
            print(f"Good News: {categorie} with : {percent}")
            
            data_dic["categorie"] = categorie
            data_dic["percent"] = percent
            send_database(data_dic, "sortedBetter4", str(random.getrandbits(128)))



def main():
    init_firebase()
    get_comments_database()

if __name__ == "__main__":
    main()