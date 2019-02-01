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

4. Visit your Twitter account page and request your archive, later following the link in the email you receive.
5. Download the archive, unpack and.

## How do I start? ##

Checkout this repo, ```bundle install``` and then in lib run ``` ruby tweet_delete ```.
You can test with ```rspec```. I like to limit deletion to 50 tweets at a time. But you can
set your own limit by modifying ```BATCH_SIZE``` in ```DeletionRecorder```.

## Dependencies ##

* Twitter
* Dotenv
