
from bs4 import BeautifulSoup
from urllib.request import urlopen
import json


API_KEY = "5f74ffb5db5443ccb5c7910cb57095e2"

FIELDS = ["iframe"]

def web_scrapper(url:str)->bytes:
    with urlopen(url) as response:
        body = response.read()

    return body

def create_json(html_doc, soup):
    dict_data = {}
    for elem in FIELDS:
        dict_data[elem] = soup.find(id="dsq2")
        print(soup.select("#dsq2"))

    print(dict_data)
    json_obj = json.dumps(dict_data)

    return json_obj



def main():
    html_doc = web_scrapper("http://www.cnn.com/2013/09/24/politics/un-obama-foreign-policy/")
    soup = BeautifulSoup(html_doc, 'html.parser')
    print(create_json(html_doc, soup))
    
    
    

if __name__ == "__main__":
    main()
    