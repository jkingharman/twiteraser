# Dependencies / lib code namespace.
module TweetDelete; end

require 'dotenv/load'
require 'twitter'
require 'json'
require 'pry'

require_relative 'tweet_delete/delete_tweet_service'
require_relative 'tweet_delete/deletion_recorder'
require_relative 'tweet_delete/tweet_deleter'
# 
# TweetDelete::DeleteTweetService.new.call
