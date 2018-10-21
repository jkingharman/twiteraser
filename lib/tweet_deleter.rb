class TweetDeleter
  def initialize(
    client: Twit,
    tweet_statuses: TweetStatuses.new
  )
    @client = client
    @tweet_statuses = tweet_statuses
    @retries = 0
  end

  def delete_all(ids)
    # loop over the ids handed in.
    # find a way to batch (ten at a time)
  end

  private

  attr_accessor :retries
  attr_reader :client, :tweet_statuses

  def batch_delete
    deletes = tweet_statuses.to_delete.map { |id| delete(id) }
    ids = deletes.flatten.map(&:id)
    tweet_statuses.record_deletes(ids)
  end

  def delete(id)
    client.destroy(id)
  rescue Twitter::Error::NotFound => e
    puts "Tweet #{id} not found"
  rescue HTTP::ConnectionError => e
    puts "Connection error. Restart the process"; exit
  rescue Twitter::Error::TooManyRequests => e
    puts "Rate limit exceeded."
    sleep e.rate_limit.reset_in + 1
    try_retry
  end

  def try_retry
    self.retries += 1
    if retries <= 4
      retry
    else
      puts "At risk of blacklisting"; exit
    end
  end
end
