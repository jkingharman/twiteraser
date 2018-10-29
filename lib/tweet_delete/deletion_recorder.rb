module TweetDelete
  # A class that tracks what tweets have been deleted - useful because you may
  # need to resume the bulk deletion if it errors. The class updates a JSON
  # representation of tweets on deletion. It reads in that representation to
  # find the next batch to delete.
  class DeletionRecorder
    PATH_TO_TWEETS = '../tweets.json'.freeze
    BATCH_SIZE = 50
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
      puts 'Reading archived tweets..'
      File.read(PATH_TO_TWEETS)
    rescue Errno::ENOENT => e
      abort "Unable to read file: #{e}"
    end

    def validate_tweets(file)
      self.tweets = JSON.parse(file)
    rescue JSON::ParserError => e
      abort "Unable to parse tweets: #{e}"
    end

    # Returns undeleted tweet IDs.
    def tweets_to_delete
      tweets.keys.reject { |k| k =~ /deleted/ }.first(BATCH_SIZE).map(&:to_i)
    end

    # Mungs tweet IDs, marking them as deleted.
    def update_deleted_tweets(ids)
      puts "Recording tweets #{ids} as deleted"
      ids.each { |id| tweets["deleted_#{id}"] = tweets.delete id.to_s }
    end

    def write_tweets
      File.write(PATH_TO_TWEETS, tweets.to_json)
    end

    attr_reader :file
    attr_accessor :tweets
  end
end
