# Twitteraser #

A little script that allows you to bulk wipe tweets from your timeline. It's a handy
script for me but sadly now requires a [Twitter Developer](https://developer.twitter.com/en/dashboard) account.

## How do I setup? ##

1. Get a Twitter Developer account.
2. Create a [Twitter app](https://developer.twitter.com/en/apps/create) and set access permissions to read and write.
3. Find your keys, secret keys and access token. Make sure they're in your shell's environment. E.g.:

```
export TWITTER_CONSUMER_KEY="[your consumer key]"
export TWITTER_CONSUMER_SECRET="[your consumer secret]"
export TWITTER_ACCESS_TOKEN="[your access token]"
export TWITTER_ACCESS_TOKEN_SECRET="[your access token secret]"
```

4. Visit your Twitter [account page](https://twitter.com/settings/account) and request your archive, later following the link in the email you receive.
5. Download the archive and locate whatever tweets you want to delete by year and month, as show here:

![alt text](https://user-images.githubusercontent.com/24657744/52166066-8b2d5d00-2700-11e9-8183-3f5c060702d7.png)

6. Checkout this repo and move the located tweets into its root, stripping the first line of the tweet file. (As the archive email says, this is necessary to consume that file as JSON.)

## How do I start? ##

You first ```bundle install``` and then in lib run ``` ruby tweet_delete ```.
You can test with ```rspec```. I like to limit deletion to 50 tweets at a time. But you can
set your own limit by modifying ```BATCH_SIZE``` in ```DeletionRecorder```.

## Dependencies ##

* Twitter
* Dotenv
