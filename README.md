# Twitteraser #

A little program for batch deleting tweets.

## To use ##

```
git clone https://github.com/jkingharman/twitteraser.git
```

You'll then need to checkout this repo, ```bundle install```, and grab credentials from Twitter (look at ```TweetDeleter``` to see how you need your environment configured). Run tests with: ```rspec```.

The program's expecting a JSON file at the project root. That file should contain all archived tweets you wish
to destroy. You'll need tweet IDs at the top-level of the JSON object but the rest is up to you. Like so:

```
{
  "id": "any other tweet date here",
  "id": "any other tweet date here",
  "id": "any other tweet data here"
}

```

## What it does ##

Deletes you tweets in loads of 50. In lib, running ``` ruby tweet_delete ``` starts us off. Your archived tweets will be read and their IDs sent to Twitter for deletion. On success, the JSON gets updated (the deleted tweet is marked). If you need to restart already deleted tweets get ignored.

## Dependencies ##

* twitter
* dotenv
