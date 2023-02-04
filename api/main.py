import requests
import json


def getComments():
    url = "https://gud-2023-default-rtdb.firebaseio.com/Post.json"
    response = requests.get(url)
    data = response.json()

    comments = []

    for i in range(len(data)):
        for j in range(len(data[i]['Comments'])):
            comments.append(data[i]["Comments"][j]["Body"])

    return comments


comments = getComments()
with open('data.json', 'w') as outfile:
    json.dump(comments, outfile)


def postComments(id: int, body: str):
    url = f"https://gud-2023-default-rtdb.firebaseio.com/Post{id}.json"
    payload = json.dumps(body)
    headers = {
        'Content-Type': 'application/json'
    }
    response = requests.request("POST", url, headers=headers, data=payload)
    print(response.text.encode('utf8'))
    

    