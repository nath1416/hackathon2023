from newsapi import NewsApiClient
import json


API_KEY = '5f74ffb5db5443ccb5c7910cb57095e2'
DIRECTORY_DATABASE = "./database/NewsApi/"

def filter_strings(body_content:str):
    return ''.join(list(filter(lambda x: x.isalpha() or x.isnumeric() or x == " ", body_content)))

def init_newsapi()->NewsApiClient:
    newsapi = NewsApiClient(api_key=API_KEY)
    return newsapi

def get_articles(newsapi:NewsApiClient ,subject:str):
    all_articles = newsapi.get_everything(q=subject, sort_by='relevancy')
    return all_articles

def convert_json(data):
    json_obj = json.dumps(data, indent=4)
    return json_obj

def parse_articles(data_json):
    nb_articles = data_json["totalResults"]
    articles = data_json["articles"]
    print(f"Number Articles found: {nb_articles}")
    
    lst_articles = data_json["articles"]

    print(f"Range: {len(lst_articles)}")
    data = {}
    data["Source"] = "NewsApi"

    articles = []

    for article in lst_articles:
        article_data = {}
        article_data["Title"] = filter_strings(article["title"])
        article_data["Description"] = filter_strings(article["description"])
        article_data["Url"] = article["url"]
        article_data["UrlImage"] = article["urlToImage"]
        articles.append(article_data)
    data["Post"] = articles
    return data
    
def generate_json_file(file_name:str, data_dict:dict, directory:str):
    out_file = open(f"{directory}{file_name}.json", "w")
    json.dump(data_dict, out_file, indent=2)
    out_file.close()

def get_multiple_articles(newsapi):
        subject_search = None
        continue_scrapping = True

        while continue_scrapping:
            while subject_search == None:
                subject_search = input("Enter News name: ") or None

            data_json_articles = get_articles(newsapi=newsapi,subject= subject_search)
            new_data = parse_articles(data_json_articles)
            generate_json_file(f"Data-{subject_search}", new_data, f"{DIRECTORY_DATABASE}")

            user_input = input("Continue scrapping? (Y/N): ").lower() == "y"
            if user_input == None:
                user_input = False
            continue_scrapping = user_input
            subject_search = None

def main():
    newsapi = init_newsapi()

    subject_search = "Good News"
    data_json_articles = get_articles(newsapi=newsapi,subject= subject_search)
    #data_json_string = convert_json(data_json_articles)
    new_data = parse_articles(data_json_articles)
    generate_json_file(f"Data-{subject_search}", new_data, f"{DIRECTORY_DATABASE}")


if __name__ == "__main__":
    #main()
    newsapi = init_newsapi()
    get_multiple_articles(newsapi)