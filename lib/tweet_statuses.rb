require "json"
# how to handle a call to record deletes before tweets in memory?
class TweetStatuses
  PATH_TO_TWEETS = "../tweets.json".freeze

  def initialize(file: File)
    @file = file
  end

  def to_delete
    file = read_tweets
    validate_tweets(file)
    tweets_to_delete
  end

  def record_deletes(ids)
    update_deleted_tweets(ids)
    write_tweets
  end

  private

  def read_tweets
    puts "Reading archived tweets.."
    File.read(PATH_TO_TWEETS)
  rescue Errno::ENOENT => e
    puts "Unable to read file: #{e}"
    exit
  end

  def validate_tweets(file)
    self.tweets = JSON.parse(file)
  rescue JSON::ParserError => e
    puts "Unable to parse tweets: #{e}"
    exit
  end

  def tweets_to_delete
    tweets.keys.reject { |k| k == "deleted" }.first(15).map(&:to_i)
  end

  def update_deleted_tweets(ids)
    puts "Recording tweets #{ids} as deleted"
    ids.each { |id| tweets[id] = "deleted" }
  end

  def write_tweets
    File.write(PATH_TO_TWEETS, tweets)
  end

  attr_reader :file
  attr_accessor :tweets
end
