# Twitteraser #

A little script that allows you to bulk wipe tweets from your timeline. It's a handy
script for me but sadly now requires a Twitter Developer account.

## Why? ##

There are third-party services that do the same thing but run into this
constraint. Deleting archived tweets is a workaround.

## How do I setup? ##

1. Get a Twitter Developer account.
2. Create a Twitter app and set access permissions to read and write.
3. Find your keys, secret keys and access token. Make sure they're in your shell's environment. E.g.:

```
export TWITTER_CONSUMER_KEY="[your consumer key]"
export TWITTER_CONSUMER_SECRET="[your consumer secret]"
export TWITTER_ACCESS_TOKEN="[your access token]"
export TWITTER_ACCESS_TOKEN_SECRET="[your access token secret]"
```

You'll then need to checkout this repo, ```bundle install```, and grab credentials from Twitter (look at ```TweetDeleter``` to see how you need your environment configured). Run tests with: ```rspec```.

The program's expecting a JSON file at the project root. That file should contain all archived tweets you wish to destroy. You'll need tweet IDs at the top-level of the JSON object but the rest is up to you. Like so:

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
