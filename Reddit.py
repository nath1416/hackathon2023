import praw
import json
from api.main import postComments


def init_reddit()->praw.Reddit:
    reddit = praw.Reddit(
        client_id="MINjKw8pg7Rw5fxIiIxQAg",
        client_secret="QKQ66wzR22JPX3n5MRLGEsNoylJYow",
        user_agent="Hackathon",
    )
    return reddit

def get_comments_submissions(reddit:praw.Reddit,id_post:str, limit_comments:int = 10) -> list:
    print(f"Post Id: {id_post}")
    print(f"Comments limit: {limit_comments}")

    print(f"Getting comments...")
    submission = reddit.submission(id=id_post)
    submission.comment_limit = limit_comments
    submission.comments.replace_more(limit=0)
    submission.comment_sort = "top"
    top_level_comment = submission.comments.list()
    # submission.comments.replace_more(limit=None)
    # submission.comment_sort = "top"
    # top_level_comment = submission.comments.list(limit=limit_comments)

    comments = []
    for index, top_level_comment in enumerate(submission.comments):
        if index == limit_comments:
            break

        print(f"{index}-Getting Comments...")
        comment = {}
        comment["Body"] = filter_body(top_level_comment.body)
        comments.append(comment)
    return comments

def filter_body(body_content:str):
    return ''.join(list(filter(lambda x: x.isalpha() or x.isnumeric() or x == " ", body_content)))

def get_post_from_subreddit(reddit:praw.Reddit, sub_reddit_name:str, limit_post:int = 5):
    print(f"Getting Post from {sub_reddit_name}")
    print(f"Nb Post: {limit_post}")
    data = {}

    data["Sub Reddit"] = sub_reddit_name

    sub_reddit = reddit.subreddit(sub_reddit_name)

    posts = []
    for index, post in enumerate(sub_reddit.hot(limit=limit_post)):
        print(f"{index}-Getting Post")

        if post.num_comments == 0:
            continue
        post_data = {}
        
        post_data = {}
        post_data["Title"] = f"r/{sub_reddit_name}"
        post_data["Url"] = post.url
        post_data["Body"] = filter_body(post.title)
        post_data["Id"] = post.id
        post_data["NbComment"] = post.num_comments
        post_data["Comments"] = get_comments_submissions(reddit, post.id, 5)
        posts.append(post_data) 

    data["Post"] = posts

    return data

def generate_json_file(file_name:str, data_dict:dict, directory:str):
    out_file = open(f"{directory}{file_name}.json", "w")
    json.dump(data_dict, out_file, indent=2)
    out_file.close()

def get_multiple_subreddit(reddit:praw.Reddit):
    get_new_subreddit = True

    while get_new_subreddit:
        subreddit_name = None

        while subreddit_name == None:
            subreddit_name = input("Enter subreddit name: ") or None
        
        nb_post = int(input("Enter number of post to scrape (5): ") or 5)
        
        data_dict = get_post_from_subreddit(reddit, subreddit_name, nb_post)
        generate_json_file(f"Data-{subreddit_name}", data_dict, "./database/")

        get_new_subreddit = (input("Continue scrapping? (Y/N): ").lower() == "y") or False


def main():    
    subreddit_name = "news"

    reddit = init_reddit()
    data_dict = get_post_from_subreddit(reddit, subreddit_name, 3)
    generate_json_file(f"Data-{subreddit_name}", data_dict)


def post_database():

    file = open("Data-news.json")
    #tmp = file.json()
    #print(tmp)
    json_obj = json.load(file)
    
    postComments(1, json_obj)

if __name__ == "__main__":
    reddit = init_reddit()
    get_multiple_subreddit(reddit)
    main()
    #post_database()