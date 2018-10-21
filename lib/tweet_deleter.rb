class TweetDeleter
  def initialize(client: TwitterClient.client)
    @client = client
  end

  def delete_all(ids)
  end

  private

  attr_reader :client

  def delete(id)
    # Make post request here.
  end
end
