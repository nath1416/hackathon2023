#The Basic Setup
#Required Plugins
import pandas as pd
import requests

#Your New York Times API Key
api_key = 'pRJtt80jPVWh4eNj'

#Article of the comments you want to scrape
nyt_article = 'https://www.nytimes.com/2020/05/24/opinion/biden-trump-coronavirus.html'

#offset
offset = 0
your_query = "News"
#Request URL for comments
request_url = url = 'https://api.nytimes.com/svc/search/v2/articlesearch.json?q={your_query}&api-key={api_key}'

#request the data
r = requests.get(request_url)

#storing data into json format
json_data = r.json()

print(json_data)