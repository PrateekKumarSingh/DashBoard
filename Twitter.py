# python -m pip install tweepy
# http://docs.tweepy.org/en/v3.6.0/
import tweepy
import sys, json
from tweepy import Stream
from tweepy.auth import OAuthHandler
from tweepy.streaming import StreamListener

search_word = sys.argv[1] 
consumer_key = sys.argv[2]
consumer_secret = sys.argv[3]
token = sys.argv[4]
token_secret = sys.argv[5]

auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(token, token_secret)

api = tweepy.API(auth)

s = [tweet._json for tweet in tweepy.Cursor(api.search,q=search_word, count=100,rpp=10,result_type="recent",include_entities=True,lang="en").items()]
for json_obj in s:
    print(json.dumps(json_obj))
