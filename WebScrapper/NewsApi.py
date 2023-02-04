from newsapi import NewsApiClient
import json


API_KEY = '5f74ffb5db5443ccb5c7910cb57095e2'

def init_newsapi()->NewsApiClient:
    newsapi = NewsApiClient(api_key=API_KEY)
    return newsapi

def get_articles(newsapi:NewsApiClient ,subject:str):
    all_articles = newsapi.get_everything(q=subject)
    return all_articles

def convert_json(data):
    json_obj = json.dumps(data, indent=4)
    return json_obj

def get_status_code(data_json):

    
    nb_articles = data_json["totalResults"]
    articles = data_json["articles"]
    print(f"Number Articles found: {nb_articles}")
    
    lst_articles = data_json["articles"]

    print(f"Range: {len(lst_articles)}")

    for article in lst_articles:

        author = article["author"]
        title = article["title"]

        print(f"Titles: {title}")

def dump_json_file(data_json, file_name):
   file1 = open(file_name, "w")
   file1.write(str(data_json))


def main():
    newsapi = init_newsapi()

    subject_search = "Good News"
    data_json_articles = get_articles(newsapi=newsapi,subject= subject_search)
    data_json_string = convert_json(data_json_articles)
    dump_json_file(data_json_string, f"Data-{subject_search}.json")
    get_status_code(data_json_articles)

    # print(data_json)

if __name__ == "__main__":
    main()